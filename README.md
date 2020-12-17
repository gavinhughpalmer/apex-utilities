# Apex Utilities

## Desctiption

This repository contains a number of reusable components that can be used accross Apex development projects. You can pick and chose which components will be useful to your project

## Installation

The simplest installation option would be to install the unlocked package using one of the following links

1. [Production](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t1n000002Wqv4AAC)
2. [Sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t1n000002Wqv4AAC)

Alternatively this can be done in the command line using `sfdx force:package:install --package 04t1n000002Wqv4AAC`

## Documentation
<!-- copy these details down to the class headers, and include method and properties headers -->

For documentation please see [docs](/docs/index.md)
<!-- perhaps some high level info on each component included here... -->

- **Assert**:
  - Description: The assert class is a utility to help in test classes, any additional assert functions can be added in here as static methods, this class is annotated with @isTest as it is a mostly untestable due to the assert statement inside it.
  - Usage: `Assert.pageMessage('The page message you wish to assert')`
- **Logger**:
  - Description: This class is used to control logging in the system, it provides an adapter so logging can be easily swapped out whenever needed, within the class it has provided a wrapper for the debug logs to allow logs written to this and a logger for the page messages. There is a factory class that has been implemented to allow for easier swapping of the adapter being used, below shows the usage. The default class is the BulkLogObjectAdapter, which writes into a log object (via platform events).
  - Usage:

```java
Logger log = LoggerFactory.createLogger(MyClass.class);
log.warn('A warning message');
log.close()
```
- **ApexProfiler**:
  - Description: This class is used by the logging framework to log out the limits in apex when limits are approched
  - Usage: See `BulkLogObjectAdapter` for details
- **LoggedSchedulable**:
  - Description: This is a wrapper arround the standard `Schedulable` class which utilises the logging framework to remove the need for users to remember to call the write logs at the end of the class
  - Usage: Works in a similar way to how `Schedulable` works
- **LoggedQueueable**:
  - Description:This is a wrapper arround the standard `Queueable` class which utilises the logging framework to remove the need for users to remember to call the write logs at the end of the class
  - Usage: Works in a similar way to how `Queueable` works
- **QueueableScheduler**:
  - Description: This class handles scheduling of queuable classes, this extends the `LoggedQueueable` and simply takes in a queuable and will then run it
  - Usage:

```java
QueueableScheduler scheduler = new QueueableScheduler(new MyQueueable());
scheduler.scheduleDaily();
```

- **DateUtils**:
  - Description: This class is used as a replacement for the standard `Date.today()` and `Datetime.now()` methods, which will allow for the current date / datetime to be set dynamically in test classes, which can help for any time / date dependant actions.
  - Usage: See `DateUtilsTest` class
- **StringBuilder**:
  - Description: This class is intended to be similar to the java StringBuilder, it allows strings to be dynamically constructed but only assigned at the point that it needs to be.
  - Usage:

```java
StringBuilder text = new StringBuilder();
for (Integer i = 0; i < 10; i++) {
    text.append(String.valueOf(i));
}
System.debug(text.toString());
```

- **CsvBuilder**:
  - Description: This class is used to build a Csv dynamically, it is a sub-class to the StringBuilder
  - Usage: See `CsvBuilderTest` class
- **SchemaFacade**:
  - Description: This is a facade for the schema describe functions to make accessing the schema much easier within apex. It is implemented as a sigleton so that it can perform some form of cacheing, this probably isn't nessisary as I think salesforce implements cacheing on the schema methods anyway, but this is just to be safe
  - Usage:

```java
SchemaFacade schema = SchemaFacade.getInstance();
DescribeSObjectResult accountDescribe = schema.getDescribe('Account');
System.debug(accountDescribe.getName());

DescribeFieldResult fieldDescribe = schema.getFieldDescribe('Account', 'Name');
System.debug(fieldDescribe.getName());
```

- **SObjectWrapper**:
  - Description: This is a wrapper around the SObject class that its primary function is to be able to retrieve parent fields dynamically
  - Usage:

