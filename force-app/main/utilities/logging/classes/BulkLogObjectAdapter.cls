/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 2.0
* @description The bulk log object adapter can be used to insert logs as a custom object into the database,
* as a singleton the write logs can be called at the end of a trigger to insert the full logs into the system only once per object
* The class has been adapted to use events so that it can still insert log objects when a transaction is rolled back, allowing it
* to be more robust in trigger contexts
* Usage:
* Logger log = LoggerFactory.createLogger(MyClass.class);
* log.warn('A warning message');
* log.close();
*
* 2018-06-27 : Gavin Palmer - Original
**/
public without sharing class BulkLogObjectAdapter extends LoggerAdapter {

    @testVisible private static final String ERROR = 'Error';
    @testVisible private static final String WARNING = 'Warning';
    @testVisible private static final String INFO = 'Information';
    @testVisible private static final String DEBUG = 'Debug';

    private static final BulkLogObjectAdapter INSTANCE = new BulkLogObjectAdapter();

    @testVisible private final Map<String, List<Log_Event__e>> logsByLevels = new Map<String, List<Log_Event__e>>();
    @testVisible // TODO Should the logging levels be in the bulk object adapter or in the base? as this isn't just tied to the log oject
    private static final Set<String> LOGGING_LEVELS = new Set<String>();

    static {
        for (Logging_Level__mdt loggingLevel : [SELECT DeveloperName FROM Logging_Level__mdt]) {
            LOGGING_LEVELS.add(loggingLevel.DeveloperName);
        }
    }

    public static BulkLogObjectAdapter getInstance() {
        return INSTANCE;
    }

    private BulkLogObjectAdapter() {
        flushLogs();
    }
    private void flushLogs() {
        logsByLevels.clear();
        logsByLevels.put(ERROR, new List<Log_Event__e>());
        logsByLevels.put(WARNING, new List<Log_Event__e>());
        logsByLevels.put(INFO, new List<Log_Event__e>());
        logsByLevels.put(DEBUG, new List<Log_Event__e>());
    }
    public override void log(Object logLevel, String message) {
        log(logLevel, message, null);
    }
    public override void log(Object logLevel, String message, Id recordId) {
        Request currentRequest = Request.getCurrent();
        Log_Event__e logEvent = new Log_Event__e(
            Type__c = logType,
            Level__c = (String) logLevel,
            Messages__c = message,
            Record_Id__c = recordId,
            Quiddity__c = currentRequest.getQuiddity().name(),
            Transaction_Id__c = currentRequest.getRequestId()
        );
        logsByLevels.get(logEvent.Level__c).add(logEvent);
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
        List<Log_Event__e> logsToWrite = getLogsToWrite();
        if (!logsToWrite.isEmpty()) {
            // if error occurs allow to surface to the user as there is nothing else we can do here
            EventBus.publish(logsToWrite);
            flushLogs();
        }
    }
    public List<Log_Event__e> getLogsToWrite() {
        if (logsByLevels.isEmpty()) {
            return new List<Log_Event__e>();
        }
        List<Log_Event__e> logsToReturn = new List<Log_Event__e>();
        for (String loggingLevel :LOGGING_LEVELS) {
            List<Log_Event__e> currentLogs = logsByLevels.get(loggingLevel);
            logsToReturn.addAll(currentLogs);
        }
        return logsToReturn;
    }
}