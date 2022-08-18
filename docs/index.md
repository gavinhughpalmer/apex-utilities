---
layout: default
---
# Classes
## Test Factory Framework

### [AbstractSObjectTestFactory](/docs/Test-Factory-Framework/AbstractSObjectTestFactory.md)


This factory class will be used as a base for any SObject creation in test classes, this pattern will define attributes that can be set in the test classes. This allows any required fields / validations to be defined in what is returned in the getSObject method allowing developers to easily enforce required fields accross all test classes if they are ever added in the UI. The method for inserting the records can be injected if specific ties around the insert need to be added for a specific use case, eg in the abstract SObject test factory test class



### [DmlInserter](/docs/Test-Factory-Framework/DmlInserter.md)


This class will allow inserts to be executed with additional headers



### [DmlInserterTest](/docs/Test-Factory-Framework/DmlInserterTest.md)


This class will allow inserts to be executed with additional headers



### [Insertable](/docs/Test-Factory-Framework/Insertable.md)


Insertable interface class



### [MockAccountTestFactory](/docs/Test-Factory-Framework/MockAccountTestFactory.md)


Test class for the AbstractSObjectTestFactory, this was to ensure the dependancies were inserting correctly



### [SObjectTestFactory](/docs/Test-Factory-Framework/SObjectTestFactory.md)


This factory class is to be utilised within the tests of this package, the actual object it is creating is not important it is just when some kind of DML is needed in the test, as you can see below we have chosen to use the log object as this has no dependancies and has a low risk of failure to insert when being created.


## Logging

### [ApexProfiler](/docs/Logging/ApexProfiler.md)


This class is used to log out the profiling information of the current running transaction. This will log out as part of the trigger framework after any transaction if any of the limits are approaching 75%



### [EventBufferLogAdapter](/docs/Logging/EventBufferLogAdapter.md)


The bulk log object adapter can be used to insert logs as a custom object into the database, as a singleton the write logs can be called at the end of a trigger to insert the full logs into the system only once per object The class has been adapted to use events so that it can still insert log objects when a transaction is rolled back, allowing it to be more robust in trigger contexts Usage: Logger log = LoggerFactory.createLogger(MyClass.class); log.warn('A warning message'); log.close();



### [LogMessage](/docs/Logging/LogMessage.md)


This class holds the logic for generating log messages, meaning any specific details that should be added to each log can be appended in here



### [LogWriter](/docs/Logging/LogWriter.md)


The LogWriter class converts log events into log sobjects so that they are perminantely committed into the database



### [LoggedQueueable](/docs/Logging/LoggedQueueable.md)


This class wraps the queueable interface with the logging framework so that developers do not have to worry about writing the logs after the Logger methods are called.



### [LoggedSchedulable](/docs/Logging/LoggedSchedulable.md)


This wraps the standard Schedulable interfaece and allows the logs to be written without developers needing to write the logs specifically



### [Logger](/docs/Logging/Logger.md)


The logger provides an extendable logging interface, the actual logging option can be easily switched by the use of the LoggerAdapter inner class. This class was adapted from https://github.com/blueprinthealth/sirono-common/blob/master/src/classes/Logger.cls Usage: Logger log = new Logger(new DebugLogAdapter()); log.warn('A warning is here'); try { insert new Account(); } catch (DmlException exceptionToHandle) { log.error(exceptionToHandle); }



### [LoggerAdapter](/docs/Logging/LoggerAdapter.md)


The logger adapter exposes the log method and the specific log levels to be implemented by whatever class implements it



### [LoggerFactory](/docs/Logging/LoggerFactory.md)


This factory class is used to abstract away the creation of the Logger and which adapter it is using, which will allow for the adapters to be swapped out easier



### [OrgLimitsProfiler](/docs/Logging/OrgLimitsProfiler.md)


This class runs the profiling for org limits



### [OrgLimitsProfilingReportRunner](/docs/Logging/OrgLimitsProfilingReportRunner.md)


This class will run the full profiling (ie including the org limits), and write into the logs. To run you can execute: OrgLimitsProfilingReportRunner report = new OrgLimitsProfilingReportRunner(); report.scheduleDaily();



### [Profiler](/docs/Logging/Profiler.md)


This is a generic profiling class, which allows implementations to report on certain limits within the environment.



### [QueueableScheduler](/docs/Logging/QueueableScheduler.md)


This class will schedule a queuebale class to run by injecting the queuebale into the class Usage: QueueableScheduler scheduler = new QueueableScheduler(new MyQueueable()); scheduler.scheduleDaily();


## Test Utilities


### [MockHttpResponse](/docs/Test-Utilities/MockHttpResponse.md)


This class can be used to build custom HTTP responses to be used in test classes Usage: Test.setMock( HttpCalloutMock.class, MockHttpResponse.builder().statusCode(200).body('{"field":"value"}').cookie('aCookie') );


## Configuration Management

### [ConfigurationManager](/docs/Configuration-Management/ConfigurationManager.md)


This uses a custom setting underneath that will allow callers to programatically disable triggers, workflows, process builders and validation rules through code. This requires all new configurations to include a catch as the first line so that they can all be turned off. If you are using some form of a trigger framework the catch can be added in there so that this doesn't need to be remembered by all developers when adding new triggers. The class is mostly useful for turning off automation while setting up test data in test classes so that you can fully test your classes



### [DeletionValidator](/docs/Configuration-Management/DeletionValidator.md)


This class will be used to validate the deletion of objects which are not covered by profiles (for example ContentVersions). A delete trigger should be implemented on the object calling into this triggerable


## String Utilities

