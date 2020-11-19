/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 *
 * 2019-04-20 : Gavin Palmer - Original
 **/
@IsTest
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

        System.assertEquals(
            1,
            createdLogs.size(),
            'A single log should have been created during the conversion process'
        );
        System.assertEquals(
            logEvent.Level__c,
            createdLogs[0].Level__c,
            'The level field has not been converted correctly'
        );
        System.assertEquals(
            logEvent.Messages__c,
            createdLogs[0].Messages__c,
            'The messages field has not been converted correctly'
        );
        System.assertEquals(
            logEvent.Record_Id__c,
            createdLogs[0].Record_Id__c,
            'The record id field has not been converted correctly'
        );
        System.assertEquals(
            logEvent.Type__c,
            createdLogs[0].Type__c,
            'The type field has not been converted correctly'
        );
    }
}
