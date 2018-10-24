/*
 * Copyright 2017-present Sirono LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/*
 The logger provides an extendable logging interface,
 the actual logging option can be easily switched by the use of the LoggerAdapter inner class
 Thhis class was adapted from https://github.com/blueprinthealth/sirono-common/blob/master/src/classes/Logger.cls
*/
public class Logger {

    private static final String MESSAGE_FORMAT = 'An error has occured in the class {0} with the message: {1}';

    private final LoggerAdapter loggerAdapter;
    private final Type apexClass;

    public Logger(Type apexClass, LoggerAdapter loggerAdapter) {
        this.apexClass = apexClass;
        this.loggerAdapter = loggerAdapter;
    }

    public Logger(LoggerAdapter loggerAdapter) {
        this.loggerAdapter = loggerAdapter;
    }

    public void debug(String messageToLog) {
        loggerAdapter.log(loggerAdapter.debugLevel(), getFullMessage(messageToLog));
    }

    public void info(String messageToLog) {
        loggerAdapter.log(loggerAdapter.infoLevel(), getFullMessage(messageToLog));
    }

    public void warn(String messageToLog) {
        loggerAdapter.log(loggerAdapter.warningLevel(), getFullMessage(messageToLog));
    }

    public void error(String messageToLog) {
        loggerAdapter.log(loggerAdapter.errorLevel(), getFullMessage(messageToLog));
    }

    public void error(Exception exceptionToLog) {
        loggerAdapter.log(
            loggerAdapter.errorLevel(),
            getFullMessage(
                String.format(
                    '{0}\n{1}',
                    new List<String>{exceptionToLog.getMessage(), exceptionToLog.getStackTraceString()}
                )
            )
        );
    }

    private String getFullMessage(String message) {
        if (apexClass != null) {
            message = String.format(
                MESSAGE_FORMAT, new List<String>{apexClass.getName(), message}
            );
        }
        return message;
    }

    /**
     * The logger adapter exposes the log method and the specific log levels to be implemented by whatever class implements it
     */
    public interface LoggerAdapter {
        void log(Object logLevel, String message);
        Object errorLevel();
        Object warningLevel();
        Object infoLevel();
        Object debugLevel();
    }

    /**
     * Implementation of LoggerAdapter that directs all logging through the built-in Apex method <code>System.debug()</code>
     */
    public class DebugLogAdapter implements LoggerAdapter {

        public void log(Object logLevel, String message) {
            System.debug((LoggingLevel) logLevel, message);
        }

        public Object errorLevel() {
            return LoggingLevel.ERROR;
        }
        public Object warningLevel() {
            return LoggingLevel.WARN;
        }
        public Object infoLevel() {
            return LoggingLevel.INFO;
        }
        public Object debugLevel() {
            return LoggingLevel.DEBUG;
        }
    }

    /**
     * Implementation of LoggerAdapter that directs all logging to the page
     */
    public class PageMessageLogAdapter implements LoggerAdapter {

        public void log(Object logLevel, String message) {
            ApexPages.addMessage(new ApexPages.message((ApexPages.Severity) logLevel, message));
        }

        public Object errorLevel() {
            return ApexPages.Severity.ERROR;
        }
        public Object warningLevel() {
            return ApexPages.Severity.WARNING;
        }
        public Object infoLevel() {
            return ApexPages.Severity.INFO;
        }
        public Object debugLevel() {
            return ApexPages.Severity.INFO;
        }
    }
}