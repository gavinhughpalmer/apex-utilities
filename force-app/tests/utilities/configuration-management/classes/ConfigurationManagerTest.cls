/**
 * @author Gavin Palmer
 * @date 2018-06-27
 *
 **/
@IsTest(isParallel=true)
private class ConfigurationManagerTest {
    @IsTest
    private static void singletonTest() {
        ConfigurationManager initialInstance = ConfigurationManager.getInstance();
        ConfigurationManager secondaryInstance = ConfigurationManager.getInstance();
        // We have to use a comparison to validate the exact instance is the same
        Assert.isTrue(
            initialInstance === secondaryInstance,
            'The get instance method should always return the same instance of the ConfigurationManager'
        );
    }

    @IsTest
    private static void turnAutomationsOnTest() {
        ConfigurationManager.turnAutomationsOn();

        Configuration__c configurationSetting = Configuration__c.getInstance();
        Assert.isFalse(
            configurationSetting.Are_Triggers_Off__c,
            'The trigger should all be turned on'
        );
        Assert.isFalse(
            configurationSetting.Are_Workflows_Off__c,
            'The workflows should all be turned on'
        );
        Assert.isFalse(
            configurationSetting.Are_Validations_Off__c,
            'The validations should all be turned on'
        );
        Assert.isFalse(
            configurationSetting.Are_Processes_Off__c,
            'The processes should all be turned on'
        );
    }

    @IsTest
    private static void turnAutomationsOffTest() {
        ConfigurationManager.turnAutomationsOff();

        Configuration__c configurationSetting = Configuration__c.getInstance();
        Assert.isTrue(
            configurationSetting.Are_Triggers_Off__c,
            'The triggers should all be turned on'
        );
        Assert.isTrue(
            configurationSetting.Are_Workflows_Off__c,
            'The workflows should all be turned on'
        );
        Assert.isTrue(
            configurationSetting.Are_Validations_Off__c,
            'The validations should all be turned on'
        );
        Assert.isTrue(
            configurationSetting.Are_Processes_Off__c,
            'The processes should all be turned on'
        );
    }

    @IsTest
    private static void areTriggersOffTestNoSetting() {
        Assert.isTrue(
            ConfigurationManager.getInstance().areTriggersOn(),
            'The triggers should always be off by default, ie when a configuration record does not exist in the system'
        );
    }

    @IsTest
    private static void toggleTriggersTest() {
        ConfigurationManager configuration = ConfigurationManager.getInstance();
        configuration.turnTriggersOff();
        Assert.isTrue(
            configuration.areTriggersOff(),
            'Triggers should have truned off after the off method is called'
        );
        configuration.turnTriggersOn();
        Assert.isTrue(
            configuration.areTriggersOn(),
            'Triggers should have truned On after the On method is called'
        );
    }

    @IsTest
    private static void commitChangesTestWithoutExistingSetting() {
        Assert.areEqual(
            0,
            [SELECT COUNT() FROM Configuration__c],
            'There should be no Configuration__c records in the system before the save method is called'
        );
        ConfigurationManager configuration = ConfigurationManager.getInstance();
        configuration.commitChanges();
        Assert.areEqual(
            1,
            [SELECT COUNT() FROM Configuration__c],
            'There should be 1 Configuration__c records after the bypass method is called'
        );
    }

    @IsTest
    private static void commitChangesTestWithExistingSettingWorkflows() {
        Configuration__c configurationSetting = new Configuration__c(
            Are_Workflows_Off__c = true,
            SetupOwnerId = UserInfo.getUserId()
        );
        insert configurationSetting;
        ConfigurationManager configuration = ConfigurationManager.getInstance();
        configuration.turnWorkflowsOn();
        configuration.commitChanges();

        configurationSetting = [
            SELECT Are_Workflows_Off__c
            FROM Configuration__c
            WHERE Id = :configurationSetting.Id
        ];
        Assert.isFalse(
            configurationSetting.Are_Workflows_Off__c,
            'The Configuration__c setting should have been comitted with workflows on'
        );
        configuration.turnWorkflowsOff();
        configuration.commitChanges();

        configurationSetting = [
            SELECT Are_Workflows_Off__c
            FROM Configuration__c
            WHERE Id = :configurationSetting.Id
        ];
        Assert.isTrue(
            configurationSetting.Are_Workflows_Off__c,
            'The Configuration__c setting should have been comitted with workflows off'
        );
    }

    @IsTest
    private static void commitChangesTestWithExistingSettingValidations() {
        Configuration__c configurationSetting = new Configuration__c(
            Are_Validations_Off__c = true,
            SetupOwnerId = UserInfo.getUserId()
        );
        insert configurationSetting;
        ConfigurationManager configuration = ConfigurationManager.getInstance();
        configuration.turnValidationsOn();
        configuration.commitChanges();

        configurationSetting = [
            SELECT Are_Validations_Off__c
            FROM Configuration__c
            WHERE Id = :configurationSetting.Id
        ];
        Assert.isFalse(
            configurationSetting.Are_Validations_Off__c,
            'The Configuration__c setting should have been comitted with Validations on'
        );
        configuration.turnValidationsOff();
        configuration.commitChanges();

        configurationSetting = [
            SELECT Are_Validations_Off__c
            FROM Configuration__c
            WHERE Id = :configurationSetting.Id
        ];
        Assert.isTrue(
            configurationSetting.Are_Validations_Off__c,
            'The Configuration__c setting should have been comitted with Validations off'
        );
    }

    @IsTest
    private static void commitChangesTestWithExistingSettingProcesses() {
        Configuration__c configurationSetting = new Configuration__c(
            Are_Processes_Off__c = true,
            SetupOwnerId = UserInfo.getUserId()
        );
        insert configurationSetting;
        ConfigurationManager configuration = ConfigurationManager.getInstance();
        configuration.turnProcessesOn();
        configuration.commitChanges();

        configurationSetting = [
            SELECT Are_Processes_Off__c
            FROM Configuration__c
            WHERE Id = :configurationSetting.Id
        ];
        Assert.isFalse(
            configurationSetting.Are_Processes_Off__c,
            'The Configuration__c setting should have been comitted with Processes on'
        );
        configuration.turnProcessesOff();
        configuration.commitChanges();

        configurationSetting = [
            SELECT Are_Processes_Off__c
            FROM Configuration__c
            WHERE Id = :configurationSetting.Id
        ];
        Assert.isTrue(
            configurationSetting.Are_Processes_Off__c,
            'The Configuration__c setting should have been comitted with Processes off'
        );
    }
}
