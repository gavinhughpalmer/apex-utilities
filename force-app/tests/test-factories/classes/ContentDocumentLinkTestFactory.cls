/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
*
* 2018-10-23 : Gavin Palmer - Original
**/
@IsTest
public without sharing class ContentDocumentLinkTestFactory extends AbstractSObjectTestFactory {

    public String visibility = 'AllUsers';
    public String shareType = 'I';
    public Id linkedEntityId;
    public Id contentDocumentId;

    public override SObject getSObject() {
        return new ContentDocumentLink(
            Visibility = visibility,  
            ShareType = shareType,
            LinkedEntityId = linkedEntityId, 
            ContentDocumentId = contentDocumentId
        );
    }

    public override void initialiseDependancies() {
        dependancies.add(
            new FactoryDependancy(
                new AccountTestFactory(),
                'LinkedEntityId'
            )
        );
        dependancies.add(
            new FactoryDependancy(
                new ContentDocumentTestFactory(),
                'ContentDocumentId'
            )
        );
    }
}
