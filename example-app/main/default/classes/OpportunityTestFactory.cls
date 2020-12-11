/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
*
* @date 2019-03-06
**/
@IsTest
public without sharing class OpportunityTestFactory extends AbstractSObjectTestFactory {

    public static final String DEFAULT_STAGE = 'New';

    public Id accountId;
    public String name = 'Test Opp';
    public Date closeDate = Date.today();
    public String stage = DEFAULT_STAGE;
    public Id ownerId = UserInfo.getUserId();
    public String salesTargetRefrence;

    public OpportunityTestFactory() {
        addDependancy('AccountId', new AccountTestFactory());
    }

    public override SObject getSObject() {
        return new Opportunity(
            AccountId = accountId,
            Name = name,
            CloseDate = closeDate,
            StageName = stage,
            OwnerId = ownerId
        );
    }
}
