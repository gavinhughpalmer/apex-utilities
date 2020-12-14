/**
 * @author Gavin Palmer
 * @date 2018-11-05
 * @group Test Factory Framework
 * @description This class will allow inserts to be executed with additional headers
 *
 **/
@IsTest
public with sharing class DmlInserterTest {
    private static final Integer BULK_AMOUNT = (Integer) Env.get('Test_Amount');
    @IsTest
    private static void insertSObjectTest() {
        Integer dmlLimitBefore = Limits.getDMLStatements();
        DmlInserter dmlInserter = new DmlInserter();

        SObjectTestFactory testFactory = new SObjectTestFactory();
        Account testAccount = (Account) testFactory.getSObject();
        SObject objectToInsert = dmlInserter.insertSObject(testAccount);
        Integer dmlLimitAfter = Limits.getDMLStatements();

        System.assert(
            !String.isBlank(objectToInsert.Id),
            'The Object should have an Id, ' + objectToInsert.Id
        );

        System.assertNotEquals(
            dmlLimitBefore,
            dmlLimitAfter,
            'The dml limits should have changed, dmlLimitBefore: ' +
            dmlLimitBefore +
            ' :: dmlLimitAfter: ' +
            dmlLimitAfter
        );
    }

    @IsTest
    private static void insertMultipleSObjectTest() {
        Integer dmlLimitBefore = Limits.getDMLStatements();
        DmlInserter dmlInserter = new DmlInserter();

        SObjectTestFactory testFactory = new SObjectTestFactory();
        List<Account> testSObjects = testFactory.getMultipleSObjects(BULK_AMOUNT);
        List<SObject> objectsToInsert = dmlInserter.insertMultipleSObject(testSObjects);

        Integer dmlLimitAfter = Limits.getDMLStatements();

        for (SObject objectToInsert : objectsToInsert) {
            System.assert(
                !String.isBlank(objectToInsert.Id),
                'The Object should have an Id, ' + objectToInsert.Id
            );
        }

        System.assertNotEquals(
            dmlLimitBefore,
            dmlLimitAfter,
            'The dml limits should have changed, dmlLimitBefore: ' +
            dmlLimitBefore +
            ' :: dmlLimitAfter: ' +
            dmlLimitAfter
        );
    }

    @IsTest
    private static void allowDuplicatesOnSaveTest() {
        DmlInserter dmlInserter = new DmlInserter();

        System.assert(
            !dmlInserter.allowDuplicatesOnSave,
            'The allow dups variable should be set to false at initialisation'
        );

        Boolean allowDups = dmlInserter.allowDuplicatesOnSave(true);

        System.assert(allowDups, 'The allow dups variable should be set to true');
    }
}
