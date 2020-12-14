/**
 * @author Gavin Palmer
 * @date 2018-06-27
 *
 **/
@IsTest(isParallel=true)
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class LoggerTest {
    private enum LogLevel {
        ERROR,
        WARNING,
        INFO,
        DEBUG
    }

    // this logger adapter will be utilised in the test class to validate the logger methods
    private class TestLoggerAdapter extends LoggerAdapter {
        private final String messageToAssert;
        private final String levelToAssert;
        private final LogLevel levelCalled;

        public TestLoggerAdapter(
            String messageToAssert,
            String levelToAssert,
            LogLevel levelCalled
        ) {
            this.messageToAssert = messageToAssert;
            this.levelToAssert = levelToAssert;
            this.levelCalled = levelCalled;
        }

        public override void log(Object logLevel, String message) {
            System.assert(logLevel instanceof String, 'The log level should return a string');
            System.assertEquals(
                levelToAssert,
                (String) logLevel,
                'The log level should be the same as what was constructed in the adapter'
            );
            System.assert(
                message.containsIgnoreCase(messageToAssert),
                'The provided error, ' +
                messageToAssert +
                ' should be contained within the exception message: ' +
                message
            );
        }
        public override Object errorLevel() {
            return levelCalled == LogLevel.ERROR ? levelToAssert : '';
        }
        public override Object warningLevel() {
            return levelCalled == LogLevel.WARNING ? levelToAssert : '';
        }
        public override Object infoLevel() {
            return levelCalled == LogLevel.INFO ? levelToAssert : '';
        }
        public override Object debugLevel() {
            return levelCalled == LogLevel.DEBUG ? levelToAssert : '';
        }
    }

    @IsTest
    private static void debugTest() {
        final String message = 'A test Message';
        final String customLogLevel = 'debug';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.DEBUG);
        Logger logger = new Logger(LoggerTest.class, adapter);

        // assertions occur inside the adapter
        logger.debug(message);
    }

    @IsTest
    private static void debugTestWithRecordId() {
        final String message = 'A test Message';
        final String customLogLevel = 'debug';
        SObjectTestFactory testFactory = new SObjectTestFactory();
        SObject testSObject = testFactory.insertSObject();

        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.DEBUG);
        Logger logger = new Logger(LoggerTest.class, adapter);

        logger.debug(message, testSObject.Id);

        adapter = new TestLoggerAdapter(testSObject.Id, customLogLevel, LogLevel.DEBUG);
        logger = new Logger(LoggerTest.class, adapter);

        logger.debug(message, testSObject.Id);
    }

    @IsTest
    private static void debugTestWithApexClass() {
        final String message = 'A test Message';
        final String customLogLevel = 'debug';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.DEBUG);
        Logger logger = new Logger(LoggerTest.class, adapter);

        // assertions occur inside the adapter
        logger.debug(message);
    }

    @IsTest
    private static void infoTest() {
        final String message = 'A test Message';
        final String customLogLevel = 'info';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.INFO);
        Logger logger = new Logger(LoggerTest.class, adapter);

        // assertions occur inside the adapter
        logger.info(message);
    }

    @IsTest
    private static void infoTestWithRecordId() {
        final String message = 'A test Message';
        final String customLogLevel = 'info';
        SObjectTestFactory testFactory = new SObjectTestFactory();
        SObject testSObject = testFactory.insertSObject();

        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.INFO);
        Logger logger = new Logger(LoggerTest.class, adapter);

        logger.info(message, testSObject.Id);

        adapter = new TestLoggerAdapter(testSObject.Id, customLogLevel, LogLevel.INFO);
        logger = new Logger(LoggerTest.class, adapter);

        logger.info(message, testSObject.Id);
    }

    @IsTest
    private static void warnTest() {
        final String message = 'A test Message';
        final String customLogLevel = 'warn';
        TestLoggerAdapter adapter = new TestLoggerAdapter(
            message,
            customLogLevel,
            LogLevel.WARNING
        );
        Logger logger = new Logger(LoggerTest.class, adapter);

        // assertions occur inside the adapter
        logger.warn(message);
    }

    @IsTest
    private static void warnTestWithRecordId() {
        final String message = 'A test Message';
        final String customLogLevel = 'warn';
        SObjectTestFactory testFactory = new SObjectTestFactory();
        SObject testSObject = testFactory.insertSObject();

        TestLoggerAdapter adapter = new TestLoggerAdapter(
            message,
            customLogLevel,
            LogLevel.WARNING
        );
        Logger logger = new Logger(LoggerTest.class, adapter);

        logger.warn(message, testSObject.Id);

        adapter = new TestLoggerAdapter(testSObject.Id, customLogLevel, LogLevel.WARNING);
        logger = new Logger(LoggerTest.class, adapter);

        logger.warn(message, testSObject.Id);
    }

    @IsTest
    private static void errorTest() {
        final String message = 'A test Message';
        final String customLogLevel = 'error';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.ERROR);
        Logger logger = new Logger(LoggerTest.class, adapter);

        // assertions occur inside the adapter
        logger.error(message);
    }

    @IsTest
    private static void errorTestWithRecordId() {
        final String message = 'A test Message';
        final String customLogLevel = 'error';
        SObjectTestFactory testFactory = new SObjectTestFactory();
        SObject testSObject = testFactory.insertSObject();

        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.ERROR);
        Logger logger = new Logger(LoggerTest.class, adapter);

        logger.error(message, testSObject.Id);

        adapter = new TestLoggerAdapter(testSObject.Id, customLogLevel, LogLevel.ERROR);
        logger = new Logger(LoggerTest.class, adapter);

        logger.error(message, testSObject.Id);
    }

    @IsTest
    private static void errorTestWithException() {
        final String message = 'Required fields are missing';
        final String customLogLevel = 'error';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.ERROR);
        Logger logger = new Logger(LoggerTest.class, adapter);

        try {
            insert new Account();
        } catch (DmlException exceptionToHandle) {
            // assertions occur inside the adapter
            logger.error(exceptionToHandle);
        }
    }

    @IsTest
    private static void errorTestWithExceptionWithRecordId() {
        SObjectTestFactory testFactory = new SObjectTestFactory();
        SObject testSObject = testFactory.insertSObject();
        final String customLogLevel = 'error';
        TestLoggerAdapter adapter = new TestLoggerAdapter(
            testSObject.Id,
            customLogLevel,
            LogLevel.ERROR
        );
        Logger logger = new Logger(LoggerTest.class, adapter);

        try {
            insert testSObject;
        } catch (DmlException exceptionToHandle) {
            // assertions occur inside the adapter
            logger.error(exceptionToHandle, testSObject.Id);
        }
    }

    /*
     * Unfortunately we cannot assert against debug logs, so this will be purely for coverage
     */
    @IsTest
    private static void testDebugLogAdapter() {
        Logger logger = new Logger(LoggerTest.class, new LoggerAdapter.DebugLogAdapter());
        logger.warn('');
        logger.error('');
        logger.info('');
        logger.debug('');
    }
}
