/**
 * @author Gavin Palmer
 * @date 2020-10-08
 * @group Logging
 * @description This class runs the profiling for org limits
 *
 **/
public without sharing class OrgLimitsProfiler extends Profiler {
    public override void refreshProfiling() {
        Map<String, OrgLimit> orgLimitsMap = OrgLimits.getMap();
        for (String limitName : orgLimitsMap.keySet()) {
            OrgLimit orgLimit = orgLimitsMap.get(limitName);
            addProfilingInfo(limitName, orgLimit.getValue(), orgLimit.getLimit());
        }
    }
}
