/**
 * @author Gavin Palmer
 * @description This class will run the full profiling (ie including the org limits), and write into the logs.
 *  To run you can execute:
 * OrgLimitsProfilingReportRunner report = new OrgLimitsProfilingReportRunner();
 * report.scheduleDaily();
 *
 * @date 2020-10-06
 **/
public without sharing class OrgLimitsProfilingReportRunner extends LoggedSchedulable {
    public static final String JOB_NAME = 'Profiling Report';
    public static final String LOG_TYPE = 'Org Limits Profiling Report';

    private final Profiler profiler = new OrgLimitsProfiler();

    public OrgLimitsProfilingReportRunner() {
        setJobName(JOB_NAME);
    }

    public override void execute() {
        log.setType(LOG_TYPE);
        if (profiler.isBreachingWarning()) {
            log.warn(profiler.getProfilingReport());
        } else {
            log.info(profiler.getProfilingReport());
        }
        log.close();
    }
}
