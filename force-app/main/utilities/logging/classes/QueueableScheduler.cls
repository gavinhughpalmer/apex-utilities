/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
* @description This class will schedule a queuebale class to run by injecting the queuebale into the class
*
* 2019-03-11 : Gavin Palmer - Original
**/
public inherited sharing class QueueableScheduler extends LoggedSchedulable {

    private final LoggedQueueable queueableToRun;
    private Id runningQueueableId;

    public QueueableScheduler(LoggedQueueable queueableToRun) {
        this.queueableToRun = queueableToRun;
    }

    public override void execute() {
        runningQueueableId = queueableToRun.run();
    }

    public Id getRunningQueueableId() {
        return runningQueueableId;
    }
}