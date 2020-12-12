/**
 * @author Gavin Palmer
 * @description This factory class is used to abstract away the creation of the Logger and which adapter it is using,
 * which will allow for the adapters to be swapped out easier
 *
 * @date 2020-11-20
 **/
public with sharing class LoggerFactory {
    public static Logger createLogger(Type apexClass) {
        return new Logger(apexClass, BulkLogObjectAdapter.getInstance());
    }
}
