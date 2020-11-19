/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description This class is a grouping of Triggerable actions so that they can be executed as one
 *
 * 2018-06-28 : Gavin Palmer - Original
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
