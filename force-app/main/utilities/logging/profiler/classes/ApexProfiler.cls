/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description This class is used to logout the profiling information of the current running transaction.
 *  This will log out as part of the trigger framework after any transaction if any of the limits are approaching 75%
 *
 * 2019-02-02 : Gavin Palmer - Original
 **/
public without sharing class ApexProfiler extends Profiler {
    public override void refreshProfiling() {
        addProfilingInfo(
            'AggregateQueries',
            Limits.getAggregateQueries(),
            Limits.getLimitAggregateQueries()
        );
        addProfilingInfo('Callouts', Limits.getCallouts(), Limits.getLimitCallouts());
        addProfilingInfo('CpuTime', Limits.getCpuTime(), Limits.getLimitCpuTime());
        addProfilingInfo('DatabaseTime', Limits.getDatabaseTime(), Limits.getLimitDatabaseTime());
        addProfilingInfo('DmlRows', Limits.getDmlRows(), Limits.getLimitDmlRows());
        addProfilingInfo(
            'DmlStatements',
            Limits.getDmlStatements(),
            Limits.getLimitDmlStatements()
        );
        addProfilingInfo(
            'EmailInvocations',
            Limits.getEmailInvocations(),
            Limits.getLimitEmailInvocations()
        );
        addProfilingInfo(
            'FindSimilarCalls',
            Limits.getFindSimilarCalls(),
            Limits.getLimitFindSimilarCalls()
        );
        addProfilingInfo('FutureCalls', Limits.getFutureCalls(), Limits.getLimitFutureCalls());
        addProfilingInfo('HeapSize', Limits.getHeapSize(), Limits.getLimitHeapSize());
        addProfilingInfo(
            'MobilePushApexCalls',
            Limits.getMobilePushApexCalls(),
            Limits.getLimitMobilePushApexCalls()
        );
        addProfilingInfo('Queries', Limits.getQueries(), Limits.getLimitQueries());
        addProfilingInfo(
            'QueryLocatorRows',
            Limits.getQueryLocatorRows(),
            Limits.getLimitQueryLocatorRows()
        );
        addProfilingInfo('QueryRows', Limits.getQueryRows(), Limits.getLimitQueryRows());
        addProfilingInfo(
            'QueueableJobs',
            Limits.getQueueableJobs(),
            Limits.getLimitQueueableJobs()
        );
        addProfilingInfo('RunAs', Limits.getRunAs(), Limits.getLimitRunAs());
        addProfilingInfo(
            'SavepointRollbacks',
            Limits.getSavepointRollbacks(),
            Limits.getLimitSavepointRollbacks()
        );
        addProfilingInfo('Savepoints', Limits.getSavepoints(), Limits.getLimitSavepoints());
        addProfilingInfo('SoslQueries', Limits.getSoslQueries(), Limits.getLimitSoslQueries());
    }
}
