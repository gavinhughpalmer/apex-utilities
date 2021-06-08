/**
 * @author Gavin Palmer
 * @date 2018-06-28
 * @group Trigger Framework
 * @description This class is a grouping of Triggerable actions so that they can be executed as one
 *
 **/
public inherited sharing class TriggerHandler extends Triggerable {
    private final List<Triggerable> triggerActions;

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
}
