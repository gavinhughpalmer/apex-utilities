/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
*
* 2019-02-02 : Gavin Palmer - Original
**/
@IsTest
public without sharing class LeadTestFactory extends AbstractSObjectTestFactory {

    public String lastName = 'Test';
    public String company = 'Test Company';
    public String status = 'New';

    public override SObject getSObject() {
        return new Lead(
            LastName = lastName,
            Company = company,
            Status = status
        );
    }
}
