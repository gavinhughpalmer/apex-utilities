/**
 * @author Khin Hou (khinfoung.hou@gmail.com)
 * @version 1.0
 * @description Test class for the MockDmlInserter
 *
 * 2020-12-10 : Khin Hou - Original
 **/
@IsTest
public with sharing class MockDmlInserterTest {
    private static final Integer BULK_AMOUNT = (Integer) Env.get('Test_Amount');

    @IsTest
    private static void insertSObjectTest() {
        Integer dmlLimitBefore = Limits.getDMLStatements();
        MockDmlInserter mockDmlInserter = new MockDmlInserter();

        AccountTestFactory accountFactory = new AccountTestFactory();
        Account testAccount = (Account) accountFactory.getSObject();
        SObject objectToInsert = mockDmlInserter.insertSObject(testAccount);
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

        AccountTestFactory accountFactory = new AccountTestFactory();
        List<Account> testSObjects = accountFactory.getMultipleSObjects(BULK_AMOUNT);
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
