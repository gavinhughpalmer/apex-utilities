/**
 * @author Gavin Palmer
 * @date 2019-02-06
 * @group Logging
 * @description This class wraps the queueable interface with the logging framework so that developers do not
 * have to worry about writing the logs after the Logger methods are called.
 *
 **/
public abstract inherited sharing class LoggedQueueable implements Queueable {
    protected QueueableContext context;
    protected final Logger log = LoggerFactory.createLogger(LoggedQueueable.class);

    public void execute(QueueableContext context) {
        this.context = context;
        try {
            execute();
        } catch (Exception exceptionToHandle) {
            log.error(exceptionToHandle);
        }
        log.close();
    }

    protected abstract void execute();

    public Id enqueue() {
        return System.enqueueJob(this);
    }
}
