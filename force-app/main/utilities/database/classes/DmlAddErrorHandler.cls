public inherited sharing class DmlAddErrorHandler implements DmlResultHandler {
    private Map<Id, SObject> parentRecords;
    private Schema.SObjectField parentField;
    private String errorMessage;

    public void handle(DatabaseResult dmlResult) {
        parentRecords.get(dmlResult.originSObject.get(parentField)).addError(errorMessage);
    }
}
