public with sharing class LoggerFactory {
    public static Logger createLogger(Type apexClass) {
        // TODO some kind of managment of the type of adapter to be used
        return new Logger(apexClass, BulkLogObjectAdapter.getInstance());
    }
}
