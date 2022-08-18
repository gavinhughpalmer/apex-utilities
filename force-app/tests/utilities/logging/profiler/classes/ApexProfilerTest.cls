/**
 * @author Gavin Palmer
 * @date 2019-02-02
 *
 **/
@SuppressWarnings('PMD.UnusedLocalVariable')
@IsTest(isParallel=true)
private class ApexProfilerTest {
    @IsTest
    private static void refreshProfilingTest() {
        Test.startTest();
        ApexProfiler profiler = new ApexProfiler();
        Assert.areEqual(
            profiler.profilingInfos.get('Queries').recorded,
            0,
            'The profiling for queries should be 0 before any queries are performed'
        );
        List<Account> testQuery = [SELECT Id FROM Account LIMIT 1];
        profiler.refreshProfiling();
        Assert.areEqual(
            profiler.profilingInfos.get('Queries').recorded,
            1,
            'The profiling for queries should be 1 after a query is performed'
        );
        Test.stopTest();
    }

    @IsTest
    private static void isBreachingWarningTestNoBreach() {
        Test.startTest();
        ApexProfiler profiler = new ApexProfiler();
        // Set to not include org limits for this test as this is
        Assert.isFalse(
            profiler.isBreachingWarning(),
            'The warning should not be breached before any apex code is executed. Report:\n' +
            profiler.generateProfilingReport()
        );
        Test.stopTest();
    }

    @IsTest
    @SuppressWarnings('PMD.OperationWithLimitsInLoop,UnusedLocalVariable')
    private static void isBreachingWarningTestBreach() {
        Test.startTest();
        ApexProfiler apexProfiler = new ApexProfiler();
        Integer queriesToRun =
            Integer.valueOf(
                Math.ceil(
                    apexProfiler.profilingInfos.get('Queries').limitTotal *
                    Profiler.DEFAULT_WARNING_PERCENTAGE
                )
            ) + 1;
        for (Integer i = 0; i < queriesToRun; i++) {
            List<Account> testQuery = [SELECT Id FROM Account LIMIT 1];
        }
        apexProfiler.refreshProfiling();
        Assert.isTrue(
            apexProfiler.isBreachingWarning(),
            'The warning should be flagged when the queries have run'
        );
        Test.stopTest();
    }

    @IsTest
    private static void generateProfilingReportTest() {
        ApexProfiler profiler = new ApexProfiler();
        Assert.isTrue(
            String.isNotBlank(profiler.generateProfilingReport()),
            'The profiling report should not be empty'
        );
    }
}
