/**
 * @author Gavin Palmer
 * @date 2019-04-20
 * @group Logging
 * @description The LogWriter class converts log events into log sobjects so that they are perminantely committed into the database
 *
 **/
public without sharing class LogWriter extends Triggerable {
    private final List<Log__c> logs = new List<Log__c>();

    public override void register(SObjectTriggerWrapper wrappedSObject) {
        Log_Event__e logEvent = (Log_Event__e) wrappedSObject.getSObject();
        logs.add(
            new Log__c(
                Level__c = logEvent.Level__c,
                Messages__c = logEvent.Messages__c,
                Record_Id__c = logEvent.Record_Id__c,
                Type__c = logEvent.Type__c,
                Quiddity__c = logEvent.Quiddity__c,
                Transaction_Id__c = logEvent.Transaction_Id__c
            )
        );
    }

    public override void performAction() {
        insert logs;
        // don't error handle as we assume no errors will occur
    }
}
