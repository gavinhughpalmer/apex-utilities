/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 2.0
* @description The bulk log object adapter can be used to insert logs as a custom object into the database,
* as a singleton the write logs can be called at the end of a trigger to insert the full logs into the system only once per object
* The class has been adapted to use events so that it can still insert log objects when a transaction is rolled back, allowing it
* to be more robust in trigger contexts
* Usage:
* Logger log = new Logger(BulkLogObjectAdapter.getInstance('Integration'));
* log.warn('A warning message');
* BulkLogObjectAdapter.writeLogs();
*
* 2018-06-27 : Gavin Palmer - Original
**/
public without sharing class BulkLogObjectAdapter extends Logger.LoggerAdapter {

    @testVisible private static final String ERROR = 'Error';
    @testVisible private static final String WARNING = 'Warning';
    @testVisible private static final String INFO = 'Information';
    @testVisible private static final String DEBUG = 'Debug';

    private static BulkLogObjectAdapter instance = new BulkLogObjectAdapter();

    private String logType;
    @testVisible private final Map<String, List<Log_Event__e>> logsToWrite = new Map<String, List<Log_Event__e>>();
    @testVisible
    private static final Set<String> LOGGING_LEVELS = new Set<String>();

    static {
        for (Logging_Level__mdt loggingLevel : [SELECT DeveloperName FROM Logging_Level__mdt]) {
            LOGGING_LEVELS.add(loggingLevel.DeveloperName);
        }
    }

    public static BulkLogObjectAdapter getInstance(String logType) {
        instance.setLogType(logType);
        return instance;
    }

    // This method is to be used if any calling entity straddles multiple transactions (ie async apex)
    public static void setInstance(BulkLogObjectAdapter instanceToSet) {
        instance = instanceToSet;
    }

    public static void writeLogs() {
        instance.commitLogs();
    }

    private BulkLogObjectAdapter() {
        resetLogsToWrite();
    }

    private void resetLogsToWrite() {
        logsToWrite.clear();
        logsToWrite.put(ERROR, new List<Log_Event__e>());
        logsToWrite.put(WARNING, new List<Log_Event__e>());
        logsToWrite.put(INFO, new List<Log_Event__e>());
        logsToWrite.put(DEBUG, new List<Log_Event__e>());
    }

    public void setLogType(String logType) {
        this.logType = logType;
    }

    public override void log(Object logLevel, String message) {
        log(logLevel, message, null);
    }

    public override void log(Object logLevel, String message, Id recordId) {
        Log_Event__e logEvent = new Log_Event__e(
            Type__c = logType,
            Level__c = (String) logLevel,
            Messages__c = message,
            Record_Id__c = recordId
        );
        logsToWrite.get(logEvent.Level__c).add(logEvent);
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

    private void commitLogs() {
        logProfilingWarning();
        if (!logsToWrite.isEmpty()) {
            // if error occurs allow to surface to the user as there is nothing else we can do here
            EventBus.publish(getAllLogsToWrite());
            resetLogsToWrite();
        }
    }

    public List<Log_Event__e> getAllLogsToWrite() {
        List<Log_Event__e> logsToReturn = new List<Log_Event__e>();
        for (Logging_Level__mdt loggingLevel : LOGGING_LEVELS) {
            List<Log_Event__e> currentLogs = logsToWrite.get(loggingLevel.DeveloperName);
            logsToReturn.addAll(currentLogs);
        }
        return logsToReturn;
    }

    private void logProfilingWarning() {
        Profiler profiler = new ApexProfiler();
        if (profiler.isBreachingWarning()) {
            log(
                warningLevel(),
                profiler.getProfilingReport()
            );
        }
    }
}