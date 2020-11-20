/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description This factory class is used to abstract away the creation of the Logger and which adapter it is using,
 * which will allow for the adapters to be swapped out easier
 *
 * 2020-11-20 : Gavin Palmer - Original
 **/
public with sharing class LoggerFactory {
    public static Logger createLogger(Type apexClass) {
        // TODO some kind of managment of the type of adapter to be used
        return new Logger(apexClass, BulkLogObjectAdapter.getInstance());
    }
}
