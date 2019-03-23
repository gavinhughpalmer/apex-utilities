/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
* @description Test class for the logger
*
* 2018-06-27 : Gavin Palmer - Original
**/
@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class LoggerTest {

    private enum LogLevel {
        ERROR,
        WARNING,
        INFO,
        DEBUG
    }

    // this logger adapter will be utilised in the test class to validate the logger methods
    private class TestLoggerAdapter extends Logger.LoggerAdapter {
        private final String messageToAssert;
        private final String levelToAssert;
        private final LogLevel levelCalled;
        private Boolean containsMessage = false;

        public TestLoggerAdapter(String messageToAssert, String levelToAssert, LogLevel levelCalled) {
            this.messageToAssert = messageToAssert;
            this.levelToAssert = levelToAssert;
            this.levelCalled = levelCalled;
        }

        public void setContainsMessage(Boolean containsMessage) {
            this.containsMessage = containsMessage;
        }

        public override void log(Object logLevel, String message) {
            System.assert(
                logLevel instanceof String, 'The log level should return a string'
            );
            System.assertEquals(
                levelToAssert,
                (String) logLevel,
                'The log level should be the same as what was constructed in the adapter'
            );
            if (containsMessage) {
                System.assert(
                    message.containsIgnoreCase(messageToAssert),
                    'The provided error, ' + messageToAssert + ' should be contained within the exception message: ' + message
                );
            } else {
                System.assertEquals(
                    messageToAssert, message,
                    'The message should be the same as the one passed in the constructor'
                );
            }
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
        Logger logger = new Logger(adapter);

        // assertions occur inside the adapter
        logger.debug(message);
    }

    @IsTest
    private static void debugTestWithRecordId() {
        final String message = 'A test Message';
        final String customLogLevel = 'debug';
        AccountTestFactory accountFactory = new AccountTestFactory();
        Account testAccount = (Account) accountFactory.insertSObject();

        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.DEBUG);
        adapter.setContainsMessage(true);
        Logger logger = new Logger(LoggerTest.class, adapter);

        logger.debug(message, testAccount.Id);

        adapter = new TestLoggerAdapter(testAccount.Id, customLogLevel, LogLevel.DEBUG);
        adapter.setContainsMessage(true);
        logger = new Logger(LoggerTest.class, adapter);

        logger.debug(message, testAccount.Id);
    }

    @IsTest
    private static void debugTestWithApexClass() {
        final String message = 'A test Message';
        final String customLogLevel = 'debug';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.DEBUG);
        adapter.setContainsMessage(true);
        Logger logger = new Logger(LoggerTest.class, adapter);

        // assertions occur inside the adapter
        logger.debug(message);
    }

    @IsTest
    private static void infoTest() {
        final String message = 'A test Message';
        final String customLogLevel = 'info';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.INFO);
        Logger logger = new Logger(adapter);

        // assertions occur inside the adapter
        logger.info(message);
    }

    @IsTest
    private static void infoTestWithRecordId() {
        final String message = 'A test Message';
        final String customLogLevel = 'info';
        AccountTestFactory accountFactory = new AccountTestFactory();
        Account testAccount = (Account) accountFactory.insertSObject();

        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.INFO);
        adapter.setContainsMessage(true);
        Logger logger = new Logger(LoggerTest.class, adapter);

        logger.info(message, testAccount.Id);

        adapter = new TestLoggerAdapter(testAccount.Id, customLogLevel, LogLevel.INFO);
        adapter.setContainsMessage(true);
        logger = new Logger(LoggerTest.class, adapter);

        logger.info(message, testAccount.Id);
    }

    @IsTest
    private static void warnTest() {
        final String message = 'A test Message';
        final String customLogLevel = 'warn';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.WARNING);
        Logger logger = new Logger(adapter);

        // assertions occur inside the adapter
        logger.warn(message);
    }

    @IsTest
    private static void warnTestWithRecordId() {
        final String message = 'A test Message';
        final String customLogLevel = 'warn';
        AccountTestFactory accountFactory = new AccountTestFactory();
        Account testAccount = (Account) accountFactory.insertSObject();

        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.WARNING);
        adapter.setContainsMessage(true);
        Logger logger = new Logger(LoggerTest.class, adapter);

        logger.warn(message, testAccount.Id);

        adapter = new TestLoggerAdapter(testAccount.Id, customLogLevel, LogLevel.WARNING);
        adapter.setContainsMessage(true);
        logger = new Logger(LoggerTest.class, adapter);

        logger.warn(message, testAccount.Id);
    }

    @IsTest
    private static void errorTest() {
        final String message = 'A test Message';
        final String customLogLevel = 'error';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.ERROR);
        Logger logger = new Logger(adapter);

        // assertions occur inside the adapter
        logger.error(message);
    }

    @IsTest
    private static void errorTestWithRecordId() {
        final String message = 'A test Message';
        final String customLogLevel = 'error';
        AccountTestFactory accountFactory = new AccountTestFactory();
        Account testAccount = (Account) accountFactory.insertSObject();

        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.ERROR);
        adapter.setContainsMessage(true);
        Logger logger = new Logger(LoggerTest.class, adapter);

        logger.error(message, testAccount.Id);

        adapter = new TestLoggerAdapter(testAccount.Id, customLogLevel, LogLevel.ERROR);
        adapter.setContainsMessage(true);
        logger = new Logger(LoggerTest.class, adapter);

        logger.error(message, testAccount.Id);
    }

    @IsTest
    private static void errorTestWithException() {
        final String message = 'Required fields are missing';
        final String customLogLevel = 'error';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.ERROR);
        adapter.setContainsMessage(true);
        Logger logger = new Logger(adapter);

        try {
            insert new Account();
        } catch (DmlException exceptionToHandle) {
            // assertions occur inside the adapter
            logger.error(exceptionToHandle);
        }
    }

    @IsTest
    private static void errorTestWithExceptionWithRecordId() {
        AccountTestFactory accountFactory = new AccountTestFactory();
        Account testAccount = (Account) accountFactory.insertSObject();
        final String message = 'Required fields are missing';
        final String customLogLevel = 'error';
        TestLoggerAdapter adapter = new TestLoggerAdapter(testAccount.Id, customLogLevel, LogLevel.ERROR);
        adapter.setContainsMessage(true);
        Logger logger = new Logger(adapter);

        try {
            insert testAccount;
        } catch (DmlException exceptionToHandle) {
            // assertions occur inside the adapter
            logger.error(exceptionToHandle, testAccount.Id);
        }
    }

    @IsTest
    private static void testPageMessageLogAdapterError() {
        System.Test.clearApexPageMessages();

        Logger logger = new Logger(new Logger.PageMessageLogAdapter());

        final String messageToAssert = 'A test message';

        logger.error(messageToAssert);

        Assert.pageMessage(messageToAssert);
    }

    @IsTest
    private static void testPageMessageLogAdapterWarn() {
        System.Test.clearApexPageMessages();

        Logger logger = new Logger(new Logger.PageMessageLogAdapter());

        final String messageToAssert = 'A test message';

        logger.warn(messageToAssert);

        Assert.pageMessage(messageToAssert);
    }

    @IsTest
    private static void testPageMessageLogAdapterDebug() {
        System.Test.clearApexPageMessages();

        Logger logger = new Logger(new Logger.PageMessageLogAdapter());

        final String messageToAssert = 'A test message';

        logger.debug(messageToAssert);

        Assert.pageMessage(messageToAssert);
    }

    @IsTest
    private static void testPageMessageLogAdapterInfo() {
        System.Test.clearApexPageMessages();

        Logger logger = new Logger(new Logger.PageMessageLogAdapter());

        final String messageToAssert = 'A test message';

        logger.info(messageToAssert);

        Assert.pageMessage(messageToAssert);
    }

    /*
    * Unfortunately we cannot assert against debug logs, so this will be purely for coverage
    */
    @IsTest
    private static void testDebugLogAdapter() {
        Logger logger = new Logger(new Logger.DebugLogAdapter());
        logger.warn('');
        logger.error('');
        logger.info('');
        logger.debug('');
    }
}