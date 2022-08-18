/**
 * @author Gavin Palmer
 * @date 2019-04-20
 *
 **/
@IsTest(isParallel=true)
private class LogWriterTest {
    @IsTest
    private static void testAction() {
        Log_Event__e logEvent = new Log_Event__e(
            Level__c = 'Error',
            Messages__c = 'test2',
            Record_Id__c = 'test3',
            Type__c = 'test4'
        );

        Triggerable triggerAction = new LogWriter();
        triggerAction.register(new SObjectTriggerWrapper(logEvent, logEvent));
        triggerAction.performAction();
        List<Log__c> createdLogs = [
            SELECT Level__c, Messages__c, Record_Id__c, Type__c
            FROM Log__c
        ];

        Assert.areEqual(
            1,
            createdLogs.size(),
            'A single log should have been created during the conversion process'
        );
        Assert.areEqual(
            logEvent.Level__c,
            createdLogs[0].Level__c,
            'The level field has not been converted correctly'
        );
        Assert.areEqual(
            logEvent.Messages__c,
            createdLogs[0].Messages__c,
            'The messages field has not been converted correctly'
        );
        Assert.areEqual(
            logEvent.Record_Id__c,
            createdLogs[0].Record_Id__c,
            'The record id field has not been converted correctly'
        );
        Assert.areEqual(
            logEvent.Type__c,
            createdLogs[0].Type__c,
            'The type field has not been converted correctly'
        );
    }
}
