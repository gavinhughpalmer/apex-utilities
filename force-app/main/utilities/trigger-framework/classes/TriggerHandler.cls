/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
* @description This trigger handler will be called from each trigger with a list of triggerable actions to perform,
* the class also implements the Triggerable interface so that logical groupings of triggerables can be made and reused
* accross triggers, the performAllActions method allows a single line to be added to each trigger
*
* 2018-06-28 : Gavin Palmer - Original
**/
public inherited sharing class TriggerHandler extends Triggerable {

    private final List<Triggerable> triggerActions;
    private final Logger log = LoggerFactory.createLogger(TriggerHandler.class);

    public TriggerHandler(List<Triggerable> triggerActions) {
        this.triggerActions = triggerActions;
    }

    public override void register(SObjectTriggerWrapper wrappedSObject) {
        for (Triggerable action : triggerActions) {
            action.register(wrappedSObject);
        }
    }

    public override void performAction() {
        for (Triggerable action : triggerActions) {
            action.performAction();
        }
    }

    public static void performAllActions(List<Triggerable> actions, List<SObject> newSObjects, Map<Id, SObject> oldMap) {
        if (ConfigurationManager.getInstance().areTriggersOn()) {
            Triggerable handler = new TriggerHandler(actions);
            // default the map to the old map for delete triggers
            newSObjects = newSObjects == null ? oldMap.values() : newSObjects;
            for (SObject newSObject : newSObjects) {
                // ensure we don't get any null pointer issues in insets
                SObject oldSObject = oldMap != null ? oldMap.get(newSObject.Id) : null;
                SObjectTriggerWrapper wrappedSObject = new SObjectTriggerWrapper(newSObject, oldSObject);
                handler.register(wrappedSObject);
            }
            handler.performAction();
            log.close();
        }
    }
}
