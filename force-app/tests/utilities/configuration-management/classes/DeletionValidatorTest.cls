/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
* @description Test class for DeletionValidator
*
* 2019-02-11 : Gavin Palmer - Original
**/
@IsTest
@SuppressWarnings('PMD.ApexUnitTestClassShouldHaveAsserts')
private class DeletionValidatorTest {
    
    @IsTest
    private static void registerTestAllowedDelete() {
        ConfigurationManager.getInstance().turnDeletionOn();
        DeletionValidator validator = new DeletionValidator();
        validator.register(getSObjectWrapper());
        Assert.doesNotHavePageMessages();
    }

    @IsTest
    private static void registerTestNotAllowedDelete() {
        ConfigurationManager.getInstance().turnDeletionOff();
        DeletionValidator validator = new DeletionValidator();
        validator.register(getSObjectWrapper());
        Assert.pageMessage(DeletionValidator.NOT_ALLOWED_DELETE);
    }

    private static SObjectTriggerWrapper getSObjectWrapper() {
        return new SObjectTriggerWrapper(new Account(), new Account());
    }
}
