/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
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
    private static Boolean isIncludingOrgLimits = true;

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

    public static void includeOrgLimits(Boolean isIncludingOrgLimits) {
        ApexProfiler.isIncludingOrgLimits = isIncludingOrgLimits;
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
        addProfilingInfo(new ProfileInfo('AggregateQueries', Limits.getAggregateQueries(), Limits.getLimitAggregateQueries()));
        addProfilingInfo(new ProfileInfo('Callouts', Limits.getCallouts(), Limits.getLimitCallouts()));
        addProfilingInfo(new ProfileInfo('CpuTime', Limits.getCpuTime(), Limits.getLimitCpuTime()));
        addProfilingInfo(new ProfileInfo('DatabaseTime', Limits.getDatabaseTime(), Limits.getLimitDatabaseTime()));
        addProfilingInfo(new ProfileInfo('DmlRows', Limits.getDmlRows(), Limits.getLimitDmlRows()));
        addProfilingInfo(new ProfileInfo('DmlStatements', Limits.getDmlStatements(), Limits.getLimitDmlStatements()));
        addProfilingInfo(new ProfileInfo('EmailInvocations', Limits.getEmailInvocations(), Limits.getLimitEmailInvocations()));
        addProfilingInfo(new ProfileInfo('FindSimilarCalls', Limits.getFindSimilarCalls(), Limits.getLimitFindSimilarCalls()));
        addProfilingInfo(new ProfileInfo('FutureCalls', Limits.getFutureCalls(), Limits.getLimitFutureCalls()));
        addProfilingInfo(new ProfileInfo('HeapSize', Limits.getHeapSize(), Limits.getLimitHeapSize()));
        addProfilingInfo(new ProfileInfo('MobilePushApexCalls', Limits.getMobilePushApexCalls(), Limits.getLimitMobilePushApexCalls()));
        addProfilingInfo(new ProfileInfo('Queries', Limits.getQueries(), Limits.getLimitQueries()));
        addProfilingInfo(new ProfileInfo('QueryLocatorRows', Limits.getQueryLocatorRows(), Limits.getLimitQueryLocatorRows()));
        addProfilingInfo(new ProfileInfo('QueryRows', Limits.getQueryRows(), Limits.getLimitQueryRows()));
        addProfilingInfo(new ProfileInfo('QueueableJobs', Limits.getQueueableJobs(), Limits.getLimitQueueableJobs()));
        addProfilingInfo(new ProfileInfo('RunAs', Limits.getRunAs(), Limits.getLimitRunAs()));
        addProfilingInfo(new ProfileInfo('SavepointRollbacks', Limits.getSavepointRollbacks(), Limits.getLimitSavepointRollbacks()));
        addProfilingInfo(new ProfileInfo('Savepoints', Limits.getSavepoints(), Limits.getLimitSavepoints()));
        addProfilingInfo(new ProfileInfo('SoslQueries', Limits.getSoslQueries(), Limits.getLimitSoslQueries()));
        if (isIncludingOrgLimits) {
            addOrgLimits();
        }
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

    private class ProfileInfo {

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
}
