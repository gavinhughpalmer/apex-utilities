---
layout: default
---
# LoggerAdapter class

The logger adapter exposes the log method and the specific log levels to be implemented by whatever class implements it


**Author:** Gavin Palmer

**Date:** 2018-06-27
---
## Methods
### `close()` → `void`
### `debugLevel()` → `Object`
### `errorLevel()` → `Object`
### `infoLevel()` → `Object`
### `log(Object logLevel, String message)` → `void`
### `log(Object logLevel, String message, Id recordId)` → `void`
### `setType(String type)` → `void`
### `warningLevel()` → `Object`
---
## Inner Classes

### LoggerAdapter.DebugLogAdapter class

 Implementation of LoggerAdapter that directs all logging through the built-in Apex method <code>System.debug()</code>

---
#### Methods
##### `debugLevel()` → `Object`
##### `errorLevel()` → `Object`
##### `infoLevel()` → `Object`
##### `log(Object logLevel, String message)` → `void`
##### `warningLevel()` → `Object`
---
