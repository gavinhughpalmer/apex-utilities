/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description This is a generic profiling class, where the 2 current externtions are for the Apex transaction limits and the overall org limits
 *
 * 2020-10-08 : Gavin Palmer - Original
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

    public abstract void refreshProfiling();

    protected void addProfilingInfo(String limitName, Integer recorded, Integer limitTotal) {
        if (!IGNORE_LIMITS.contains(limitName)) {
            ProfileInfo profilingInfo = new ProfileInfo(limitName, recorded, limitTotal);
            isBreachingWarning = isBreachingWarning || profilingInfo.isBreachingWarning();
            profilingInfos.put(profilingInfo.limitName, profilingInfo);
        }
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
