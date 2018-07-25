# Apex Utilities

## Desctiption
This repository contains a number of reusable components that can be used accross Apex development projects. You can pick and chose which components will be useful to your project

## Components
* **Assert**:
    * Description: The assert class is a utility to help in test classes, any additional assert functions can be added in here as static methods, this class is annotated with @isTest as it is a mostly untestable due to the assert statement inside it.
    * Usage: `Assert.pageMessage('The page message you wish to assert')`
* **Logger**:
    * Description: This class is used to control logging in the system, it provides an adapter so logging can be easily swapped out whenever needed, within the class it has provided a wrapper for the debug logs to allow logs written to this and a logger for the page messages.
    * Usage: ```
Logger log = new Logger(new DebugLogAdapter());
log.warn('A warning is here');
try {
    insert new Account();
} catch (DmlException exceptionToHandle) {
    log.error(exceptionToHandle);
}
```
* **BulkLogObjectAdapter**:
    * Description: This class allows logging against an sobject defined in the system. This is defined as a singleton so that logs can be inserted once during a transaction
    * Usage: ```
Logger log = new Logger(BulkLogObjectAdapter.getInstance('Integration'));
log.warn('A warning message');
BulkLogObjectAdapter.writeLogs();
```
* **DateUtils**:
    * Description: This class is used as a replacement for the standard `Date.today()` and `Datetime.now()` methods, which will allow for the current date / datetime to be set dynamically in test classes, which can help for any time / date dependant actions.
    * Usage: See `DateUtilsTest` class
* **StringBuilder**:
    * Description: This class is intended to be similar to the java StringBuilder, it allows strings to be dynamically constructed but only assigned at the point that it needs to be.
    * Usage: ```
StringBuilder text = new StringBuilder();
for (Integer i = 0; i < 10; i++) {
    text.append(String.valueOf(i));
}
System.debug(text.toString());
```
* **CsvBuilder**:
    * Description: This class is used to build a Csv dynamically, it is a sub-class to the StringBuilder
    * Usage: See `CsvBuilderTest` class