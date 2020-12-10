/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description Test class for the LoggedQueueable class
 *
 * 2019-02-06 : Gavin Palmer - Original
 **/
@IsTest(isParallel=true)
private class LoggedQueueableTest {
    private static final String LOG_MESSAGE = 'My test message';

    private class TestLog extends LoggedQueueable {
        protected override void execute() {
            log.error(LOG_MESSAGE);
        }
    }

    @IsTest
    private static void runTestLogWritten() {
        LoggedQueueable testQueueable = new TestLog();
        Test.startTest();
        testQueueable.enqueue();
        Test.stopTest();
        List<Log__c> logs = [SELECT Messages__c FROM Log__c];
        System.assertEquals(
            1,
            logs.size(),
            'A message should have been written when the queueable is ran'
        );
        Assert.contains(logs[0].Messages__c, LOG_MESSAGE);
    }
}
