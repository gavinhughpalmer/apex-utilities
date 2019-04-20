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

/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
* @description The logger provides an extendable logging interface, the actual logging option can be easily switched by the use of the LoggerAdapter inner class. 
* This class was adapted from https://github.com/blueprinthealth/sirono-common/blob/master/src/classes/Logger.cls
* Usage:
* Logger log = new Logger(new DebugLogAdapter());
* log.warn('A warning is here');
* try {
*     insert new Account();
* } catch (DmlException exceptionToHandle) {
*     log.error(exceptionToHandle);
* }
*
* 2018-06-27 : Gavin Palmer - Original
**/
public without sharing class Logger {

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

    public void debug(String messageToLog, Id recordId) {
        loggerAdapter.log(
            loggerAdapter.debugLevel(), 
            getFullMessage(messageToLog),
            recordId
        );
    }

    public void info(String messageToLog) {
        loggerAdapter.log(loggerAdapter.infoLevel(), getFullMessage(messageToLog));
    }

    public void info(String messageToLog, Id recordId) {
        loggerAdapter.log(
            loggerAdapter.infoLevel(), 
            getFullMessage(messageToLog),
            recordId
        );
    }

    public void warn(String messageToLog) {
        loggerAdapter.log(loggerAdapter.warningLevel(), getFullMessage(messageToLog));
    }

    public void warn(String messageToLog, Id recordId) {
        loggerAdapter.log(
            loggerAdapter.warningLevel(), 
            getFullMessage(messageToLog),
            recordId
        );
    }

    public void error(String messageToLog) {
        loggerAdapter.log(loggerAdapter.errorLevel(), getFullMessage(messageToLog));
    }

    public void error(String messageToLog, Id recordId) {
        loggerAdapter.log(
            loggerAdapter.errorLevel(), 
            getFullMessage(messageToLog),
            recordId
        );
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

    public void error(Exception exceptionToLog, Id recordId) {
        loggerAdapter.log(
            loggerAdapter.errorLevel(),
            getFullMessage(
                String.format(
                    '{0}\n{1}',
                    new List<String>{exceptionToLog.getMessage(), exceptionToLog.getStackTraceString()}
                )
            ), 
            recordId
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
    public abstract class LoggerAdapter {
        public abstract void log(Object logLevel, String message);
        public virtual void log(Object logLevel, String message, Id recordId) {
            message = 'Record Id: ' + recordId + ' message: ' + message;
            log(logLevel, message);
        }
        public abstract Object errorLevel();
        public abstract Object warningLevel();
        public abstract Object infoLevel();
        public abstract Object debugLevel();
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

    /**
     * Implementation of LoggerAdapter that directs all logging to the page
     */
    public class PageMessageLogAdapter extends LoggerAdapter {

        public override void log(Object logLevel, String message) {
            ApexPages.addMessage(new ApexPages.message((ApexPages.Severity) logLevel, message));
        }

        public override Object errorLevel() {
            return ApexPages.Severity.ERROR;
        }
        public override Object warningLevel() {
            return ApexPages.Severity.WARNING;
        }
        public override Object infoLevel() {
            return ApexPages.Severity.INFO;
        }
        public override Object debugLevel() {
            return ApexPages.Severity.INFO;
        }
    }
}