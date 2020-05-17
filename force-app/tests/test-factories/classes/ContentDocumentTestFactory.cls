/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
*
* 2018-10-23 : Gavin Palmer - Original
**/
@IsTest
public without sharing class ContentDocumentTestFactory extends ContentVersionTestFactory {

    public override SObject insertSObject() {
        ContentVersion version = (ContentVersion) super.insertSObject(); 
        // The content document will be created by the version insert process
        return [SELECT Id FROM ContentDocument WHERE LatestPublishedVersionId = :version.Id];
    }

    public override List<SObject> insertMultipleSObjects(Integer numberToInsert) {
        List<ContentVersion> versions = (List<ContentVersion>) super.insertMultipleSObjects(numberToInsert); 
        // The content document will be created by the version insert process
        return [SELECT Id FROM ContentDocument WHERE LatestPublishedVersionId IN :versions];
    }

    // Overridden as the standard insert handles dependancies
    public override SObject insertWithDependancies() {
        return insertSObject();
    }

    // Overridden as the standard insert handles dependancies
    public override List<SObject> insertMultipleWithDependancies(Integer numberToInsert) {
        return insertMultipleSObjects(numberToInsert);
    }
}
