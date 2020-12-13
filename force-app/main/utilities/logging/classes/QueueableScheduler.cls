/**
 * @author Gavin Palmer
 * @date 2019-03-11
 * @group Logging
 * @description This class will schedule a queuebale class to run by injecting the queuebale into the class
 * Usage:
 * QueueableScheduler scheduler = new QueueableScheduler(new MyQueueable());
 * scheduler.scheduleDaily();
 *
 **/
public inherited sharing class QueueableScheduler extends LoggedSchedulable {
    private final LoggedQueueable queueableToRun;
    private Id runningQueueableId;

    public QueueableScheduler(LoggedQueueable queueableToRun) {
        this.queueableToRun = queueableToRun;
    }

    public override void execute() {
        runningQueueableId = queueableToRun.enqueue();
    }

    public Id getRunningQueueableId() {
        return runningQueueableId;
    }
}
