/**
 * @author Gavin Palmer
 * @date 2020-10-08
 * @group Logging
 * @description This is a generic profiling class, which allows implementations to report on certain limits within the environment.
 *
 **/
public abstract without sharing class Profiler {
    @testVisible
    private static final Decimal DEFAULT_WARNING_PERCENTAGE = 0.75;
    @testVisible
    private final Map<String, ProfileInfo> profilingInfos = new Map<String, ProfileInfo>();
    private Boolean isBreachingWarning = false;
    private static final Map<String, Decimal> WARNING_PERCENTAGES = new Map<String, Decimal>();
    private static final Set<String> IGNORE_LIMITS = new Set<String>();

    static {
        for (Apex_Profiling_Warning_Limit__mdt warningLimit : [
            SELECT DeveloperName, Ignore_Limit__c, Warning_Level__c
            FROM Apex_Profiling_Warning_Limit__mdt
        ]) {
            if (warningLimit.Ignore_Limit__c) {
                IGNORE_LIMITS.add(warningLimit.DeveloperName);
            } else {
                WARNING_PERCENTAGES.put(warningLimit.DeveloperName, warningLimit.Warning_Level__c);
            }
        }
    }

    public Profiler() {
        refreshProfiling();
    }

    public Boolean isBreachingWarning() {
        return isBreachingWarning;
    }

    /**
     * @description This method should be implemented in the base classes to refresh the profiling limits,
     * this will be called from the constructor and then at any point before this is planned to execute
     *
     **/
    public abstract void refreshProfiling();

    protected void addProfilingInfo(String limitName, Integer recorded, Integer limitTotal) {
        if (!IGNORE_LIMITS.contains(limitName)) {
            ProfileInfo profilingInfo = new ProfileInfo(limitName, recorded, limitTotal);
            isBreachingWarning = isBreachingWarning || profilingInfo.isBreachingWarning();
            profilingInfos.put(profilingInfo.limitName, profilingInfo);
        }
    }

    /**
     * @description This method is used to generate the report, each line that is breeching the warning will be marked as Warning
     *
     **/
    public String generateProfilingReport() {
        StringBuilder report = new StringBuilder();
        report.setSeparator('\n');
        for (ProfileInfo profile : profilingInfos.values()) {
            report.append(profile.getReportLine());
        }
        return report.toString();
    }

    private class ProfileInfo {
        private final String limitName;
        @testVisible
        private final Integer recorded;
        @testVisible
        private final Integer limitTotal;

        private ProfileInfo(String limitName, Integer recorded, Integer limitTotal) {
            this.limitName = limitName;
            this.recorded = recorded;
            this.limitTotal = limitTotal;
        }

        private Decimal getPercentage() {
            return limitTotal == 0
                ? 0
                : 1 - Decimal.valueOf(limitTotal - recorded) / Decimal.valueOf(limitTotal);
        }

        private String getReportLine() {
            String prefix = isBreachingWarning() ? 'Warning hit for ' : 'Number of ';
            return prefix + limitName + ': ' + recorded + ' of ' + limitTotal;
        }

        private Boolean isBreachingWarning() {
            Decimal warningPercentage = WARNING_PERCENTAGES.containsKey(limitName)
                ? (WARNING_PERCENTAGES.get(limitName) / 100)
                : DEFAULT_WARNING_PERCENTAGE;
            return getPercentage() > warningPercentage;
        }
    }
}
