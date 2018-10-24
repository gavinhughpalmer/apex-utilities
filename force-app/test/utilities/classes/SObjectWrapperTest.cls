/*
 Test class for SObjectWrapper
*/
@isTest
private class SObjectWrapperTest {

    @isTest
    private static void getTestObjectField() {
        final String testAccountName = 'Test Account';
        Account testAccount = new Account(Name = testAccountName);

        SObjectWrapper wrappedTestAccount = new SObjectWrapper(testAccount);
        System.assertEquals(
            testAccountName, wrappedTestAccount.get('Name'),
            'The name should be returned from the sobject wrapper when get is called'
        );
    }

    @isTest
    private static void getTestRelatedObjectField() {
        final String testAccountName = 'Test Account';
        Account testAccount = new Account(Name = testAccountName);
        Contact testContact = new Contact(Account = testAccount);

        SObjectWrapper wrappedTestContact = new SObjectWrapper(testContact);
        System.assertEquals(
            testAccountName, wrappedTestContact.get('Account.Name'),
            'The name should be returned from the sobject wrapper when get is called with the relationship field'
        );
    }

    @isTest
    private static void getRelatedObjectNameTestCustomObject() {
        // TODO Write a test for an object that has a lookup to a standard object to get 100% coverage
    }

    @isTest
    private static void describeTestObjectField() {
        Account testAccount = new Account();
        SObjectWrapper wrappedTestAccount = new SObjectWrapper(testAccount);
        System.assertEquals(
            Account.Name.getDescribe(), wrappedTestAccount.describe('Name'),
            'The describe method called on the sobject wrapper should return the describe result'
        );
    }

    @isTest
    private static void describeTestRelatedObjectField() {
        Contact testContact = new Contact();
        SObjectWrapper wrappedTestContact = new SObjectWrapper(testContact);
        System.assertEquals(
            Account.Name.getDescribe(), wrappedTestContact.describe('Account.Name'),
            'The describe method called on the sobject wrapper should return the describe result'
        );
    }

    @isTest
    private static void testRelationshipFieldInvalidRelationshipField() {
        try {
            new SObjectWrapper.RelationshipField('NotAField');
            System.assert(
                false,
                'An error should have been thrown when an invalid relationship is passed into the RelationshipField constructor'
            );
        } catch (SObjectWrapper.InvalidFieldException exceptionToHandle) {
            System.assertEquals(
                SObjectWrapper.INVALID_PARENT_MESSAGE, exceptionToHandle.getMessage(),
                'The error raised does not match the invalid parent relationship message'
            );
        } catch (Exception genericException) {
            System.assert(
                false,
                'An unexpected exception has been thrown with the following message: ' + genericException.getMessage()
            );
        }
    }
}