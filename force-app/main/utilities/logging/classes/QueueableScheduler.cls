/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description This class will schedule a queuebale class to run by injecting the queuebale into the class
 * Usage:
 * QueueableScheduler scheduler = new QueueableScheduler(new MyQueueable());
 * scheduler.scheduleDaily();
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
        runningQueueableId = queueableToRun.enqueue();
    }

    public Id getRunningQueueableId() {
        return runningQueueableId;
    }
}
