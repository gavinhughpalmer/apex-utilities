/**
 * @author Gavin Palmer (gavinhughpalmer@gmail.com)
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
    public static final String INVALID_PARENT_MESSAGE = 'The provided field is not a valid relationship field';
    public static final String NON_INITIALISED_RELATIONSHIP = 'The relationship field that is attempting to be accessed has not been initialised.';

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
        SObject parentSObject;
        try {
            // this is a peculiar error that is thrown only on the second parent if is not initialised (first parent is fine)
            parentSObject = childSObject.getSobject(field.relationshipApiName);
        } catch (NullPointerException exceptionToHandle) {
            throw new InvalidFieldException(NON_INITIALISED_RELATIONSHIP);
        }
        if (isRelatedField(field.relatedFieldName)) {
            return getParentField(parentSObject, field.relatedFieldName);
        }
        return parentSObject.get(field.relatedFieldName);
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
        if (isRelatedField(relatedField.relatedFieldName)) {
            return describeParentField(relatedField.relatedFieldName);
        }
        return schema.getFieldDescribe(parentObjectName, relatedField.relatedFieldName);
    }

    @testVisible
    private String getRelatedObjectName(String relationshipApiName) {
        String relationshipFieldName = Relationship.fromRefrenceField(relationshipApiName)
            .idFieldName;
        DescribeFieldResult relationshipField = schema.getFieldDescribe(
            objectApiName,
            relationshipFieldName
        );
        return relationshipField.getReferenceTo()[0].getDescribe().getName();
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
