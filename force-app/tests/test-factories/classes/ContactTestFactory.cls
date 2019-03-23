/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
*
* 2018-10-23 : Gavin Palmer - Original
**/
@IsTest
public without sharing class ContactTestFactory extends AbstractSObjectTestFactory {

    public String lastName = 'TestUser';
    public Id accountId;

    public override SObject getSObject() {
        return new Contact(
            AccountId = accountId,
            LastName = lastName
        );
    }

    public override void initialiseDependancies() {
        dependancies.add(
            new FactoryDependancy(
                new AccountTestFactory(),
                'AccountId'
            )
        );
    }
}
