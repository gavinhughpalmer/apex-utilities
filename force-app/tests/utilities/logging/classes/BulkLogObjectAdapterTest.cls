/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 *
 * @date 2018-06-27
 **/
@IsTest(isParallel=true)
private class BulkLogObjectAdapterTest {
    @IsTest
    private static void errorLevelTest() {
        LoggerAdapter loggerAdapter = BulkLogObjectAdapter.getInstance();
        System.assertEquals(
            BulkLogObjectAdapter.ERROR,
            loggerAdapter.errorLevel(),
            'The error level should return the error string'
        );
    }

    @IsTest
    private static void warningLevelTest() {
        LoggerAdapter loggerAdapter = BulkLogObjectAdapter.getInstance();
        System.assertEquals(
            BulkLogObjectAdapter.WARNING,
            loggerAdapter.warningLevel(),
            'The warning level should return the warning string'
        );
    }

    @IsTest
    private static void infoLevelTest() {
        LoggerAdapter loggerAdapter = BulkLogObjectAdapter.getInstance();
        System.assertEquals(
            BulkLogObjectAdapter.INFO,
            loggerAdapter.infoLevel(),
            'The info level should return the info string'
        );
    }

    @IsTest
    private static void debugLevelTest() {
        LoggerAdapter loggerAdapter = BulkLogObjectAdapter.getInstance();
        System.assertEquals(
            BulkLogObjectAdapter.DEBUG,
            loggerAdapter.debugLevel(),
            'The debug level should return the debug string'
        );
    }

    @IsTest
    private static void logTest() {
        final String logType = 'Test Log Type';
        final String logLevel = BulkLogObjectAdapter.ERROR;
        final String message = 'Test Log Message';
        BulkLogObjectAdapter loggerAdapter = BulkLogObjectAdapter.getInstance();
        loggerAdapter.setType(logType);

        System.assert(
            loggerAdapter.logsToPublish.isEmpty(),
            'The logs should be empty before log is called'
        );

        loggerAdapter.log(logLevel, message);

        System.assertEquals(
            1,
            loggerAdapter.logsToPublish.size(),
            'The logs should not be empty after log is called'
        );
        Log_Event__e logToAssert = loggerAdapter.logsToPublish[0];
        System.assertEquals(
            logType,
            logToAssert.Type__c,
            'The type should match the type passed into the adapters constructor'
        );
        System.assertEquals(
            logLevel,
            logToAssert.Level__c,
            'The log level should match the level passed into the log call'
        );
        System.assertEquals(
            message,
            logToAssert.Messages__c,
            'The message should match the message passed into the log call'
        );
    }

    @IsTest
    private static void logTestWithRecordId() {
        SObjectTestFactory testFactory = new SObjectTestFactory();
        SObject testSObject = testFactory.insertSObject();
        final String logType = 'Test Log Type';
        final String logLevel = BulkLogObjectAdapter.ERROR;
        final String message = 'Test Log Message';
        BulkLogObjectAdapter loggerAdapter = BulkLogObjectAdapter.getInstance();
        loggerAdapter.setType(logType);
        System.assert(
            loggerAdapter.logsToPublish.isEmpty(),
            'The logs should be empty before log is called'
        );

        loggerAdapter.log(logLevel, message, testSObject.Id);

        System.assertEquals(
            1,
            loggerAdapter.logsToPublish.size(),
            'The logs should not be empty after log is called'
        );
        Log_Event__e logToAssert = loggerAdapter.logsToPublish[0];
        System.assertEquals(
            logType,
            logToAssert.Type__c,
            'The type should match the type passed into the adapters constructor'
        );
        System.assertEquals(
            logLevel,
            logToAssert.Level__c,
            'The log level should match the level passed into the log call'
        );
        System.assertEquals(
            message,
            logToAssert.Messages__c,
            'The message should match the message passed into the log call'
        );
        System.assertEquals(
            testSObject.Id,
            logToAssert.Record_Id__c,
            'The record id should be appended to the log record'
        );
    }

    @IsTest
    private static void closeTest() {
        System.assertEquals(
            0,
            [SELECT COUNT() FROM Log__c],
            'There should be no logs in the system before the test'
        );
        final String logType = 'Test Log Type';
        final String logLevel = BulkLogObjectAdapter.ERROR;
        final String message = 'Test Log Message';
        BulkLogObjectAdapter loggerAdapter = BulkLogObjectAdapter.getInstance();
        loggerAdapter.setType(logType);

        loggerAdapter.log(logLevel, message);

        Test.startTest();
        try {
            loggerAdapter.close();
        } catch (Exception exceptionToHandle) {
            System.assert(
                false,
                'An error should not be thrown when writing logs, error provided: ' +
                exceptionToHandle.getMessage()
            );
        }
        Test.stopTest();

        List<Log__c> writtenLogs = [SELECT Type__c, Level__c, Messages__c FROM Log__c];

        System.assertEquals(1, writtenLogs.size(), 'There should be 1 log generated in the system');

        Log__c logToAssert = writtenLogs[0];
        System.assertEquals(
            logType,
            logToAssert.Type__c,
            'The type should match the type passed into the adapters constructor'
        );
        System.assertEquals(
            logLevel,
            logToAssert.Level__c,
            'The log level should match the level passed into the log call'
        );
        System.assertEquals(
            message,
            logToAssert.Messages__c,
            'The message should match the message passed into the log call'
        );
    }

    @IsTest
    private static void writeMultipleLogsTest() {
        System.assertEquals(
            0,
            [SELECT COUNT() FROM Log__c],
            'There should be no logs in the system before the test'
        );
        final String logType = 'Test Log Type';
        final String logLevel = BulkLogObjectAdapter.ERROR;
        final String message = 'Test Log Message';
        BulkLogObjectAdapter loggerAdapter = BulkLogObjectAdapter.getInstance();
        loggerAdapter.setType(logType);

        loggerAdapter.log(logLevel, message);

        Test.startTest();
        try {
            loggerAdapter.close();
            // Write the logs for a second time, this should not cause any problems
            loggerAdapter.close();
        } catch (Exception exceptionToHandle) {
            System.assert(
                false,
                'An error should not be thrown when writing logs, error provided: ' +
                exceptionToHandle.getMessage()
            );
        }
        Test.stopTest();

        List<Log__c> writtenLogs = [SELECT Type__c, Level__c, Messages__c FROM Log__c];

        System.assertEquals(1, writtenLogs.size(), 'There should be 1 log generated in the system');

        Log__c logToAssert = writtenLogs[0];
        System.assertEquals(
            logType,
            logToAssert.Type__c,
            'The type should match the type passed into the adapters constructor'
        );
        System.assertEquals(
            logLevel,
            logToAssert.Level__c,
            'The log level should match the level passed into the log call'
        );
        System.assertEquals(
            message,
            logToAssert.Messages__c,
            'The message should match the message passed into the log call'
        );
    }
}
