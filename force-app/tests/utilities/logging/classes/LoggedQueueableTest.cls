/**
 * @author Gavin Palmer
 * @date 2019-02-06
 *
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
        Assert.areEqual(
            1,
            logs.size(),
            'A message should have been written when the queueable is ran'
        );
        Assert.isTrue(
            logs[0].Messages__c.contains(LOG_MESSAGE),
            'The string (' +
            LOG_MESSAGE +
            ') was not found in the string: ' +
            logs[0].Messages__c
        );
    }
}
