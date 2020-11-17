/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description Insertable interface class
 *
 * 2020-11-05 : Gavin Palmer - Original
 * 2020-11-17 : Khin Hou - Included the options to turn on/off duplication rules on inserts (allowDuplicatesOnSave methods)
 **/
public interface Insertable {
    SObject insertSObject(SObject sObjectToInsert);
    List<SObject> insertMultipleSObject(List<SObject> sObjectsToInsert);
    Boolean allowDuplicatesOnSave(Boolean areRulesOn);
}