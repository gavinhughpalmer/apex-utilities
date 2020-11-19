/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
 * @version 1.0
 * @description Test class for SObjectTriggerWrapper
 *
 * 2018-10-29 : Gavin Palmer - Original
 **/
@IsTest
private class SObjectTriggerWrapperTest {
    @IsTest
    private static void hasChangedFieldTestFieldChanged() {
        Account newAccount = new Account(Name = 'Name 1');
        Account oldAccount = new Account(Name = 'Different Name');
        SObjectTriggerWrapper wrappedAccount = new SObjectTriggerWrapper(newAccount, oldAccount);

        System.assert(
            wrappedAccount.hasChanged(Account.Name),
            'The method should return true when the field has changed'
        );
    }

    @IsTest
    private static void hasChangedFieldNameTestFieldChanged() {
        Account newAccount = new Account(Name = 'Name 1');
        Account oldAccount = new Account(Name = 'Different Name');
        SObjectTriggerWrapper wrappedAccount = new SObjectTriggerWrapper(newAccount, oldAccount);

        System.assert(
            wrappedAccount.hasChanged('Name'),
            'The method should return true when the field has changed'
        );
    }

    @IsTest
    private static void hasChangedFieldTestFieldNotChanged() {
        Account newAccount = new Account(Name = 'Name 1');
        Account oldAccount = new Account(Name = 'Name 1');
        SObjectTriggerWrapper wrappedAccount = new SObjectTriggerWrapper(newAccount, oldAccount);

        System.assert(
            !wrappedAccount.hasChanged(Account.Name),
            'The method should return false when the field has not changed'
        );
    }

    @IsTest
    private static void hasChangedFieldNameTestFieldNotChanged() {
        Account newAccount = new Account(Name = 'Name 1');
        Account oldAccount = new Account(Name = 'Name 1');
        SObjectTriggerWrapper wrappedAccount = new SObjectTriggerWrapper(newAccount, oldAccount);

        System.assert(
            !wrappedAccount.hasChanged('Name'),
            'The method should return false when the field has not changed'
        );
    }

    @IsTest
    private static void hasChangedToFieldTest() {
        final String fieldValue = 'Name 1';
        Account newAccount = new Account(Name = fieldValue);
        Account oldAccount = new Account(Name = 'Tests');
        SObjectTriggerWrapper wrappedAccount = new SObjectTriggerWrapper(newAccount, oldAccount);

        System.assert(
            wrappedAccount.hasChangedTo(Account.Name, fieldValue),
            'The method should return true when the field has changed to the provided value'
        );
    }

    @IsTest
    private static void hasChangedToFieldNameTest() {
        final String fieldValue = 'Name 1';
        Account newAccount = new Account(Name = fieldValue);
        Account oldAccount = new Account(Name = 'Tests');
        SObjectTriggerWrapper wrappedAccount = new SObjectTriggerWrapper(newAccount, oldAccount);

        System.assert(
            wrappedAccount.hasChangedTo('Name', fieldValue),
            'The method should return true when the field has changed to the provided value'
        );
    }
}
