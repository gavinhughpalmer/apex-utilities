---
layout: default
---
# EventBufferLogAdapter class

The bulk log object adapter can be used to insert logs as a custom object into the database, as a singleton the write logs can be called at the end of a trigger to insert the full logs into the system only once per object The class has been adapted to use events so that it can still insert log objects when a transaction is rolled back, allowing it to be more robust in trigger contexts Usage: Logger log = LoggerFactory.createLogger(MyClass.class); log.warn('A warning message'); log.close();


**Author:** Gavin Palmer

**Date:** 2018-06-27
---
## Methods
### `close()` → `void`
### `debugLevel()` → `Object`
### `errorLevel()` → `Object`
### `getInstance()` → `EventBufferLogAdapter`
### `infoLevel()` → `Object`
### `log(Object logLevel, String message)` → `void`
### `log(Object logLevel, String message, Id recordId)` → `void`
### `warningLevel()` → `Object`
---
