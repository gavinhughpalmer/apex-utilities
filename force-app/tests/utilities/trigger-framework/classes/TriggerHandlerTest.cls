/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 *
 * @date 2020-11-20
 **/
@IsTest(isParallel=true)
private class TriggerHandlerTest {
    private class TestTriggerAction extends Triggerable {
        public Boolean registerWasCalled = false;
        public Boolean performActionsWasCalled = false;
        public override void register(SObjectTriggerWrapper wrappedSObject) {
            registerWasCalled = true;
        }
        public override void performAction() {
            performActionsWasCalled = true;
        }
    }

    @IsTest
    private static void registerTest() {
        TestTriggerAction mockAction = new TestTriggerAction();

        TriggerHandler handler = new TriggerHandler(new List<Triggerable>{ mockAction });
        handler.register(null);
        System.assert(
            mockAction.registerWasCalled,
            'The register method was not called in the Triggerable'
        );
    }

    @IsTest
    private static void performActionTest() {
        TestTriggerAction mockAction = new TestTriggerAction();

        TriggerHandler handler = new TriggerHandler(new List<Triggerable>{ mockAction });
        handler.performAction();
        System.assert(
            mockAction.performActionsWasCalled,
            'The performAction method was not called in the Triggerable'
        );
    }
}
