/**
* @author Gavin Palmer
* @version 1.0
*
* @date 2018-10-23
**/
@IsTest
public without sharing class ContentDocumentLinkTestFactory extends AbstractSObjectTestFactory {

    public String visibility = 'AllUsers';
    public String shareType = 'I';
    public Id linkedEntityId;
    public Id contentDocumentId;

    public ContentDocumentLinkTestFactory() {
        addDependancy('LinkedEntityId', new AccountTestFactory());
        addDependancy('ContentDocumentId', new ContentDocumentTestFactory());
    }

    public override SObject getSObject() {
        return new ContentDocumentLink(
            Visibility = visibility,
            ShareType = shareType,
            LinkedEntityId = linkedEntityId,
            ContentDocumentId = contentDocumentId
        );
    }
}
