/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
* @description This class is used to logout the profiling information of the current running transaction. 
*  This will log out as part of the trigger framework after any transaction if any of the limits are approaching 75%
*
* 2019-02-02 : Gavin Palmer - Original
**/
public without sharing class ApexProfiler {

    @testVisible private static final Decimal DEFAULT_WARNING_PERCENTAGE = 0.75;
    @testVisible private final Map<String, ProfileInfo> profilingInfos = new Map<String, ProfileInfo>();
    private static final Map<String, Decimal> WARNING_PERCENTAGES = new Map<String, Decimal>();
    
    static {
        for (Apex_Profiling_Warning_Limit__mdt warningLimit : [
            SELECT DeveloperName, Warning_Level__c
            FROM Apex_Profiling_Warning_Limit__mdt
        ]) {
            WARNING_PERCENTAGES.put(warningLimit.DeveloperName, warningLimit.Warning_Level__c);
        }
    }

    public ApexProfiler() {
        refreshProfiling();
    }

    public Boolean isBreachingWarning() {
        for (ProfileInfo profile : profilingInfos.values()) {
            if (profile.isBreachingWarning()) {
                return true;
            }
        }
        return false;
    }

    public void refreshProfiling() {
        addProfilingInfo(new AggregateQueriesProfileInfo());
        addProfilingInfo(new CalloutsProfileInfo());
        addProfilingInfo(new CpuTimeProfileInfo());
        addProfilingInfo(new DatabaseTimeProfileInfo());
        addProfilingInfo(new DmlRowsProfileInfo());
        addProfilingInfo(new DmlStatementsProfileInfo());
        addProfilingInfo(new EmailInvocationsProfileInfo());
        addProfilingInfo(new FindSimilarCallsProfileInfo());
        addProfilingInfo(new FutureCallsProfileInfo());
        addProfilingInfo(new HeapSizeProfileInfo());
        addProfilingInfo(new MobilePushApexCallsProfileInfo());
        addProfilingInfo(new QueriesProfileInfo());
        addProfilingInfo(new QueryLocatorRowsProfileInfo());
        addProfilingInfo(new QueryRowsProfileInfo());
        addProfilingInfo(new QueueableJobsProfileInfo());
        addProfilingInfo(new RunAsProfileInfo());
        addProfilingInfo(new SavepointRollbacksProfileInfo());
        addProfilingInfo(new SavepointsProfileInfo());
        addProfilingInfo(new SoslQueriesProfileInfo());
        addOrgLimits();
    }

    private void addOrgLimits() {
        Map<String, OrgLimit> orgLimitsMap = OrgLimits.getMap();
        for (String limitName : orgLimitsMap.keySet()) {
            OrgLimit orgLimit = orgLimitsMap.get(limitName);
            addProfilingInfo(new ProfileInfo(limitName, orgLimit.getValue(), orgLimit.getLimit()));
        }
    }

    private void addProfilingInfo(ProfileInfo profilingInfo) {
        profilingInfos.put(profilingInfo.limitName, profilingInfo);
    }

    public String getProfilingReport() {
        StringBuilder report = new StringBuilder();
        report.setSeparator('\n');
        for (ProfileInfo profile : profilingInfos.values()) {
            report.append(profile.getReportLine());
        }
        return report.toString();
    }

    private virtual class ProfileInfo {

        private final String limitName;
        @testVisible private final Integer recorded;
        @testVisible private final Integer limitTotal;

        private ProfileInfo(String limitName, Integer recorded, Integer limitTotal) {
            this.limitName = limitName;
            this.recorded = recorded;
            this.limitTotal = limitTotal;
        }

        private Decimal getPercentage() {
            return limitTotal == 0 ? 0 : 1 - Decimal.valueOf(limitTotal - recorded) / Decimal.valueOf(limitTotal);
        }

        private String getReportLine() {
            String prefix = isBreachingWarning() ? 'Warning hit for ' : 'Number of ';
            return prefix + limitName + ': ' + recorded + ' of ' + limitTotal;
        }

        private Boolean isBreachingWarning() {
            Decimal warningPercentage = WARNING_PERCENTAGES.containsKey(limitName) ? (WARNING_PERCENTAGES.get(limitName) / 100) : DEFAULT_WARNING_PERCENTAGE;
            return getPercentage() > warningPercentage;
        }
    }

    private class AggregateQueriesProfileInfo extends ProfileInfo {
        private AggregateQueriesProfileInfo() {
            super('AggregateQueries', Limits.getAggregateQueries(), Limits.getLimitAggregateQueries());
        }
    }
    private class CalloutsProfileInfo extends ProfileInfo {
        private CalloutsProfileInfo() {
            super('Callouts', Limits.getCallouts(), Limits.getLimitCallouts());
        }
    }
    private class CpuTimeProfileInfo extends ProfileInfo {
        private CpuTimeProfileInfo() {
            super('CpuTime', Limits.getCpuTime(), Limits.getLimitCpuTime());
        }
    }
    private class DatabaseTimeProfileInfo extends ProfileInfo {
        private DatabaseTimeProfileInfo() {
            super('DatabaseTime', Limits.getDatabaseTime(), Limits.getLimitDatabaseTime());
        }
    }
    private class DmlRowsProfileInfo extends ProfileInfo {
        private DmlRowsProfileInfo() {
            super('DmlRows', Limits.getDmlRows(), Limits.getLimitDmlRows());
        }
    }
    private class DmlStatementsProfileInfo extends ProfileInfo {
        private DmlStatementsProfileInfo() {
            super('DmlStatements', Limits.getDmlStatements(), Limits.getLimitDmlStatements());
        }
    }
    private class EmailInvocationsProfileInfo extends ProfileInfo {
        private EmailInvocationsProfileInfo() {
            super('EmailInvocations', Limits.getEmailInvocations(), Limits.getLimitEmailInvocations());
        }
    }
    private class FindSimilarCallsProfileInfo extends ProfileInfo {
        private FindSimilarCallsProfileInfo() {
            super('FindSimilarCalls', Limits.getFindSimilarCalls(), Limits.getLimitFindSimilarCalls());
        }
    }
    private class FutureCallsProfileInfo extends ProfileInfo {
        private FutureCallsProfileInfo() {
            super('FutureCalls', Limits.getFutureCalls(), Limits.getLimitFutureCalls());
        }
    }
    private class HeapSizeProfileInfo extends ProfileInfo {
        private HeapSizeProfileInfo() {
            super('HeapSize', Limits.getHeapSize(), Limits.getLimitHeapSize());
        }
    }
    private class MobilePushApexCallsProfileInfo extends ProfileInfo {
        private MobilePushApexCallsProfileInfo() {
            super('MobilePushApexCalls', Limits.getMobilePushApexCalls(), Limits.getLimitMobilePushApexCalls());
        }
    }
    private class QueriesProfileInfo extends ProfileInfo {
        private QueriesProfileInfo() {
            super('Queries', Limits.getQueries(), Limits.getLimitQueries());
        }
    }
    private class QueryLocatorRowsProfileInfo extends ProfileInfo {
        private QueryLocatorRowsProfileInfo() {
            super('QueryLocatorRows', Limits.getQueryLocatorRows(), Limits.getLimitQueryLocatorRows());
        }
    }
    private class QueryRowsProfileInfo extends ProfileInfo {
        private QueryRowsProfileInfo() {
            super('QueryRows', Limits.getQueryRows(), Limits.getLimitQueryRows());
        }
    }
    private class QueueableJobsProfileInfo extends ProfileInfo {
        private QueueableJobsProfileInfo() {
            super('QueueableJobs', Limits.getQueueableJobs(), Limits.getLimitQueueableJobs());
        }
    }
    private class RunAsProfileInfo extends ProfileInfo {
        private RunAsProfileInfo() {
            super('RunAs', Limits.getRunAs(), Limits.getLimitRunAs());
        }
    }
    private class SavepointRollbacksProfileInfo extends ProfileInfo {
        private SavepointRollbacksProfileInfo() {
            super('SavepointRollbacks', Limits.getSavepointRollbacks(), Limits.getLimitSavepointRollbacks());
        }
    }
    private class SavepointsProfileInfo extends ProfileInfo {
        private SavepointsProfileInfo() {
            super('Savepoints', Limits.getSavepoints(), Limits.getLimitSavepoints());
        }
    }
    private class SoslQueriesProfileInfo extends ProfileInfo {
        private SoslQueriesProfileInfo() {
            super('SoslQueries', Limits.getSoslQueries(), Limits.getLimitSoslQueries());
        }
    }
}
