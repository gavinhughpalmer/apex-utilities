/*
 The bulk log object adapter can be used to insert logs as a custom object into the database,
 as a singleton the write logs can be called at the end of a trigger to insert the full logs into the system only once per object
*/
public without sharing class BulkLogObjectAdapter implements Logger.LoggerAdapter {

	@testVisible private static final String ERROR = 'Error';
	@testVisible private static final String WARNING = 'Warning';
	@testVisible private static final String INFO = 'Information';
	@testVisible private static final String DEBUG = 'Debug';

    private static final BulkLogObjectAdapter instance = new BulkLogObjectAdapter();

	private String logType;
	@testVisible private final List<Log__c> logsToWrite = new List<Log__c>();

    public static BulkLogObjectAdapter getInstance(String logType) {
        instance.setLogType(logType);
        return instance;
    }

    public static void writeLogs() {
        instance.commitLogs();
    }

	private BulkLogObjectAdapter() {}

	public void setLogType(String logType) {
		this.logType = logType;
	}

	public void log(Object logLevel, String message) {
		logsToWrite.add(
			new Log__c(
				Type__c = logType,
				Level__c = (String) logLevel,
				Messages__c = message
			)
		);
	}

	public Object errorLevel() {
		return ERROR;
	}
	public Object warningLevel() {
		return WARNING;
	}
	public Object infoLevel() {
		return INFO;
	}
	public Object debugLevel() {
		return DEBUG;
	}

	private void commitLogs() {
		if (!logsToWrite.isEmpty()) {
			// if error occurs allow to surface to the user as there is nothing else we can do here
			insert logsToWrite;
            logsToWrite.clear();
		}
	}
}