```java
Account myContact = [SELECT Account.Name FROM Contact LIMIT 1];
SObjectWrapper wrappedContact = new SObjectWrapper(myContact);
String accountName = (String) wrappedContact.get('Account.Name');
```

- **SecureSObjectWrapper**:
  - Description: This is a wrapper around the SObject class that will enforce FLS when accessing and setting fields on the SObject record
  - Usage: See SecureSObjectWrapperTest for examples
- **DisplayTypeParser**:
  - Description: This is a class that can be used to parse field values, if the target field is known this can be used to ensure the field value is correct
  - Usage:

```java
DescribeFieldResult field = Account.NumberOfEmployees.getDescribe(); // this would be more dynamic
Parsable parser = new DisplayTypeParser(field.getType());

Account newAccount = new Account();
newAccount.put(field.getName(), parser.parse('100'));
```

- **AbstractSObjectTestFactory**:
  - Description: This is a factory class that can be used in test classes to generate sobject test data, a few example test factories have been included in the example-app which can be added to an org an extended for the specific use case eg. any additional custom field, validation criteria, unique field requirements or dependancies.
  - Usage: see `AccountTestFactory` for details
- **ConfigurationManager**:
  - Description: This uses a custom setting underneath that will allow callers to programatically disable triggers, workflows, process builders and validation rules through code. This requires all new configurations to include a catch as the first line so that they can all be turned off. If you are using some form of a trigger framework the catch can be added in there so that this doesn't need to be remembered by all developers when adding new triggers. The class is mostly useful for turning off automation while setting up test data in test classes so that you can fully test your classes
  - Usage:

```java
// inside a test setup method
ConfigurationManager.turnAutomationsOff();
insert new Account(Name = 'Test');
// set up some other test data
ConfigurationManager.turnAutomationsOn();
```

- **DeletionValidator**:

  - Description: This class can be used to block deletion on objects that arent covered by profile permissions (eg ContentVersion). This can then be set utilising the Configuration\_\_c custom setting
  - Usage: A before delete trigger should be created on any object that the deletion should be blocked on with this class as the initial triggerable action.

- **Trigger Framework**:
  - Description: This trigger framework focuses around single trigger per object per action, each trigger will be in the format `{ObjectName}{Action}` (eg `AccountBeforeInsert`). Each trigger will call directly into the `TriggerHandler.performAllActions()` method passing in a list of actions you wish to perform.
  - Usage:

```java
trigger OpportunityBeforeInsert on Opportunity (before insert) {
    TriggerHandler.performAllActions(
        new List<Triggerable>{
            new MyFirstAction(),
            new MySecondAction()
        },
        Trigger.new,
        Trigger.oldMap
    );
}
```
- **SObjectRecordTypes**
  - Description: This class can be used as an interface with interacting with an SObjects record types, this is essentially abstracting away some of the details that you can get to from the Schema classes.
  - Usage:

```java
SObjectRecordTypes opportunityRecordTypes = new SObjectRecordTypes('Opportunity');
Id bigSaleRecordTypeId = opportunityRecordTypes.getRecordTypeId('Big_Sale')
```

## Contributing
To contribute to the apex-utilities package you will first need to setup a scratch, the CI and scratch or creation process app utilises the [sfdx-executor](https://github.com/gavinhughpalmer/sfdx-executor) SFDX plugin, which allows cross platform reusable scripts for SFDX commands, follow the link for installation instructions.

To use the command to create a scratch org, you will first need to ensure a DevHub is authorized in the directory you are working in (and set as the defualt), then you can execute the command:

```sh-session
sfdx executor:run --planfile sfdx-executor-plan.json --command createScratch --arguments my-scratch,5
```

Where the last 2 arguments are the name you wish to assign to the scratch and the duration the scratch org should live.

Any changes that are placed into a pull request are assumed to have been fully tested, also as PMD and prettier are used in the the repo. These should be ran and passing locally before the PR is created (prettier is less important as it will run on a push to master but it will just make it that much easier to review the PR if it has already been formatted). The repo also used ApexDocs to generate documentation, this is run on a push to master so you don't need to execute yourself, but please ensure any new functionality is documented in the class/method headers.
