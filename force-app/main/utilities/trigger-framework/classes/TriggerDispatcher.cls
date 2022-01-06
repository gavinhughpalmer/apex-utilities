/**
 * @author Gavin Palmer
 * @date 2020-11-18
 * @group Trigger Framework
 * @description This trigger dispatcher will be called from each trigger with a list of triggerable actions to perform.
 *  As the single point of entry for all triggers this class will manage the disabling and enabling of triggers, as well as tracking the stack of triggers
 *
 **/
public with sharing class TriggerDispatcher {
    private static final Stack TRIGGER_STACK = new Stack();
    private static Boolean unknownExceptionLogged = false;
    private static final Set<String> DISABLED_TRIGGERS = new Set<String>();

    private final Triggerable handler;
    private final List<SObject> newSObjects;
    private final Map<Id, SObject> oldMap;
    private final String currentTriggerAction;
    private final Logger log = LoggerFactory.createLogger(TriggerDispatcher.class);

    @SuppressWarnings('PMD.ExcessiveParameterList')
    @TestVisible
    private TriggerDispatcher(
        List<Triggerable> actions,
        List<SObject> newSObjects,
        Map<Id, SObject> oldMap,
        TriggerOperation operation
    ) {
        this.handler = new TriggerHandler(actions);
        // default the map to the old map for delete triggers
        this.newSObjects = newSObjects == null ? oldMap.values() : newSObjects;
        this.oldMap = oldMap;
        this.currentTriggerAction = getTriggerAction(newSObjects.getSObjectType(), operation);
    }

    // Will be difficult to get coverage directly for this method instead we will use the constructor directly
    public static void run(List<Triggerable> actions) {
        (new TriggerDispatcher(actions, Trigger.new, Trigger.oldMap, Trigger.operationType)).run();
    }

    public static void disable(SObjectType objectType, TriggerOperation operation) {
        DISABLED_TRIGGERS.add(getTriggerAction(objectType, operation));
    }

    public static void enable(SObjectType objectType, TriggerOperation operation) {
        DISABLED_TRIGGERS.remove(getTriggerAction(objectType, operation));
    }

    private static String getTriggerAction(SObjectType objectType, TriggerOperation operation) {
        return (operation + '-' + objectType).toUpperCase();
    }

    public void run() {
        if (triggersAreActive()) {
            try {
                TRIGGER_STACK.push(currentTriggerAction);
                executeTriggerables();
                TRIGGER_STACK.pop(); // pop in here so errors will get handled
            } catch (Stack.UnderflowException underflowException) {
                logUnknownException('Stack underflow');
                throw underflowException; // Surface up to users
            } catch (Exception exceptionToHandle) {
                TRIGGER_STACK.pop(); // it wasn't popped
                logUnknownException(exceptionToHandle.getMessage());
                throw exceptionToHandle;
            } finally {
                if (TRIGGER_STACK.isEmpty()) {
                    log.close();
                }
            }
        }
    }

    private void executeTriggerables() {
        for (SObject newSObject : newSObjects) {
            // ensure we don't get any null pointer issues in inserts
            SObject oldSObject = oldMap != null ? oldMap.get(newSObject.Id) : null;
            SObjectTriggerWrapper wrappedSObject = new SObjectTriggerWrapper(
                newSObject,
                oldSObject
            );
            handler.register(wrappedSObject);
        }
        handler.performAction();
    }

    private Boolean triggersAreActive() {
        return ConfigurationManager.getInstance().areTriggersOn() &&
            !DISABLED_TRIGGERS.contains(currentTriggerAction);
    }

    private void logUnknownException(String exceptionMessage) {
        // Only write the logs the first time an unknown exception is thown, the exception will then get thrown all the way up the stack
        if (!unknownExceptionLogged) {
            log.error(
                'Unhandled exception within trigger: ' +
                exceptionMessage +
                '\n' +
                'Trigger Stack: ' +
                TRIGGER_STACK.toString()
            );
            unknownExceptionLogged = true;
        }
    }
}
