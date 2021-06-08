/**
 * @author Gavin Palmer
 * @date 2018-10-23
 * @group Test Factory Framework
 * @description Insertable interface class
 *
 **/
public interface Insertable {
    SObject insertSObject(SObject sObjectToInsert);
    List<SObject> insertMultipleSObject(List<SObject> sObjectsToInsert);
    Boolean allowDuplicatesOnSave(Boolean areRulesOn);
}
