/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
* @description This factory class is to be utilised within the tests of this package,
*   the actual object it is creating is not important it is just when some kind of DML
*   is needed in the test, as you can see below we have chosen to use the log object as
*   this has no dependancies and has a low risk of failure to insert when being created.
*
* 2018-10-23 : Gavin Palmer - Original
**/
public with sharing class SObjectTestFactory extends AbstractSObjectTestFactory {
    public SObject getSObject() {
        return Log__c(
            Level__c = 'Info',
            Messages__c = 'Not a real log',
            Record_Id__c = null,
            Type__c = 'Fake'
        );
    }
}
