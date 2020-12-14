/**
 * @author Khin Hou (khinfoung.hou@gmail.com)
 * @version 1.0
 * @description Test class for the IdGeneratorMock
 *
 * 2020-11-05 : Khin Hou - Original
 **/
@IsTest(isParallel=true)
public with sharing class IdGeneratorMockTest {

    @IsTest
    private static void getPrefixOfIdOfStandardObject() {
        IdGeneratorMock idMock = new IdGeneratorMock(Account.getSobjectType());
        String prefix = idMock.getPrefixOfId(Account.getSobjectType());
        System.assertEquals(
            String.isBlank(prefix),
            false,
            'Prefix should not be blank'
        );
    }

    @IsTest
    private static void getPrefixOfIdOfCustomObject() {
        Contract_Line_Item__c testCLI = new Contract_Line_Item__c();
        IdGeneratorMock idMock = new IdGeneratorMock(testCLI.getSObjectType());
        String prefix = idMock.getPrefixOfId(testCLI.getSObjectType());
        System.assertEquals(
            String.isBlank(prefix),
            false,
            'Prefix should not be blank'
        );
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
        System.assertNotEquals(
            firstId,
            secondId,
            'The two ids should not be the same'
        );
    }
}
