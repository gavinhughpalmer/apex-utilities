/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
* @description This wraps the standard Schedulable interfaece and allows the logs to be written without developers needing to write the logs specifically
*
* 2019-03-11 : Gavin Palmer - Original
**/
public abstract inherited sharing class LoggedSchedulable implements Schedulable {

    private static final String DAILY_CRON_EXPRESSION = '0 0 0 ? * * *';
    public static final String DEFAULT_JOB_NAME = 'Schedule Job';

    protected SchedulableContext context;
    // the logger adapter is called as an instance method as the static singleton variable isnt maintained in the schedulable transaction
    private final BulkLogObjectAdapter loggerAdapter = BulkLogObjectAdapter.getInstance('Logged Schedulable');
    protected final Logger log = new Logger(loggerAdapter);
    private String jobName = DEFAULT_JOB_NAME;

    public void execute(SchedulableContext context) {
        BulkLogObjectAdapter.setInstance(loggerAdapter);
        this.context = context;
        try {
            execute();
        } catch (Exception exceptionToHandle) {
            log.error(exceptionToHandle);
        }
        BulkLogObjectAdapter.writeLogs();
    }

    protected abstract void execute();

    public Id scheduleDaily() {
        return schedule(DAILY_CRON_EXPRESSION);
    }

    public Id schedule(String cronExpression) {
        return System.schedule(getJobName(), cronExpression, this);
    }

    public void setJobName(String jobName) {
        this.jobName = jobName;
    }

    protected String getJobName() {
        return jobName;
    }
}
