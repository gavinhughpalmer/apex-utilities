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
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
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
@SuppressWarnings('PMD.ExcessivePublicCount')
public without sharing class Logger {

    private static final String MESSAGE_FORMAT = 'An error has occured in the class {0} with the message: {1}';

    private final LoggerAdapter loggerAdapter;
    private final Type apexClass;

    public Logger(Type apexClass, LoggerAdapter loggerAdapter) {
        this.apexClass = apexClass;
        this.loggerAdapter = loggerAdapter;
        this.loggerAdapter.setType(apexClass.getName());
    }

    public void setType(String type) {
        this.loggerAdapter.setType(type);
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
        error(
            getFullMessage(
                exceptionToLog.getMessage(), exceptionToLog.getStackTraceString()
            )
        );
    }

    public void error(Exception exceptionToLog, Id recordId) {
        error(
            getFullMessage(
                exceptionToLog.getMessage(), exceptionToLog.getStackTraceString()
            ),
            recordId
        );
    }

    private String getFullMessage(String message, String stackTraceString) {
        if (apexClass != null) {
            message = String.format(
                MESSAGE_FORMAT, new List<String>{apexClass.getName(), message}
            );
        }
        return String.format(
            '{0}\nStack trace:\n{1}',
            new List<String>{message, stackTraceString}
        );
    }

    private String getFullMessage(String message) {
        return getFullMessage(
            message, getStackTraceString()
        );
    }

    private String getStackTraceString() {
        List<String> stack = (new DmlException()).getStackTraceString().split('\n');
        while (stack[0].startsWith('Class.Logger.') || stack[0].startsWith('Class.LoggerAdapter.')) {
            stack.remove(0);
        }
        return String.join(stack, '\n');
    }

    public void close() {
        loggerAdapter.close();
    }
}
