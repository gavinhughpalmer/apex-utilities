/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
*
* 2019-03-11 : Gavin Palmer - Original
**/
@IsTest
private class QueueableSchedulerTest {
    
    private class TestQueueable extends LoggedQueueable {
        private final Logger log = new Logger(new Logger.DebugLogAdapter());
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
            null, queableId, 
            'The id should have been assigned when the queable is scheduled in the queueable'
        );
        Test.stopTest();
    }
}
