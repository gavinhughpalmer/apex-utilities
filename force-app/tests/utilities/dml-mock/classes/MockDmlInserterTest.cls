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

        MockDmlInserterTest testFactory = new MockDmlInserterTest();
        SObject testSObject = testFactory.getSObject();
        SObject objectToInsert = mockDmlInserter.insertSObject(testSObject);
        Integer dmlLimitAfter = Limits.getDMLStatements();

        System.assert(
            !String.isBlank(objectToInsert.Id),
            'The Object should have an Id, ' + objectToInsert.Id
        );

        System.assertEquals(
            dmlLimitBefore,
            dmlLimitAfter,
            'The dml limits should not have changed'
        );
    }

    @IsTest
    private static void insertMultipleSObjectTest() {
        Integer dmlLimitBefore = Limits.getDMLStatements();
        MockDmlInserter mockDmlInserter = new MockDmlInserter();

        MockDmlInserterTest testFactory = new MockDmlInserterTest();
        List<SObject> testSObjects = testFactory.getMultipleSObjects(BULK_AMOUNT);
        List<SObject> objectsToInsert = mockDmlInserter.insertMultipleSObject(testSObjects);

        Integer dmlLimitAfter = Limits.getDMLStatements();

        for (SObject objectToInsert : objectsToInsert) {
            System.assert(
                !String.isBlank(objectToInsert.Id),
                'The Object should have an Id, ' + objectToInsert.Id
            );
        }

        System.assertEquals(
            dmlLimitBefore,
            dmlLimitAfter,
            'The dml limits should not have changed'
        );
    }

    @IsTest
    private static void allowDuplicatesOnSaveTest() {
        MockDmlInserter mockDmlInserter = new MockDmlInserter();
        Boolean allowDups = mockDmlInserter.allowDuplicatesOnSave(true);

        System.assert(allowDups, 'The allow dups variable should be set to true');
    }
}
