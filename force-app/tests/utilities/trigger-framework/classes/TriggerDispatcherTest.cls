/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 *
 * @date 2018-06-28
 **/
@IsTest(isParallel=true)
private class TriggerDispatcherTest {
    private class TestTriggerAction extends Triggerable {
        private final Boolean isAllowedRegister;
        private final List<SObject> registeredSObjects = new List<SObject>();
        private final List<Boolean> runList;

        public TestTriggerAction(Boolean isAllowedRegister, List<Boolean> runList) {
            this.isAllowedRegister = isAllowedRegister;
            this.runList = runList;
        }
        public override void register(SObjectTriggerWrapper wrappedSObject) {
            if (isAllowedRegister) {
                registeredSObjects.add(wrappedSObject.getSObject());
            }
        }
        public override void performAction() {
            runList.add(true);
        }
    }

    @IsTest
    private static void runTest() {
        List<Boolean> runList = new List<Boolean>();
        TestTriggerAction allowedRegisterTriggerable = new TestTriggerAction(true, runList);
        TestTriggerAction notAllowedRegisterTriggerable = new TestTriggerAction(false, runList);

        TriggerDispatcher dispatcher = new TriggerDispatcher(
            new List<Triggerable>{ allowedRegisterTriggerable, notAllowedRegisterTriggerable },
            new List<Account>{ new Account() },
            new Map<Id, Account>{ null => new Account() },
            TriggerOperation.AFTER_UPDATE
        );
        dispatcher.run();

        System.assertEquals(
            1,
            allowedRegisterTriggerable.registeredSObjects.size(),
            'One SObject should have been added if when register is called'
        );

        System.assertEquals(
            0,
            notAllowedRegisterTriggerable.registeredSObjects.size(),
            'No SObject should have been added if when register is called'
        );

        System.assertEquals(
            2,
            runList.size(),
            'The run list should have been added to for the number of triggerables passed into the trigger handler'
        );
    }

    @isTest
    private static void disableEnableTest() {
        List<Boolean> runList = new List<Boolean>();
        TestTriggerAction allowedRegisterTriggerable = new TestTriggerAction(true, runList);

        TriggerOperation operation = TriggerOperation.AFTER_UPDATE;
        TriggerDispatcher dispatcher = new TriggerDispatcher(
            new List<Triggerable>{ allowedRegisterTriggerable },
            new List<Account>{ new Account() },
            new Map<Id, Account>{ null => new Account() },
            operation
        );
        TriggerDispatcher.disable(Account.getSObjectType(), operation);
        dispatcher.run();

        System.assertEquals(
            0,
            allowedRegisterTriggerable.registeredSObjects.size(),
            'No records should be added when the object and action are disabled'
        );

        TriggerDispatcher.enable(Account.getSObjectType(), operation);
        dispatcher.run();

        System.assertEquals(
            1,
            allowedRegisterTriggerable.registeredSObjects.size(),
            'a record should be added when the object and trigger actions are reenabled'
        );
    }

    private class ExceptionAction extends Triggerable {
        private final Exception exceptionToThrow;
        public ExceptionAction(Exception exceptionToThrow) {
            this.exceptionToThrow = exceptionToThrow;
        }
        public override void register(SObjectTriggerWrapper wrappedSObject) {
            throw exceptionToThrow;
        }
    }

    @SuppressWarnings('PMD.EmptyCatchBlock')
    @isTest
    private static void exceptionTest() {
        TriggerDispatcher dispatcher = new TriggerDispatcher(
            new List<Triggerable>{ new ExceptionAction(new DmlException()) },
            new List<Account>{ new Account() },
            new Map<Id, Account>{ null => new Account() },
            TriggerOperation.AFTER_UPDATE
        );
        Test.startTest();
        try {
            dispatcher.run();
            Assert.fail('An Exception should be thrown');
        } catch (DmlException expectedException) {
            // just check it runs as there is no message added so nothing to assert on
        } catch (Exception unexpectedException) {
            Assert.fail(
                'A more specific exception should be thrown. ' + unexpectedException.getMessage()
            );
        }
        Test.stopTest();

        List<Log__c> logsToAssert = [
            SELECT Messages__c
            FROM Log__c
            WHERE LeveL__c = :BulkLogObjectAdapter.ERROR
        ];
        System.assertEquals(1, logsToAssert.size(), 'One log message should have been created');
        System.assert(
            logsToAssert[0].Messages__c.startsWith('Unhandled exception'),
            'The log message thrown should start with Unhandled exception. Actual message: ' +
            logsToAssert[0].Messages__c
        );
    }

    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts,PMD.EmptyCatchBlock')
    @isTest
    private static void stackExceptionTest() {
        TriggerDispatcher dispatcher = new TriggerDispatcher(
            new List<Triggerable>{ new ExceptionAction(new Stack.UnderflowException()) },
            new List<Account>{ new Account() },
            new Map<Id, Account>{ null => new Account() },
            TriggerOperation.AFTER_UPDATE
        );
        try {
            dispatcher.run();
            Assert.fail('An Exception should be thrown');
        } catch (Stack.UnderflowException expectedException) {
            // just check it runs as there is no message added so nothing to assert on
        } catch (Exception unexpectedException) {
            Assert.fail(
                'A more specific exception should be thrown. ' + unexpectedException.getMessage()
            );
        }
        // Cannot assert on the logs because the hacking of the exception throws it down the stack path which then doesn't pop the stack
    }
}
