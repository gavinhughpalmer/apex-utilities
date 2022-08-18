/**
 * @author Gavin Palmer
 * @date 2018-06-27
 *
 **/
@IsTest(isParallel=true)
private class EventBufferLogAdapterTest {
    @IsTest
    private static void errorLevelTest() {
        LoggerAdapter loggerAdapter = EventBufferLogAdapter.getInstance();
        Assert.areEqual(
            EventBufferLogAdapter.ERROR,
            loggerAdapter.errorLevel(),
            'The error level should return the error string'
        );
    }

    @IsTest
    private static void warningLevelTest() {
        LoggerAdapter loggerAdapter = EventBufferLogAdapter.getInstance();
        Assert.areEqual(
            EventBufferLogAdapter.WARNING,
            loggerAdapter.warningLevel(),
            'The warning level should return the warning string'
        );
    }

    @IsTest
    private static void infoLevelTest() {
        LoggerAdapter loggerAdapter = EventBufferLogAdapter.getInstance();
        Assert.areEqual(
            EventBufferLogAdapter.INFO,
            loggerAdapter.infoLevel(),
            'The info level should return the info string'
        );
    }

    @IsTest
    private static void debugLevelTest() {
        LoggerAdapter loggerAdapter = EventBufferLogAdapter.getInstance();
        Assert.areEqual(
            EventBufferLogAdapter.DEBUG,
            loggerAdapter.debugLevel(),
            'The debug level should return the debug string'
        );
    }

    @IsTest
    private static void logTest() {
        final String logType = 'Test Log Type';
        final String logLevel = EventBufferLogAdapter.ERROR;
        final String message = 'Test Log Message';
        EventBufferLogAdapter loggerAdapter = EventBufferLogAdapter.getInstance();
        loggerAdapter.setType(logType);

        Assert.isTrue(
            loggerAdapter.logsToPublish.isEmpty(),
            'The logs should be empty before log is called'
        );

        loggerAdapter.log(logLevel, message);

        Assert.areEqual(
            1,
            loggerAdapter.logsToPublish.size(),
            'The logs should not be empty after log is called'
        );
        Log_Event__e logToAssert = loggerAdapter.logsToPublish[0];
        Assert.areEqual(
            logType,
            logToAssert.Type__c,
            'The type should match the type passed into the adapters constructor'
        );
        Assert.areEqual(
            logLevel,
            logToAssert.Level__c,
            'The log level should match the level passed into the log call'
        );
        Assert.areEqual(
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
        final String logLevel = EventBufferLogAdapter.ERROR;
        final String message = 'Test Log Message';
        EventBufferLogAdapter loggerAdapter = EventBufferLogAdapter.getInstance();
        loggerAdapter.setType(logType);
        Assert.isTrue(
            loggerAdapter.logsToPublish.isEmpty(),
            'The logs should be empty before log is called'
        );

        loggerAdapter.log(logLevel, message, testSObject.Id);

        Assert.areEqual(
            1,
            loggerAdapter.logsToPublish.size(),
            'The logs should not be empty after log is called'
        );
        Log_Event__e logToAssert = loggerAdapter.logsToPublish[0];
        Assert.areEqual(
            logType,
            logToAssert.Type__c,
            'The type should match the type passed into the adapters constructor'
        );
        Assert.areEqual(
            logLevel,
            logToAssert.Level__c,
            'The log level should match the level passed into the log call'
        );
        Assert.areEqual(
            message,
            logToAssert.Messages__c,
            'The message should match the message passed into the log call'
        );
        Assert.areEqual(
            testSObject.Id,
            logToAssert.Record_Id__c,
            'The record id should be appended to the log record'
        );
    }

    @IsTest
    private static void closeTest() {
        Assert.areEqual(
            0,
            [SELECT COUNT() FROM Log__c],
            'There should be no logs in the system before the test'
        );
        final String logType = 'Test Log Type';
        final String logLevel = EventBufferLogAdapter.ERROR;
        final String message = 'Test Log Message';
        EventBufferLogAdapter loggerAdapter = EventBufferLogAdapter.getInstance();
        loggerAdapter.setType(logType);

        loggerAdapter.log(logLevel, message);

        Test.startTest();
        try {
            loggerAdapter.close();
        } catch (Exception exceptionToHandle) {
            Assert.fail(
                'An error should not be thrown when writing logs, error provided: ' +
                exceptionToHandle.getMessage()
            );
        }
        Test.stopTest();

        List<Log__c> writtenLogs = [SELECT Type__c, Level__c, Messages__c FROM Log__c];

        Assert.areEqual(1, writtenLogs.size(), 'There should be 1 log generated in the system');

        Log__c logToAssert = writtenLogs[0];
        Assert.areEqual(
            logType,
            logToAssert.Type__c,
            'The type should match the type passed into the adapters constructor'
        );
        Assert.areEqual(
            logLevel,
            logToAssert.Level__c,
            'The log level should match the level passed into the log call'
        );
        Assert.areEqual(
            message,
            logToAssert.Messages__c,
            'The message should match the message passed into the log call'
        );
    }

    @IsTest
    private static void writeMultipleLogsTest() {
        Assert.areEqual(
            0,
            [SELECT COUNT() FROM Log__c],
            'There should be no logs in the system before the test'
        );
        final String logType = 'Test Log Type';
        final String logLevel = EventBufferLogAdapter.ERROR;
        final String message = 'Test Log Message';
        EventBufferLogAdapter loggerAdapter = EventBufferLogAdapter.getInstance();
        loggerAdapter.setType(logType);

        loggerAdapter.log(logLevel, message);

        Test.startTest();
        try {
            loggerAdapter.close();
            // Write the logs for a second time, this should not cause any problems
            loggerAdapter.close();
        } catch (Exception exceptionToHandle) {
            Assert.fail(
                'An error should not be thrown when writing logs, error provided: ' +
                exceptionToHandle.getMessage()
            );
        }
        Test.stopTest();

        List<Log__c> writtenLogs = [SELECT Type__c, Level__c, Messages__c FROM Log__c];

        Assert.areEqual(1, writtenLogs.size(), 'There should be 1 log generated in the system');

        Log__c logToAssert = writtenLogs[0];
        Assert.areEqual(
            logType,
            logToAssert.Type__c,
            'The type should match the type passed into the adapters constructor'
        );
        Assert.areEqual(
            logLevel,
            logToAssert.Level__c,
            'The log level should match the level passed into the log call'
        );
        Assert.areEqual(
            message,
            logToAssert.Messages__c,
            'The message should match the message passed into the log call'
        );
    }
}
