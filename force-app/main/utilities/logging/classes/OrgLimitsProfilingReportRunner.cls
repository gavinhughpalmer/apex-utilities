/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description This class will run the full profiling (ie including the org limits), and write into the logs.
 *  To run you can execute:
 * OrgLimitsProfilingReportRunner report = new OrgLimitsProfilingReportRunner();
 * report.scheduleDaily();
 *
 * 2020-10-06 : Gavin Palmer - Original
 **/
public without sharing class OrgLimitsProfilingReportRunner extends LoggedSchedulable {
    public static final String JOB_NAME = 'Profiling Report';

    private final Profiler profiler = new OrgLimitsProfiler();

    public OrgLimitsProfilingReportRunner() {
        setJobName('Profiling Report');
    }

    public override void execute() {
        BulkLogObjectAdapter.getInstance('Org Limits Profiling Report');
        if (profiler.isBreachingWarning()) {
            log.warn(profiler.getProfilingReport());
        } else {
            log.info(profiler.getProfilingReport());
        }
        BulkLogObjectAdapter.writeLogs();
    }
}
