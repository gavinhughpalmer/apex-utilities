# Apex Utilities

## Desctiption
This repository contains a number of reusable components that can be used accross Apex development projects. You can pick and chose which components will be useful to your project

## Components
* **Assert**:
    * Description: The assert class is a utility to help in test classes, any additional assert functions can be added in here as static methods, this class is annotated with @isTest as it is a mostly untestable due to the assert statement inside it.
    * Usage: `Assert.pageMessage('The page message you wish to assert')`
* **Logger**:
    * Description: This class is used to control logging in the system, it provides an adapter so logging can be easily swapped out whenever needed, within the class it has provided a wrapper for the debug logs to allow logs written to this and a logger for the page messages.
    * Usage:
```java
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
    * Usage:
```java
Logger log = new Logger(BulkLogObjectAdapter.getInstance('Integration'));
log.warn('A warning message');
BulkLogObjectAdapter.writeLogs();
```
* **DateUtils**:
    * Description: This class is used as a replacement for the standard `Date.today()` and `Datetime.now()` methods, which will allow for the current date / datetime to be set dynamically in test classes, which can help for any time / date dependant actions.
    * Usage: See `DateUtilsTest` class
* **StringBuilder**:
    * Description: This class is intended to be similar to the java StringBuilder, it allows strings to be dynamically constructed but only assigned at the point that it needs to be.
    * Usage:
```java
StringBuilder text = new StringBuilder();
for (Integer i = 0; i < 10; i++) {
    text.append(String.valueOf(i));
}
System.debug(text.toString());
```
* **CsvBuilder**:
    * Description: This class is used to build a Csv dynamically, it is a sub-class to the StringBuilder
    * Usage: See `CsvBuilderTest` class
* **SchemaFacade**:
    * Description: This is a facade for the schema describe functions to make accessing the schema much easier within apex. It is implemented as a sigleton so that it can perform some form of cacheing, this probably isn't nessisary as I think salesforce implements cacheing on the schema methods anyway, but this is just to be safe
    * Usage:
```java
SchemaFacade schema = SchemaFacade.getInstance();
DescribeSObjectResult accountDescribe = schema.getDescribe('Account');
System.debug(accountDescribe.getName());

DescribeFieldResult fieldDescribe = schema.getFieldDescribe('Account', 'Name');
System.debug(fieldDescribe.getName());
```
* **SObjectWrapper**:
    * Description: This is a wrapper around the SObject class that its primary function is to be able to retrieve parent fields dynamically
    * Usage:
```java
Account myContact = [SELECT Account.Name FROM Contact LIMIT 1];
SObjectWrapper wrappedContact = new SObjectWrapper(myContact);
String accountName = (String) wrappedContact.get('Account.Name');
```
* **DisplayTypeParser**:
    * Description: This is a class that can be used to parse field values, if the target field is known this can be used to ensure the field value is correct
    * Usage:
```java
DescribeFieldResult field = Account.NumberOfEmployees.getDescribe(); // this would be more dynamic
Parsable parser = new DisplayTypeParser(field.getType());

Account newAccount = new Account();
newAccount.put(field.getName(), parser.parse('100'));
```