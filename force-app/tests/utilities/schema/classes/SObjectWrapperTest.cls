/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * feel like a test should be written to test the lookup to a custom object to get 100% coverage but then a test custom object needs to be deployed with the package so have avoided
 *
 * 2019-03-23 : Gavin Palmer - Original
 **/
@isTest
private class SObjectWrapperTest {
    @isTest
    private static void getTestObjectField() {
        final String testAccountName = 'Test Account';
        Account testAccount = new Account(Name = testAccountName);

        SObjectWrapper wrappedTestAccount = new SObjectWrapper(testAccount);
        System.assertEquals(
            testAccountName,
            wrappedTestAccount.get('Name'),
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
            testAccountName,
            wrappedTestContact.get('Account.Name'),
            'The name should be returned from the sobject wrapper when get is called with the relationship field'
        );
    }

    @isTest
    private static void getTestRelatedObjectFieldRecursive() {
        final String testUserLastName = 'Test Name';
        User testUser = new User(LastName = testUserLastName);
        Account testAccount = new Account(Owner = testUser);
        Contact testContact = new Contact(Account = testAccount);

        SObjectWrapper wrappedTestContact = new SObjectWrapper(testContact);
        System.assertEquals(
            testUserLastName,
            wrappedTestContact.get('Account.Owner.LastName'),
            'The name should be returned from the sobject wrapper when get is called with the relationship field'
        );
    }

    @isTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    private static void getTestRelatedObjectNullValues() {
        Contact testContact = new Contact();
        SObjectWrapper wrappedTestContact = new SObjectWrapper(testContact);
        try {
            wrappedTestContact.get('Account.Owner.LastName');
            Assert.fail(
                'An error should have been thrown when an object is accessed that has not been initialised on the object'
            );
        } catch (InvalidFieldException exceptionToHandle) {
            Assert.contains(
                exceptionToHandle.getMessage(),
                SObjectWrapper.NON_INITIALISED_RELATIONSHIP
            );
        } catch (Exception exceptionToHandle) {
            Assert.fail(
                'A more specific error should have been recieved, error recieved was: ' +
                exceptionToHandle.getMessage() +
                exceptionToHandle.getStackTraceString()
            );
        }
    }

    @isTest
    private static void describeTestObjectField() {
        Account testAccount = new Account();
        SObjectWrapper wrappedTestAccount = new SObjectWrapper(testAccount);
        System.assertEquals(
            Account.Name.getDescribe(),
            wrappedTestAccount.describe('Name'),
            'The describe method called on the sobject wrapper should return the describe result'
        );
    }

    @isTest
    private static void describeTestRelatedObjectField() {
        Contact testContact = new Contact();
        SObjectWrapper wrappedTestContact = new SObjectWrapper(testContact);
        System.assertEquals(
            Account.Name.getDescribe(),
            wrappedTestContact.describe('Account.Name'),
            'The describe method called on the sobject wrapper should return the describe result'
        );
    }

    @isTest
    private static void describeRelatedObjectFieldRecursive() {
        Contact testContact = new Contact();
        SObjectWrapper wrappedTestContact = new SObjectWrapper(testContact);
        System.assertEquals(
            User.LastName.getDescribe(),
            wrappedTestContact.describe('Account.Owner.LastName'),
            'The describe method called on the sobject wrapper should return the describe result'
        );
    }

    @isTest
    @SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
    private static void testRelationshipFieldInvalidRelationshipField() {
        try {
            new SObjectWrapper.RelationshipField('NotAField');
            Assert.fail(
                'An error should have been thrown when an invalid relationship is passed into the RelationshipField constructor'
            );
        } catch (InvalidFieldException exceptionToHandle) {
            System.assertEquals(
                SObjectWrapper.INVALID_PARENT_MESSAGE,
                exceptionToHandle.getMessage(),
                'The error raised does not match the invalid parent relationship message'
            );
        } catch (Exception genericException) {
            Assert.fail(
                'An unexpected exception has been thrown with the following message: ' +
                genericException.getMessage()
            );
        }
    }
}
