---
layout: default
---
# Logger class

The logger provides an extendable logging interface, the actual logging option can be easily switched by the use of the LoggerAdapter inner class. This class was adapted from https://github.com/blueprinthealth/sirono-common/blob/master/src/classes/Logger.cls Usage: Logger log = new Logger(new DebugLogAdapter()); log.warn('A warning is here'); try { insert new Account(); } catch (DmlException exceptionToHandle) { log.error(exceptionToHandle); }


**Author:** Gavin Palmer

**Date:** 2018-06-27
---
## Constructors
### `Logger(Type apexClass, LoggerAdapter loggerAdapter)`
---
## Methods
### `close()` → `void`
### `debug(String messageToLog)` → `void`
### `debug(String messageToLog, Id recordId)` → `void`
### `error(String messageToLog)` → `void`
### `error(String messageToLog, Id recordId)` → `void`
### `error(Exception exceptionToLog)` → `void`
### `error(Exception exceptionToLog, Id recordId)` → `void`
### `info(String messageToLog)` → `void`
### `info(String messageToLog, Id recordId)` → `void`
### `setType(String type)` → `void`
### `warn(String messageToLog)` → `void`
### `warn(String messageToLog, Id recordId)` → `void`
---
