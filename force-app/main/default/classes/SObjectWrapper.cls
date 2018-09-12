/*
 This class is a wrapper around the SObject class to allow users to retrieve parent fields from the sobject
*/
public class SObjectWrapper {

    @testVisible private static final String INVALID_PARENT_MESSAGE = 'The provided field is not a valid relationship field';
    public class InvalidFieldException extends Exception {}

    private final SObject wrappedSObject;
    private final String objectApiName;
    private final SchemaFacade schema = SchemaFacade.getInstance();

    public SObjectWrapper(SObject sObjectToWrap) {
        wrappedSObject = sObjectToWrap;
        objectApiName = String.valueOf(sObjectToWrap.getSObjectType());
    }

    public Object get(String fieldApiName) {
        if (isRelatedField(fieldApiName)) {
            return getParentField(fieldApiName);
        }
        return wrappedSObject.get(fieldApiName);
    }

    private static Boolean isRelatedField(String fieldApiName) {
        return fieldApiName.contains('.');
    }

    // TODO implement a recursive call to retrieve multiple parent fields
    private Object getParentField(String fieldApiName) {
        RelationshipField field = new RelationshipField(fieldApiName);
        SObject parentSObject = wrappedSObject.getSobject(field.relationshipApiName);
        return parentSObject == null ? null : parentSObject.get(field.relatedFieldName);
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
            final List<String> parentRelationshipAndField = fieldApiName.split('\\.');
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