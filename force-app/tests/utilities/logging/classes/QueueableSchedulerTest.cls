/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 *
 * @date 2019-03-11
 **/
@IsTest(isParallel=true)
private class QueueableSchedulerTest {
    private class TestQueueable extends LoggedQueueable {
        private final Logger log = new Logger(
            QueueableSchedulerTest.class,
            new LoggerAdapter.DebugLogAdapter()
        );
        public override void execute() {
            log.debug('Do nothing');
        }
    }

    @IsTest
    private static void executeTest() {
        Test.startTest();
        QueueableScheduler scheduler = new QueueableScheduler(new TestQueueable());
        scheduler.execute();
        Id queableId = scheduler.getRunningQueueableId();
        System.assertNotEquals(
            null,
            queableId,
            'The id should have been assigned when the queable is scheduled in the queueable'
        );
        Test.stopTest();
    }
}
