/**
 * @author Gavin Palmer
 * @date 2020-05-29
 * @group Schema
 * @description This is a simple class to swap between the id and relationship refrence field when dynamically refrencing relationship fields
 * Usage:
 * // Can be used if you have the relationship field
 * Relationship accountLookup = Relationship.fromRefrenceField('Account');
 * System.debug(accountLookup.idFieldName); // AccountId
 * // Or if you have the id field
 * accountLookup = Relationship.fromIdField('AccountId');
 * System.debug(accountLookup.referenceFieldName); // Account
 * // Similarly for custom objects
 * accountLookup = Relationship.fromRefrenceField('Account__r');
 * System.debug(accountLookup.idFieldName); // Account__c
 *
 * accountLookup = Relationship.fromIdField('Account__c');
 * System.debug(accountLookup.referenceFieldName); // Account__r
 *
 **/
public with sharing class Relationship {
    public static final String INVALID_RELATIONSHIP_FIELD = 'The field passed in is not a relationship. Field Value: ';

    public final String referenceFieldName;
    public final String idFieldName;

    private Relationship(String referenceFieldName, String idFieldName) {
        this.referenceFieldName = referenceFieldName;
        this.idFieldName = idFieldName;
    }

    public static Relationship fromRefrenceField(String referenceFieldName) {
        String idFieldName;
        if (referenceFieldName.toLowerCase().endsWith('__r')) {
            idFieldName = referenceFieldName.replaceAll('(?i)__r', '__c');
        } else {
            // cannot really check for any errors here, just have to trust it is correct
            idFieldName = referenceFieldName + 'Id';
        }
        return new Relationship(referenceFieldName, idFieldName);
    }

    public static Relationship fromIdField(String idFieldName) {
        String referenceFieldName;
        if (idFieldName.toLowerCase().endsWith('__c')) {
            referenceFieldName = idFieldName.replaceAll('(?i)__c', '__r');
        } else if (idFieldName.toLowerCase().endsWith('id')) {
            // cannot really check for any errors here, just have to trust it is correct
            referenceFieldName = idFieldName.replaceAll('(?i)id', '');
        } else {
            throw new InvalidFieldException(INVALID_RELATIONSHIP_FIELD + idFieldName);
        }
        return new Relationship(referenceFieldName, idFieldName);
    }
}
