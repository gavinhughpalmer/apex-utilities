# Apex Utilities

## Desctiption

This repository contains a number of reusable components that can be used accross Apex development projects. You can pick and chose which components will be useful to your project

## Installation

The simplest installation option would be to install the unlocked package using one of the following links

1. [Production](https://login.salesforce.com/packaging/installPackage.apexp?p0=04t1n000001pHW8AAM)
2. [Sandbox](https://test.salesforce.com/packaging/installPackage.apexp?p0=04t1n000001pHW8AAM)

Alternatively this can be done in the command line using `sfdx force:package:install --package 04t1n000001pHW8AAM`

## Documentation

<!-- Need to look at the docs, they merge all lines into 1 which makes it difficult in examples -->
The apex-utilities package consists of a number of frameworks and utilities packages, the details for each class can be viewed in the [docs](/docs/index.md). Below we will cover a high level usage for each framework. For any of the other general classes refer to the [docs](/docs/index.md).

### Logging
The logging framework is designed to give a simple (and switchable) logging interface within apex code. The logs are intitially written into platform events to ensure they can be written in triggers even when an exception is thrown. The framework includes features to allow profiling/monitoring of apex code and the higher org limits.
```java
Logger log = LoggerFactory.createLogger(MyClass.class);
log.warn('A warning message');
log.close()
```
There are a few classes that wrap the standard queueable and schedulable interfaces to add the logging framework which allows developers not to remember to have to call the `log.close()` which commits the logs into the database.
### Test Factory Framework
The test factory framework allows for a single point of creation for all test classes data creation. The framework requires an implementation for each SObject that should be created, it allows dependancies to be added into the class so that if only the child is needed in a test the caller does not need the knowledge of all the parent SObjects that might be required to be created. Fields on SObjects should be defined as public instance variables on the factory classs, where the defaults should be defined to a point that would allow an instance of that SObject to be created without error.

Part of the factory framework also allows for injection of an [Insertable](/force-app/tests/test-factories/classes/Insertable.cls) which allows for the method of DML used to be mocked (i.e. with the [MockDmlInserter](/force-app/tests/utilities/dml-mock/classes/MockDmlInserter.cls)).

See the [example-app](/example-app) for standard SObject examples for the test data factory framework. These are not included in the base package to allow users of the package to implement their own without risk of being overridden after any package upgrades.

### Trigger Framework
This trigger framework focuses around single trigger per object per action, each trigger will be in the format `{ObjectName}{Action}` (eg `AccountBeforeInsert`). Each trigger will call directly into the `TriggerDispatcher.run()` method passing in a list of actions you wish to perform. Each action you wish to implement is written as a seperate class to allow seperation of concerns. The dispatcher class will allow for tracking of the trigger stack, it will write logs using the logging framework (as mentioned above).

```java
trigger OpportunityBeforeInsert on Opportunity (before insert) {
    TriggerDispatcher.run(
        new List<Triggerable>{
            new MyFirstAction(),
            new MySecondAction()
        }
    );
}
```

## Contributing
Firstly, all contributions are welcomed for any improvements or issues that are noticed in the code. You are also welcome to create issues which I will then monitor and add to the repo as appropriate.

To contribute to the apex-utilities package you will first need to setup a scratch, the CI and scratch or creation process app utilises the [sfdx-executor](https://github.com/gavinhughpalmer/sfdx-executor) SFDX plugin, which allows cross platform reusable scripts for SFDX commands, follow the link for installation instructions.

To use the command to create a scratch org, you will first need to ensure a DevHub is authorized in the directory you are working in (and set as the defualt), then you can execute the command:

```sh-session
sfdx executor:run --planfile sfdx-executor-plan.json --command createScratch --arguments my-scratch,5
```

Where the last 2 arguments are the name you wish to assign to the scratch and the duration the scratch org should live.

Any changes that are placed into a pull request are assumed to have been fully tested, also as PMD and prettier are used in the the repo. These should be ran and passing locally before the PR is created (prettier is less important as it will run on a push to master but it will just make it that much easier to review the PR if it has already been formatted). The repo also used ApexDocs to generate documentation, this is run on a push to master so you don't need to execute yourself, but please ensure any new functionality is documented in the class/method headers.

When creating changes for the apex-utilities package, efforts should be made to not depend on features being enabled in an environment, or that would require developers to change the classes within the package. That is extension should be favored over modification.
