/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
* @description Test class for the LoggedQueueable class
*
* 2019-02-06 : Gavin Palmer - Original
**/
@IsTest
private class LoggedQueueableTest {

    private static final String LOG_MESSAGE = 'My test message';

    private class TestLog extends LoggedQueueable {
        protected override void execute() {
            log.debug(LOG_MESSAGE);
        }
    }
    
    @IsTest
    private static void runTestLogWritten() {
        LoggedQueueable testQueueable = new TestLog();
        Test.startTest();
        testQueueable.run();
        Test.stopTest();
        List<Log__c> logs = [SELECT Messages__c FROM Log__c];
        System.assertEquals(
            1, logs.size(), 
            'A message should have been written when the queueable is ran'
        );
        System.assertEquals(
            LOG_MESSAGE, logs[0].Messages__c, 
            'The correct message has not been written into the log'
        );
    }
}