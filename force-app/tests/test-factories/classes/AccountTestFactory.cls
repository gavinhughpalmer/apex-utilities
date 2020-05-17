/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
*
* 2018-10-23 : Gavin Palmer - Original
**/
@IsTest
public without sharing class AccountTestFactory extends AbstractSObjectTestFactory {

    public String name = 'My account name';

    public override SObject getSObject() {
        return new Account(
            Name = name
        );
    }
}
