/**
 * @author Gavin Palmer
 * @date 2018-06-27
 * @group Configuration Management
 * @description This uses a custom setting underneath that will allow callers to programatically disable triggers,
 * workflows, process builders and validation rules through code.
 * This requires all new configurations to include a catch as the first line so that they can all be
 * turned off. If you are using some form of a trigger framework the catch can be added in there so
 * that this doesn't need to be remembered by all developers when adding new triggers.
 * The class is mostly useful for turning off automation while setting up test data in
 * test classes so that you can fully test your classes
 *
 **/
public without sharing class ConfigurationManager {
    private final Configuration__c configurationSetting = Configuration__c.getInstance();

    private static final ConfigurationManager INSTANCE = new ConfigurationManager();

    public static ConfigurationManager getInstance() {
        return INSTANCE;
    }

    public static void turnAutomationsOn() {
        INSTANCE.turnProcessesOn();
        INSTANCE.turnTriggersOn();
        INSTANCE.turnValidationsOn();
        INSTANCE.turnWorkflowsOn();
        INSTANCE.commitChanges();
    }

    public static void turnAutomationsOff() {
        INSTANCE.turnProcessesOff();
        INSTANCE.turnTriggersOff();
        INSTANCE.turnValidationsOff();
        INSTANCE.turnWorkflowsOff();
        INSTANCE.commitChanges();
    }

    @SuppressWarnings('PMD.EmptyStatementBlock')
    private ConfigurationManager() {
    }

    public Boolean areTriggersOff() {
        return configurationSetting.Are_Triggers_Off__c;
    }

    public Boolean areTriggersOn() {
        return !areTriggersOff();
    }

    public Boolean isAllowedDelete() {
        return configurationSetting.Is_Allowed_Delete__c;
    }

    public Boolean isNotAllowedDelete() {
        return !isAllowedDelete();
    }

    public void turnTriggersOff() {
        configurationSetting.Are_Triggers_Off__c = true;
    }

    public void turnTriggersOn() {
        configurationSetting.Are_Triggers_Off__c = false;
    }

    public void turnWorkflowsOff() {
        configurationSetting.Are_Workflows_Off__c = true;
    }

    public void turnWorkflowsOn() {
        configurationSetting.Are_Workflows_Off__c = false;
    }

    public void turnValidationsOff() {
        configurationSetting.Are_Validations_Off__c = true;
    }

    public void turnValidationsOn() {
        configurationSetting.Are_Validations_Off__c = false;
    }

    public void turnProcessesOff() {
        configurationSetting.Are_Processes_Off__c = true;
    }

    public void turnProcessesOn() {
        configurationSetting.Are_Processes_Off__c = false;
    }

    public void turnDeletionOff() {
        configurationSetting.Is_Allowed_Delete__c = false;
    }

    public void turnDeletionOn() {
        configurationSetting.Is_Allowed_Delete__c = true;
    }

    public void commitChanges() {
        upsert configurationSetting;
    }
}
