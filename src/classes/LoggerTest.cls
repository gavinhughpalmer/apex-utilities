/*
 Test class for the logger
*/
@isTest
private class LoggerTest {

    private enum LogLevel {
        ERROR,
        WARNING,
        INFO,
        DEBUG
    }

    // this logger adapter will be utilised in the test class to validate the logger methods
    private class TestLoggerAdapter implements Logger.LoggerAdapter {
        private final String messageToAssert;
        private final String levelToAssert;
        private final LogLevel levelCalled;
        private final Boolean containsMessage;

        public TestLoggerAdapter(String messageToAssert, String levelToAssert, LogLevel levelCalled) {
            this.messageToAssert = messageToAssert;
            this.levelToAssert = levelToAssert;
            this.levelCalled = levelCalled;
            this.containsMessage = false;
        }

        public TestLoggerAdapter(String messageToAssert, String levelToAssert, LogLevel levelCalled, Boolean containsMessage) {
            this.messageToAssert = messageToAssert;
            this.levelToAssert = levelToAssert;
            this.levelCalled = levelCalled;
            this.containsMessage = containsMessage;
        }

        public void log(Object logLevel, String message) {
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
        public Object errorLevel() {
            return levelCalled == LogLevel.ERROR ? levelToAssert : '';
        }
        public Object warningLevel() {
            return levelCalled == LogLevel.WARNING ? levelToAssert : '';
        }
        public Object infoLevel() {
            return levelCalled == LogLevel.INFO ? levelToAssert : '';
        }
        public Object debugLevel() {
            return levelCalled == LogLevel.DEBUG ? levelToAssert : '';
        }
    }

    @isTest
    private static void debugTest() {
        final String message = 'A test Message';
        final String customLogLevel = 'debug';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.DEBUG);
        Logger logger = new Logger(adapter);

        // assertions occur inside the adapter
        logger.debug(message);
    }

    @isTest
    private static void debugTest_WithApexClass() {
        final String message = 'A test Message';
        final String customLogLevel = 'debug';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.DEBUG, true);
        Logger logger = new Logger(LoggerTest.class, adapter);

        // assertions occur inside the adapter
        logger.debug(message);
    }

    @isTest
    private static void infoTest() {
        final String message = 'A test Message';
        final String customLogLevel = 'info';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.INFO);
        Logger logger = new Logger(adapter);

        // assertions occur inside the adapter
        logger.info(message);
    }

    @isTest
    private static void warnTest() {
        final String message = 'A test Message';
        final String customLogLevel = 'warn';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.WARNING);
        Logger logger = new Logger(adapter);

        // assertions occur inside the adapter
        logger.warn(message);
    }

    @isTest
    private static void errorTest() {
        final String message = 'A test Message';
        final String customLogLevel = 'error';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.ERROR);
        Logger logger = new Logger(adapter);

        // assertions occur inside the adapter
        logger.error(message);
    }

    @isTest
    private static void errorTest_WithException() {
        final String message = 'Required fields are missing';
        final String customLogLevel = 'error';
        TestLoggerAdapter adapter = new TestLoggerAdapter(message, customLogLevel, LogLevel.ERROR, true);
        Logger logger = new Logger(adapter);

        try {
            insert new Account();
        } catch (DmlException exceptionToHandle) {
            // assertions occur inside the adapter
            logger.error(exceptionToHandle);
        }
    }

    @isTest
    private static void testPageMessageLogAdapter_Error() {
        System.Test.clearApexPageMessages();

        Logger logger = new Logger(new Logger.PageMessageLogAdapter());

        final String messageToAssert = 'A test message';

        logger.error(messageToAssert);

        Assert.pageMessage(messageToAssert);
    }

    @isTest
    private static void testPageMessageLogAdapter_Warn() {
        System.Test.clearApexPageMessages();

        Logger logger = new Logger(new Logger.PageMessageLogAdapter());

        final String messageToAssert = 'A test message';

        logger.warn(messageToAssert);

        Assert.pageMessage(messageToAssert);
    }

    @isTest
    private static void testPageMessageLogAdapter_Debug() {
        System.Test.clearApexPageMessages();

        Logger logger = new Logger(new Logger.PageMessageLogAdapter());

        final String messageToAssert = 'A test message';

        logger.debug(messageToAssert);

        Assert.pageMessage(messageToAssert);
    }

    @isTest
    private static void testPageMessageLogAdapter_Info() {
        System.Test.clearApexPageMessages();

        Logger logger = new Logger(new Logger.PageMessageLogAdapter());

        final String messageToAssert = 'A test message';

        logger.info(messageToAssert);

        Assert.pageMessage(messageToAssert);
    }

    /*
    * Unfortunately we cannot assert against debug logs, so this will be purely for coverage
    */
    @isTest
    private static void testDebugLogAdapter() {
        Logger logger = new Logger(new Logger.DebugLogAdapter());
        logger.warn('');
        logger.error('');
        logger.info('');
        logger.debug('');
    }
}