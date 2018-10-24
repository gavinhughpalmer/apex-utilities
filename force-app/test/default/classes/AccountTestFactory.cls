/*
 This is used as an example of how to use the AbstractSObjectTestFactory, this can be used for any sObject in the system and will allow you to define the required fields for that object. uniqueValue can be used to assign any fields that have been marked unique, this will increment when the multiple method calls are used
*/
@isTest
public class AccountTestFactory extends AbstractSObjectTestFactory {

    public String name;
    public String billingStreet = '1 Fake Street';

    public override SObject getSObject() {
        return new Account(
            Name = name == null ? uniqueValue : name,
            BillingStreet = billingStreet
        );
    }
}