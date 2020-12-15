/**
 * @author Gavin Palmer
 * @date 2020-11-05
 * @group DML Mock
 * @description This class will mock the inserts into the database by generating an id and returning the original record
 *
 **/
public with sharing class MockDmlInserter implements Insertable {
    private final Map<Schema.SObjectType, IdGeneratorMock> idGenerators = new Map<Schema.SObjectType, IdGeneratorMock>();

    public SObject insertSObject(SObject sObjectToInsert) {
        Schema.SObjectType sObjectType = sObjectToInsert.getSObjectType();
        IdGeneratorMock idGenerator = getIdGenerator(sObjectType);
        sObjectToInsert.Id = idGenerator.getNextAvailableId();
        return sObjectToInsert;
    }
    public List<SObject> insertMultipleSObject(List<SObject> sObjectsToInsert) {
        Schema.SObjectType sObjectType = sObjectsToInsert[0].getSObjectType();
        IdGeneratorMock idGenerator = getIdGenerator(sObjectType);
        for (SObject sObjectToInsert : sObjectsToInsert) {
            sObjectToInsert.Id = idGenerator.getNextAvailableId();
        }
        return sObjectsToInsert;
    }
    public Boolean allowDuplicatesOnSave(Boolean areRulesOn) {
        return true;
    }

    private IdGeneratorMock getIdGenerator(Schema.SObjectType sObjectType) {
        if (!idGenerators.containsKey(sObjectType)) {
            idGenerators.put(sObjectType, new IdGeneratorMock(sObjectType));
        }
        return idGenerators.get(sObjectType);
    }
}
