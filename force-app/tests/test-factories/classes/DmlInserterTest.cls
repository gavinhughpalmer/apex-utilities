/**
 * @author Khin Hou (khinfoung.hou@gmail.com)
 * @version 1.0
 * @description Test class for the DmlInserterTest
 *
 * 2020-12-10 : Khin Hou - Original
 **/
@IsTest
public with sharing class DmlInserterTest {
    private static final Integer BULK_AMOUNT = (Integer) Env.get('Test_Amount');
    @IsTest
    private static void insertSObjectTest() {
        Integer dmlLimitBefore = Limits.getDMLStatements();
        DmlInserter dmlInserter = new DmlInserter();

        AccountTestFactory accountFactory = new AccountTestFactory();
        Account testAccount = (Account) accountFactory.getSObject();
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

        AccountTestFactory accountFactory = new AccountTestFactory();
        List<Account> testSObjects = accountFactory.getMultipleSObjects(BULK_AMOUNT);
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
