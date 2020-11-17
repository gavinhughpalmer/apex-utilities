/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description Test class for the SObjectRecordTypes class
 *
 * 2019-09-24 : Gavin Palmer - Original
 * 2020-09-22 : Khin Hou - adding new test method for getRecordTypeDeveloperName()
 **/
@IsTest
private class SObjectRecordTypesTest {
    @IsTest
    private static void constructorInvalidSObjectTest() {
        final String invalidObjectName = 'This is not an object';
        try {
            new SObjectRecordTypes(invalidObjectName);
            System.assert(
                false,
                'An exception should have been thrown when the object is not valid'
            );
        } catch (Exception exceptionThrown) {
            final String errorMessage = exceptionThrown.getMessage();
            System.assert(
                errorMessage.containsIgnoreCase(invalidObjectName),
                'The error should have contained ' +
                invalidObjectName +
                ' actual error message ' +
                errorMessage
            );
        }
    }

    @IsTest
    private static void getDefaultIdTest() {
        SObjectRecordTypes opportunityRecordTypes = new SObjectRecordTypes('Opportunity');
        System.assertNotEquals(
            null,
            opportunityRecordTypes.getDefaultId(),
            'The opportunity should have a default record type id'
        );
    }

    @IsTest
    private static void getRecordTypeIdTest() {
        SObjectRecordTypes opportunityRecordTypes = new SObjectRecordTypes('Opportunity');
        final String recordTypeName = (new List<String>(
            Account.SObjectType.getDescribe().getRecordTypeInfosByDeveloperName().keySet()
        ))[0];
        System.assertNotEquals(
            null,
            opportunityRecordTypes.getRecordTypeId(recordTypeName),
            'The opportunity should return the record type from the SObjectRecordTypes instance'
        );
    }

    @IsTest
    private static void getRecordTypeIdInvalidDeveloperNameTest() {
        SObjectRecordTypes opportunityRecordTypes = new SObjectRecordTypes('Opportunity');
        System.assertEquals(
            null,
            opportunityRecordTypes.getRecordTypeId('Invalid record type developer name'),
            'The invalid record type name should return null as the record type id'
        );
    }

    @IsTest
    private static void getRecordTypeDeveloperNameTest() {
        SObjectRecordTypes opportunityRecordTypes = new SObjectRecordTypes('Opportunity');
        final Id recordTypeId = opportunityRecordTypes.getDefaultId();

        System.assertNotEquals(
            null,
            opportunityRecordTypes.getRecordTypeDeveloperName(recordTypeId),
            'A developer record type name should have been returned'
        );
    }
}
