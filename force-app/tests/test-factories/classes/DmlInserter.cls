/**
 * @author Gavin Palmer
 * @date 2018-10-23
 * @group Test Factory Framework
 * @description This class will allow inserts to be executed with additional headers
 *
 **/
public with sharing class DmlInserter implements Insertable {
    @testVisible
    private Boolean allowDuplicatesOnSave = false;

    public Boolean allowDuplicatesOnSave(Boolean areRulesOn) {
        allowDuplicatesOnSave = areRulesOn;
        return allowDuplicatesOnSave;
    }
    public SObject insertSObject(SObject sObjectToInsert) {
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.allowSave = allowDuplicatesOnSave;
        dml.DuplicateRuleHeader.runAsCurrentUser = true;
        dml.optAllOrNone = true;
        Database.insert(sObjectToInsert, dml);
        return sObjectToInsert;
    }
    public List<SObject> insertMultipleSObject(List<SObject> sObjectsToInsert) {
        Database.DMLOptions dml = new Database.DMLOptions();
        dml.DuplicateRuleHeader.allowSave = allowDuplicatesOnSave;
        dml.DuplicateRuleHeader.runAsCurrentUser = true;
        dml.optAllOrNone = true;
        Database.insert(sObjectsToInsert, dml);
        return sObjectsToInsert;
    }
}