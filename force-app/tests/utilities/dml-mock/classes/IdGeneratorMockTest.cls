/**
 * @author Khin Hou
 * @date 2020-11-05
 * @group DML Mock
 * @description Test class for the IdGeneratorMock
 *
 **/
@IsTest
public with sharing class IdGeneratorMockTest {
    @IsTest
    private static void getPrefixOfIdOfStandardObject() {
        IdGeneratorMock idMock = new IdGeneratorMock(Account.getSobjectType());
        String prefix = idMock.getPrefixOfId(Account.getSobjectType());
        System.assertEquals(String.isBlank(prefix), false, 'Prefix should not be blank');
    }

    @IsTest
    private static void getPrefixOfIdOfCustomObject() {
        Log__c testCustomObject = new Log__c();
        IdGeneratorMock idMock = new IdGeneratorMock(testCustomObject.getSObjectType());
        String prefix = idMock.getPrefixOfId(testCustomObject.getSObjectType());
        System.assertEquals(String.isBlank(prefix), false, 'Prefix should not be blank');
    }

    @IsTest
    private static void getNextAvailableIdForSingleTime() {
        IdGeneratorMock idMock = new IdGeneratorMock(Account.getSobjectType());
        System.assertEquals(
            String.isBlank(idMock.getNextAvailableId()),
            false,
            'Generated Id should not be blank'
        );
    }

    @IsTest
    private static void getNextAvailableIdForMultipleTimes() {
        IdGeneratorMock idMock = new IdGeneratorMock(Account.getSobjectType());
        String firstId = idMock.getNextAvailableId();
        String secondId = idMock.getNextAvailableId();
        System.assertNotEquals(firstId, secondId, 'The two ids should not be the same');
    }
}
