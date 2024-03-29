/**
 * @author Gavin Palmer
 * @date 2018-06-27
 * @group Logging
 * @description The bulk log object adapter can be used to insert logs as a custom object into the database,
 * as a singleton the write logs can be called at the end of a trigger to insert the full logs into the system only once per object
 * The class has been adapted to use events so that it can still insert log objects when a transaction is rolled back, allowing it
 * to be more robust in trigger contexts
 * Usage:
 * Logger log = LoggerFactory.createLogger(MyClass.class);
 * log.warn('A warning message');
 * log.close();
 *
 **/
public without sharing class EventBufferLogAdapter extends LoggerAdapter {
    @testVisible
    private static final String ERROR = 'Error';
    @testVisible
    private static final String WARNING = 'Warning';
    @testVisible
    private static final String INFO = 'Information';
    @testVisible
    private static final String DEBUG = 'Debug';

    private static final Integer MAX_LOG_BUFFER = 10;

    private static final EventBufferLogAdapter INSTANCE = new EventBufferLogAdapter();

    @testVisible
    private final List<Log_Event__e> logsToPublish = new List<Log_Event__e>();
    @testVisible
    private static final Set<String> LOGGING_LEVELS = new Set<String>();

    static {
        for (Logging_Level__mdt loggingLevel : [SELECT DeveloperName FROM Logging_Level__mdt]) {
            LOGGING_LEVELS.add(loggingLevel.DeveloperName);
        }
    }

    public static EventBufferLogAdapter getInstance() {
        return INSTANCE;
    }

    @SuppressWarnings('PMD.EmptyStatementBlock')
    private EventBufferLogAdapter() {
    }

    public override void log(Object logLevel, String message) {
        log(logLevel, message, null);
    }
    public override void log(Object logLevel, String message, Id recordId) {
        String logLevelString = (String) logLevel;
        if (LOGGING_LEVELS.contains(logLevelString)) {
            logsToPublish.add(createLogEvent(logLevelString, message, recordId));
        }
        if (logsToPublish.size() >= MAX_LOG_BUFFER) {
            close();
        }
    }
    private Log_Event__e createLogEvent(String logLevel, String message, Id recordId) {
        Request currentRequest = Request.getCurrent();
        return new Log_Event__e(
            Type__c = logType,
            Level__c = logLevel,
            Messages__c = message,
            Record_Id__c = recordId,
            Quiddity__c = currentRequest.getQuiddity().name(),
            Transaction_Id__c = currentRequest.getRequestId()
        );
    }
    public override Object errorLevel() {
        return ERROR;
    }
    public override Object warningLevel() {
        return WARNING;
    }
    public override Object infoLevel() {
        return INFO;
    }
    public override Object debugLevel() {
        return DEBUG;
    }
    public override void close() {
        if (!logsToPublish.isEmpty()) {
            // if error occurs allow to surface to the user as there is nothing else we can do here
            EventBus.publish(logsToPublish);
            logsToPublish.clear();
        }
    }
}
