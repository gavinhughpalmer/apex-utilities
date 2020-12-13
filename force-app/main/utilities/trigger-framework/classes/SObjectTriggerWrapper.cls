/**
 * @author Gavin Palmer
 * @date 2018-10-29
 * @group Trigger Framework
 * @description This class is used by the trigger framework to give a few utility methods to the SObjects
 *
 **/
public inherited sharing class SObjectTriggerWrapper {
    private final SObject newSObject;
    private final SObject oldSObject;

    public SObjectTriggerWrapper(SObject newSObject, SObject oldSObject) {
        this.newSObject = newSObject;
        this.oldSObject = oldSObject;
    }

    public Boolean hasChanged(String fieldName) {
        return oldSObject == null || oldSObject.get(fieldName) != newSObject.get(fieldName);
    }

    public Boolean hasChanged(Schema.SObjectField field) {
        return oldSObject == null || oldSObject.get(field) != newSObject.get(field);
    }

    public Boolean hasChangedTo(String fieldName, Object fieldValue) {
        return hasChanged(fieldName) && newSObject.get(fieldName) == fieldValue;
    }

    public Boolean hasChangedTo(Schema.SObjectField field, Object fieldValue) {
        return hasChanged(field) && newSObject.get(field) == fieldValue;
    }

    public SObject getSObject() {
        return newSObject;
    }
}