### [CsvBuilder](/docs/String-Utilities/CsvBuilder.md)


The CsvBuilder is used to build csv files from some input



### [QueryBuilder](/docs/String-Utilities/QueryBuilder.md)


This class can be used to build up dynamic soql queries



### [StringBuilder](/docs/String-Utilities/StringBuilder.md)


This class is intended to be similar to the java StringBuilder, it allows strings to be dynamically constructed but only assigned at the point, similar to Javas StringBuffer


## Miscellaneous

### [DatabaseUtils](/docs/Miscellaneous/DatabaseUtils.md)


This class is a utility for the Database class



### [DateUtils](/docs/Miscellaneous/DateUtils.md)


This class will be used for reusable date functions



### [Stack](/docs/Miscellaneous/Stack.md)


A simple stack implementation to allow FILO on data structures


## Parsers

### [DisplayTypeParser](/docs/Parsers/DisplayTypeParser.md)


This parser will take a string value and convert it to the display type that is passed into the constructor



### [Parsable](/docs/Parsers/Parsable.md)


Parsable interface will be implemented by classes that are intended to parse a string to an object value


## DML Mock

### [IdGeneratorMock](/docs/DML-Mock/IdGeneratorMock.md)


Class to generated Ids for test mocking



### [IdGeneratorMockTest](/docs/DML-Mock/IdGeneratorMockTest.md)


Test class for the IdGeneratorMock



### [MockDmlInserter](/docs/DML-Mock/MockDmlInserter.md)


This class will mock the inserts into the database by generating an id and returning the original record



### [MockDmlInserterTest](/docs/DML-Mock/MockDmlInserterTest.md)


Test class for the MockDmlInserter


## Schema

### [InvalidFieldException](/docs/Schema/InvalidFieldException.md)


This is an exception class that details an invalid filed when accessing the schema



### [PicklistValueSet](/docs/Schema/PicklistValueSet.md)


This class will hold the picklist values of an object so that the values can be more easily retrieved



### [Relationship](/docs/Schema/Relationship.md)


This is a simple class to swap between the id and relationship refrence field when dynamically refrencing relationship fields Usage: // Can be used if you have the relationship field Relationship accountLookup = Relationship.fromRefrenceField('Account'); System.debug(accountLookup.idFieldName); // AccountId // Or if you have the id field accountLookup = Relationship.fromIdField('AccountId'); System.debug(accountLookup.referenceFieldName); // Account // Similarly for custom objects accountLookup = Relationship.fromRefrenceField('Account__r'); System.debug(accountLookup.idFieldName); // Account__c accountLookup = Relationship.fromIdField('Account__c'); System.debug(accountLookup.referenceFieldName); // Account__r



### [SObjectRecordTypes](/docs/Schema/SObjectRecordTypes.md)


Utility class to help make interacting with an objects record types slightly easier eg cal call SObjectRecordTypes opportunityRecordTypes = new SObjectRecordTypes('Opportunity'); Id defaultOpportunityRecordTypeId = opportunityRecordTypes.getDefaultId();



### [SObjectWrapper](/docs/Schema/SObjectWrapper.md)


This is a wrapper around the SObject class that its primary function is to be able to retrieve parent fields dynamically Usage: Account myContact = [SELECT Account.Name FROM Contact LIMIT 1]; SObjectWrapper wrappedContact = new SObjectWrapper(myContact); String accountName = (String) wrappedContact.get('Account.Name');



### [SchemaFacade](/docs/Schema/SchemaFacade.md)


This is a facade for the schema describe functions to make accessing the schema much easier within apex. It is implemented as a sigleton so that it can perform some form of cacheing, this probably isn't nessisary as I think salesforce implements cacheing on the schema methods anyway, but this is just to be safe SchemaFacade schema = SchemaFacade.getInstance(); DescribeSObjectResult accountDescribe = schema.getDescribe('Account'); System.debug(accountDescribe.getName()); DescribeFieldResult fieldDescribe = schema.getFieldDescribe('Account', 'Name'); System.debug(fieldDescribe.getName());



### [SecureSObjectWrapper](/docs/Schema/SecureSObjectWrapper.md)


This class is a secure wrapper for the sobject that obeys field level security for the user accessing it. This wraps [SObjectWrapper](/docs/Schema/SObjectWrapper.md) so the recursive retrieves will be enabled



### [StateCountryCodeMapper](/docs/Schema/StateCountryCodeMapper.md)


This class is used to get around a salesforce bug where the state/country field is not updated in a trigger, rather the state code is. Other code in the org has been written to rely on the state/country field rather than the code


## Trigger Framework

### [SObjectTriggerWrapper](/docs/Trigger-Framework/SObjectTriggerWrapper.md)


This class is used by the trigger framework to give a few utility methods to the SObjects



### [TriggerDispatcher](/docs/Trigger-Framework/TriggerDispatcher.md)


This trigger dispatcher will be called from each trigger with a list of triggerable actions to perform. As the single point of entry for all triggers this class will manage the disabling and enabling of triggers, as well as tracking the stack of triggers



### [TriggerHandler](/docs/Trigger-Framework/TriggerHandler.md)


This class is a grouping of Triggerable actions so that they can be executed as one



### [Triggerable](/docs/Trigger-Framework/Triggerable.md)


This interface will be implemented by any action that is used in a trigger, this allows each trigger to loop over the set of records once to complete all the actions in the system. intention is that any initial setup actions can be performed in the constructor (ie set up some required data), then the register will determine if the new record should have any actions performed and add to a private list, then finally the performAction will run any dml / soql, essentially the bulk of the logic


