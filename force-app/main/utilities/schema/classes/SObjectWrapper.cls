/**
* @author Gavin Palmer (gavin.palmer@cloudshiftgroup.com)
* @version 1.0
* @description This is a wrapper around the SObject class that its primary function is to be able to retrieve parent fields dynamically
* Usage:
* Account myContact = [SELECT Account.Name FROM Contact LIMIT 1];
* SObjectWrapper wrappedContact = new SObjectWrapper(myContact);
* String accountName = (String) wrappedContact.get('Account.Name');
*
* 2019-03-23 : Gavin Palmer - Original
**/
public virtual class SObjectWrapper {

    @testVisible private static final String INVALID_PARENT_MESSAGE = 'The provided field is not a valid relationship field';
    public class InvalidFieldException extends Exception {}

    private final SObject wrappedSObject;
    private final String objectApiName;
    private final SchemaFacade schema = SchemaFacade.getInstance();

    public SObjectWrapper(SObject sObjectToWrap) {
        wrappedSObject = sObjectToWrap;
        objectApiName = String.valueOf(sObjectToWrap.getSObjectType());
    }

    public virtual Object get(String fieldApiName) {
        if (isRelatedField(fieldApiName)) {
            return getParentField(wrappedSObject, fieldApiName);
        }
        return wrappedSObject.get(fieldApiName);
    }

    public virtual void put(String fieldApiName, Object fieldValue) {
        wrappedSObject.put(fieldApiName, fieldValue);
    }

    private static Boolean isRelatedField(String fieldApiName) {
        return fieldApiName.contains('.');
    }

    private static Object getParentField(SObject childSObject, String fieldApiName) {
        RelationshipField field = new RelationshipField(fieldApiName);
        SObject parentSObject = childSObject.getSobject(field.relationshipApiName);
        return isRelatedField(field.relatedFieldName) ? getParentField(parentSObject, field.relatedFieldName) : parentSObject.get(field.relatedFieldName);
    }

    public DescribeFieldResult describe(String fieldApiName) {
        if (isRelatedField(fieldApiName)) {
            return describeParentField(fieldApiName);
        }
        return describeField(fieldApiName);
    }

    private DescribeFieldResult describeParentField(String fieldApiName) {
        RelationshipField relatedField = new RelationshipField(fieldApiName);
        String parentObjectName = getRelatedObjectName(relatedField.relationshipApiName);
        return schema.getFieldDescribe(parentObjectName, relatedField.relatedFieldName);
    }

    @testVisible
    private String getRelatedObjectName(String relationshipApiName) {
        String relationshipFieldName = getRelationshipFieldName(relationshipApiName);
        DescribeFieldResult relationshipField = schema.getFieldDescribe(objectApiName, relationshipFieldName);
        return relationshipField.getReferenceTo()[0].getDescribe().getName();
    }

    private static String getRelationshipFieldName(String relationshipApiName) {
        if (relationshipApiName.toLowerCase().endsWith('__r')) {
            return relationshipApiName.replaceAll('(?i)__r', '__c');
        }
        return relationshipApiName + 'Id';
    }

    private DescribeFieldResult describeField(String fieldApiName) {
        return schema.getFieldDescribe(objectApiName, fieldApiName);
    }

    @testVisible
    private class RelationshipField {
        public final String relationshipApiName;
        public final String relatedFieldName;

        public RelationshipField(String fieldApiName) {
            validateParentField(fieldApiName);
            final List<String> parentRelationshipAndField = fieldApiName.split('\\.', 2);
            relationshipApiName = parentRelationshipAndField[0];
            relatedFieldName = parentRelationshipAndField[1];
        }

        private void validateParentField(String fieldApiName) {
            if (!isRelatedField(fieldApiName)) {
                throw new InvalidFieldException(INVALID_PARENT_MESSAGE);
            }
        }
    }
}