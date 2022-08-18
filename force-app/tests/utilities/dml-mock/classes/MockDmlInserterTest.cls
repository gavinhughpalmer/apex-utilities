/**
 * @author Khin Hou
 * @date 2020-12-10
 * @group DML Mock
 * @description Test class for the MockDmlInserter
 *
 **/
@IsTest
public with sharing class MockDmlInserterTest {
    private static final Integer BULK_AMOUNT = 200;

    @IsTest
    private static void insertSObjectTest() {
        Integer dmlLimitBefore = Limits.getDMLStatements();
        MockDmlInserter mockDmlInserter = new MockDmlInserter();

        SObjectTestFactory testFactory = new SObjectTestFactory();
        SObject testSObject = testFactory.getSObject();
        SObject objectToInsert = mockDmlInserter.insertSObject(testSObject);
        Integer dmlLimitAfter = Limits.getDMLStatements();

        Assert.isFalse(
            String.isBlank(objectToInsert.Id),
            'The Object should have an Id, ' + objectToInsert.Id
        );

        Assert.areEqual(
            dmlLimitBefore,
            dmlLimitAfter,
            'The dml limits should not have changed'
        );
    }

    @IsTest
    private static void insertMultipleSObjectTest() {
        Integer dmlLimitBefore = Limits.getDMLStatements();
        MockDmlInserter mockDmlInserter = new MockDmlInserter();

        SObjectTestFactory testFactory = new SObjectTestFactory();
        List<SObject> testSObjects = testFactory.getMultipleSObjects(BULK_AMOUNT);
        List<SObject> objectsToInsert = mockDmlInserter.insertMultipleSObject(testSObjects);

        Integer dmlLimitAfter = Limits.getDMLStatements();

        for (SObject objectToInsert : objectsToInsert) {
            Assert.isFalse(
                String.isBlank(objectToInsert.Id),
                'The Object should have an Id, ' + objectToInsert.Id
            );
        }

        Assert.areEqual(
            dmlLimitBefore,
            dmlLimitAfter,
            'The dml limits should not have changed'
        );
    }

    @IsTest
    private static void allowDuplicatesOnSaveTest() {
        MockDmlInserter mockDmlInserter = new MockDmlInserter();
        Boolean allowDups = mockDmlInserter.allowDuplicatesOnSave(true);

        Assert.isTrue(allowDups, 'The allow dups variable should be set to true');
    }
}
