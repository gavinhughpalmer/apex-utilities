/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 *
 * 2020-10-06 : Gavin Palmer - Original
 **/
@IsTest(isParallel=true)
private class OrgLimitsProfilingReportRunnerTest {
    // negative tests not currently written for breached warnings or not as this would require some mocking to be written into the
    @IsTest
    private static void testExecute() {
        Set<String> possibleLogLevels = new Set<String>{
            BulkLogObjectAdapter.WARNING,
            BulkLogObjectAdapter.INFO
        };
        BulkLogObjectAdapter.LOGGING_LEVELS.addAll(possibleLogLevels);

        Test.startTest();
        OrgLimitsProfilingReportRunner report = new OrgLimitsProfilingReportRunner();
        report.execute();
        Test.stopTest();

        List<Log__c> logs = [SELECT Level__c FROM Log__c];
        System.assertEquals(
            1,
            logs.size(),
            'A single log record should have been created containing the profiling report for the org'
        );
        System.assert(
            possibleLogLevels.contains(logs[0].Level__c),
            'The log created should either be a warning or info, recieved ' + logs[0].Level__c
        );
    }
}
