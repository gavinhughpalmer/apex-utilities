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
 * @author Gavin Palmer
 * @date 2018-06-27
 * @group Logging
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
 **/
@SuppressWarnings('PMD.ExcessivePublicCount')
public without sharing class Logger {
    private static final String MESSAGE_FORMAT = 'An error has occured in the class {0} with the message: {1}';

    private final LoggerAdapter loggerAdapter;

    public Logger(Type apexClass, LoggerAdapter loggerAdapter) {
        this.loggerAdapter = loggerAdapter;
        this.loggerAdapter.setType(apexClass.getName());
    }

    public void setType(String type) {
        this.loggerAdapter.setType(type);
    }


    // Logger should somehow take a map of string to object to log more complex messages with fiels that can then be made searchable?
    public void debug(String messageToLog) {
        loggerAdapter.log(loggerAdapter.debugLevel(), (new LogMessage(messageToLog)).toString());
    }

    public void debug(String messageToLog, Id recordId) {
        loggerAdapter.log(
            loggerAdapter.debugLevel(),
            (new LogMessage(messageToLog)).toString(),
            recordId
        );
    }

    public void info(String messageToLog) {
        loggerAdapter.log(loggerAdapter.infoLevel(), (new LogMessage(messageToLog)).toString());
    }

    public void info(String messageToLog, Id recordId) {
        loggerAdapter.log(
            loggerAdapter.infoLevel(),
            (new LogMessage(messageToLog)).toString(),
            recordId
        );
    }

    public void warn(String messageToLog) {
        loggerAdapter.log(loggerAdapter.warningLevel(), (new LogMessage(messageToLog)).toString());
    }

    public void warn(String messageToLog, Id recordId) {
        loggerAdapter.log(
            loggerAdapter.warningLevel(),
            (new LogMessage(messageToLog)).toString(),
            recordId
        );
    }

    public void error(String messageToLog) {
        loggerAdapter.log(loggerAdapter.errorLevel(), (new LogMessage(messageToLog)).toString());
    }

    public void error(String messageToLog, Id recordId) {
        loggerAdapter.log(
            loggerAdapter.errorLevel(),
            (new LogMessage(messageToLog)).toString(),
            recordId
        );
    }

    public void error(Exception exceptionToLog) {
        error((new LogMessage(exceptionToLog)).toString());
    }

    public void error(Exception exceptionToLog, Id recordId) {
        error((new LogMessage(exceptionToLog)).toString(), recordId);
    }

    /*
     * @description this method should be called after the logs have been written,
     * the logger adapter will then close off any open transactions (or fire the events in the case of the <<BulkLogObjectAdapter>>)
     */
    public void close() {
        runApexPofiling();
        loggerAdapter.close();
    }

    private void runApexPofiling() {
        Profiler profiler = new ApexProfiler();
        String profilingReport = profiler.generateProfilingReport();
        if (profiler.isBreachingWarning()) {
            warn(profilingReport);
        } else {
            info(profilingReport);
        }
    }
}
