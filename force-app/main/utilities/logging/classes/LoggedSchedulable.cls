/**
 * @author Gavin Palmer
 * @date 2019-03-11
 * @group Logging
 * @description This wraps the standard Schedulable interfaece and allows the logs to be written without developers needing to write the logs specifically
 *
 **/
public abstract inherited sharing class LoggedSchedulable implements Schedulable {
    private static final String DAILY_CRON_EXPRESSION = '0 0 0 ? * * *';
    public static final String DEFAULT_JOB_NAME = 'Schedule Job';

    protected SchedulableContext context;
    protected final Logger log = LoggerFactory.createLogger(LoggedSchedulable.class);
    private String jobName = DEFAULT_JOB_NAME;

    /**
     * @description This is the implementation of the Schedulable method, this does not need to be extended.
     * It adds the logging and general exception handling around the Schedulable interface
     *
     **/
    public void execute(SchedulableContext context) {
        this.context = context;
        try {
            execute();
        } catch (Exception exceptionToHandle) {
            log.error(exceptionToHandle);
        }
        log.close();
    }

    /**
     * @description This is the method that should be implemented, in a similar way to the Schedulable interface
     *
     **/
    protected abstract void execute();

    /**
     * @description this method will schedule the class on a daily basis at 00:00
     *
     **/
    public Id scheduleDaily() {
        return schedule(DAILY_CRON_EXPRESSION);
    }

    /**
     * @description This method allows the class to be scheduled, based on the cron expression
     *
     **/
    public Id schedule(String cronExpression) {
        return System.schedule(getJobName(), cronExpression, this);
    }

    /**
     * @description This method will set the job name to be used when schedule is called, if not set the default will be used
     *
     **/
    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    protected String getJobName() {
        return jobName;
    }
}
