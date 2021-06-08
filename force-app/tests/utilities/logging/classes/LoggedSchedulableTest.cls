/**
 * @author Gavin Palmer
 * @date 2019-03-11
 *
 **/
@IsTest
private class LoggedSchedulableTest {
    private static final String LOG_MESSAGE = 'My test message';

    private class TestLog extends LoggedSchedulable {
        protected override void execute() {
            log.error(LOG_MESSAGE);
        }
    }

    @IsTest
    private static void scheduleTest() {
        LoggedSchedulable schedulable = new TestLog();
        Test.startTest();
        Id cronJobId = schedulable.scheduleDaily();
        CronTrigger cronJob = [
            SELECT NextFireTime, PreviousFireTime
            FROM CronTrigger
            WHERE Id = :cronJobId
        ];
        System.assert(
            cronJob.NextFireTime <= Date.today().addDays(1),
            'The cron job should be scheduled for tomorrow'
        );
        System.assertEquals(
            null,
            cronJob.PreviousFireTime,
            'The cron job should never have run in the past'
        );
        Test.stopTest();
    }

    @IsTest
    private static void executeTest() {
        LoggedSchedulable schedulable = new TestLog();

        // call the execute method to mock the running of the schedulable
        Test.startTest();
        schedulable.execute(null);
        Test.stopTest();

        List<Log__c> logs = [SELECT Messages__c FROM Log__c];
        System.assertEquals(
            1,
            logs.size(),
            'A message should have been written when the schedulable is run'
        );
        Assert.contains(logs[0].Messages__c, LOG_MESSAGE);
    }
}
