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

    /**
     * @description This is the implementation of the Queueable method, this does not need to be extended.
     * It adds the logging and general exception handling around the Queueable interface
     *
     **/
    public void execute(QueueableContext context) {
        this.context = context;
        try {
            execute();
        } catch (Exception exceptionToHandle) {
            log.error(exceptionToHandle);
        }
        log.close();
    }

    /**
     * @description This is the method that should be implemented, in a similar way to the Queueable interface
     *
     **/
    protected abstract void execute();

    /**
     * @description The enqueue method will set the queueable off for execution following the transaction
     *
     **/
    public Id enqueue() {
        return System.enqueueJob(this);
    }
}
