/**
 * @author Gavin Palmer
 * @date 2018-06-27
 * @group Logging
 * @description The logger adapter exposes the log method and the specific log levels to be implemented by whatever class implements it
 *
 **/
@SuppressWarnings('PMD.ExcessivePublicCount')
public abstract class LoggerAdapter {
    protected String logType;

    public virtual void setType(String type) {
        logType = type;
    }
    public abstract void log(Object logLevel, String message);
    public virtual void log(Object logLevel, String message, Id recordId) {
        message = 'Record Id: ' + recordId + ' message: ' + message;
        log(logLevel, message);
    }
    public abstract Object errorLevel();
    public abstract Object warningLevel();
    public abstract Object infoLevel();
    public abstract Object debugLevel();

    @SuppressWarnings('PMD.EmptyStatementBlock')
    public virtual void close() {
        // by default nothing needed here
    }

    /**
     * Implementation of LoggerAdapter that directs all logging through the built-in Apex method <code>System.debug()</code>
     */
    public class DebugLogAdapter extends LoggerAdapter {
        public override void log(Object logLevel, String message) {
            System.debug((LoggingLevel) logLevel, message);
        }

        public override Object errorLevel() {
            return LoggingLevel.ERROR;
        }
        public override Object warningLevel() {
            return LoggingLevel.WARN;
        }
        public override Object infoLevel() {
            return LoggingLevel.INFO;
        }
        public override Object debugLevel() {
            return LoggingLevel.DEBUG;
        }
    }
}
