/*
 Test class for the SchemaFacade
*/
@IsTest
private class SchemaFacadeTest {

    @IsTest
    private static void isValidSObject() {
        System.assert(
            SchemaFacade.getInstance().isValidSObject('account'),
            'The account object should return as an existing object'
        );
    }

    @IsTest
    private static void isNotValidSObject() {
        System.assert(
            SchemaFacade.getInstance().isNotValidSObject('abaoefjk'),
            'The invalid object name should return as a not valid object'
        );
    }

    @IsTest
    private static void isValidField() {
        System.assert(
            SchemaFacade.getInstance().isValidField('account', 'Name'),
            'The account object should return as an existing object'
        );
    }

    @IsTest
    private static void isNotValidField() {
        System.assert(
            SchemaFacade.getInstance().isNotValidField('Account', 'adfasd'),
            'The invalid object name should return as a not valid object'
        );
    }

    @IsTest
    private static void getDescribe() {
        System.assertEquals(
            Account.SObjectType.getDescribe(),
            SchemaFacade.getInstance().getDescribe('Account'),
            'The dynamic describe call should return the account describe object'
        );
    }

    @IsTest
    private static void getFieldDescribe() {
        System.assertEquals(
            Account.Name.getDescribe(),
            SchemaFacade.getInstance().getFieldDescribe('Account', 'Name'),
            'The dynamic describe call should return the account name describe object'
        );
    }

    @IsTest
    private static void getDescribe_Exception() {
        final String invalidObjectName = 'Invalid Object';
        try {
            SchemaFacade.getInstance().getDescribe(invalidObjectName);
            System.assert(false, 'An exception should have been thrown');
        } catch (SchemaFacade.InvalidDescribeException invalidDescribeException) {
            System.assert(
                invalidDescribeException.getMessage().containsIgnoreCase(invalidObjectName),
                'The error message should contain the invalid object name: ' + invalidObjectName
            );
        } catch (Exception exceptionToCheck) {
            System.assert(false, 'A more specific error should be thrown: ' + exceptionToCheck.getMessage());
        }
    }

    @IsTest
    private static void getFieldDescribe_Exception() {
        final String invalidFieldName = 'Invalid Field';
        try {
            SchemaFacade.getInstance().getFieldDescribe('Account', invalidFieldName);
            System.assert(false, 'An exception should have been thrown');
        } catch (SchemaFacade.InvalidDescribeException invalidDescribeException) {
            System.assert(
                invalidDescribeException.getMessage().containsIgnoreCase(invalidFieldName),
                'The error message should contain the invalid field name: ' + invalidFieldName
            );
        } catch (Exception exceptionToCheck) {
            System.assert(false, 'A more specific error should be thrown: ' + exceptionToCheck.getMessage());
        }
    }
}