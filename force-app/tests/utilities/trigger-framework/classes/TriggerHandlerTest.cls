/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description Test class for the TriggerHandler Class
 *
 * 2018-06-28 : Gavin Palmer - Original
 **/
@IsTest
private class TriggerHandlerTest {
    // TODO Move over to dispatcher

    // private class TestTriggerAction extends Triggerable {
    //     private final Boolean isAllowedRegister;
    //     private final List<SObject> registeredSObjects = new List<SObject>();
    //     private final List<Boolean> runList;

    //     public TestTriggerAction(Boolean isAllowedRegister, List<Boolean> runList) {
    //         this.isAllowedRegister = isAllowedRegister;
    //         this.runList = runList;
    //     }
    //     public override void register(SObjectTriggerWrapper wrappedSObject) {
    //         if (isAllowedRegister) {
    //             registeredSObjects.add(wrappedSObject.getSObject());
    //         }
    //     }
    //     public override void performAction() {
    //         runList.add(true);
    //     }
    // }

    // TODO Move to dispatcher
    // @IsTest
    // private static void performAllActionsTest() {

    //     List<Boolean> runList = new List<Boolean>();
    //     TestTriggerAction allowedRegisterTriggerable = new TestTriggerAction(true, runList);
    //     TestTriggerAction notAllowedRegisterTriggerable = new TestTriggerAction(false, runList);

    //     TriggerHandler.performAllActions(
    //         new List<Triggerable>{
    //             allowedRegisterTriggerable,
    //             notAllowedRegisterTriggerable
    //         },
    //         new List<Account>{new Account()},
    //         new Map<Id, Account>{null => new Account()}
    //     );

    //     System.assertEquals(
    //         1, allowedRegisterTriggerable.registeredSObjects.size(),
    //         'One SObject should have been added if when register is called'
    //     );

    //     System.assertEquals(
    //         0, notAllowedRegisterTriggerable.registeredSObjects.size(),
    //         'No SObject should have been added if when register is called'
    //     );

    //     System.assertEquals(
    //         2, runList.size(),
    //         'The run list should have been added to for the number of triggerables passed into the trigger handler'
    //     );
    // }
}
