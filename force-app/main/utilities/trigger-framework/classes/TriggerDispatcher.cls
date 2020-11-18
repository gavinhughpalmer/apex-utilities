/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description This trigger dispatcher will be called from each trigger with a list of triggerable actions to perform.
 *  As the single point of entry for all triggers this class will manage the disabling and enabling of triggers, as well as tracking the stack of triggers
 *
 * 2020-11-18 : Gavin Palmer - Original
**/
public with sharing class TriggerDispatcher {

    private static final Stack TRIGGER_STACK = new Stack();
    private static Boolean unknownExceptionLogged = false;

    private final Triggerable handler;
    private final List<SObject> newSObjects;
    private final Map<Id, SObject> oldMap;
    private final String currentTriggerAction;
    private final Logger log = new Logger(BulkLogObjectAdapter.getInstance('Trigger Dispatcher'));

    @SuppressWarnings('PMD.ExcessiveParameterList')
    private TriggerDispatcher(List<Triggerable> actions, List<SObject> newSObjects, Map<Id, SObject> oldMap, TriggerOperation operation) {
        this.handler = new TriggerHandler(actions);
        // default the map to the old map for delete triggers
        this.newSObjects = newSObjects == null ? oldMap.values() : newSObjects;
        this.oldMap = oldMap;
        this.currentTriggerAction = (operation + '-' + newSObjects.getSObjectType()).toUpperCase();
    }

    public static void run(List<Triggerable> actions) {
        (new TriggerDispatcher(actions, Trigger.new, Trigger.oldMap, Trigger.operationType)).run();
    }

    public void run() {
        if (triggersAreActive()) {
            TRIGGER_STACK.push(currentTriggerAction);
            try {
                executeTriggerables();
            } catch (Exception exceptionToHandle) {
                logUnknownException(exceptionToHandle.getMessage());
                throw exceptionToHandle;
            } finally {
                // Do we want to error handle this? Ie what gets popped off? and if an error occurs
                TRIGGER_STACK.pop();
                writeLogs();
            }
        }
    }

    private void executeTriggerables() {
        for (SObject newSObject : newSObjects) {
            // ensure we don't get any null pointer issues in insets
            SObject oldSObject = oldMap != null ? oldMap.get(newSObject.Id) : null;
            SObjectTriggerWrapper wrappedSObject = new SObjectTriggerWrapper(newSObject, oldSObject);
            handler.register(wrappedSObject);
        }
        handler.performAction();
    }

    private Boolean triggersAreActive() {
        // TODO include option to disable certain object triggers (could be metadata driven)
        return ConfigurationManager.getInstance().areTriggersOn();
    }

    private void logUnknownException() {
        // Only write the logs the first time an unknown exception is thown, the exception will then get thrown all the way up the stack
        if (!unknownExceptionLogged) {
            log.error(
                'Unhandled exception within trigger: ' + exceptionToHandle.getMessage() + '\n' +
                'Trigger Stack: ' + TRIGGER_STACK.toString()
            );
            unknownExceptionLogged = true;
        }
    }

    private void writeLogs() {
        // only write when we are at the bottom of the TRIGGER_STACK
        if (TRIGGER_STACK.isEmpty()) {
            BulkLogObjectAdapter.writeLogs();
        }
    }
}
