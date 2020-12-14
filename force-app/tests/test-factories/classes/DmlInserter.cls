/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description This class implements Insertable and allows test factories to be inserted with
 *              additional headers
 *
 * 2020-11-05 : Gavin Palmer - Original
 * 2020-11-17 : Khin Hou - Included the options to turn on/off duplication rules on inserts (allowDuplicatesOnSave methods)
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