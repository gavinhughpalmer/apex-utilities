/**
* @author Gavin Palmer (gavinhughpalmer@gmail.com)
* @version 1.0
* @description This is a simple class to swap between the id and relationship refrence field when dynamically refrencing relationship fields
* Usage:
* // Can be used if you have the relationship field
* Relationship accountLookup = Relationship.fromRefrenceField('Account');
* System.debug(accountLookup.idFieldName); // AccountId
* // Or if you have the id field
* accountLookup = Relationship.fromIdField('AccountId');
* System.debug(accountLookup.refrenceFieldName); // Account
* // Similarly for custom objects
* accountLookup = Relationship.fromRefrenceField('Account__r');
* System.debug(accountLookup.idFieldName); // Account__c
*
* accountLookup = Relationship.fromIdField('Account__c');
* System.debug(accountLookup.refrenceFieldName); // Account__r
*
* 2020-05-29 : Gavin Palmer - Original
**/
public with sharing class Relationship {

    public static final String INVALID_RELATIONSHIP_FIELD = 'The field passed in is not a relationship. Field Value: ';

    public final String refrenceFieldName;
    public final String idFieldName;

    private Relationship(String refrenceFieldName, String idFieldName) {
        this.refrenceFieldName = refrenceFieldName;
        this.idFieldName = idFieldName;
    }

    public static Relationship fromRefrenceField(String refrenceFieldName) {
        String idFieldName;
        if (refrenceFieldName.toLowerCase().endsWith('__r')) {
            idFieldName = refrenceFieldName.replaceAll('(?i)__r', '__c');
        } else {
            // cannot really check for any errors here, just have to trust it is correct
            idFieldName = refrenceFieldName + 'Id';
        }
        return new Relationship(refrenceFieldName, idFieldName);
    }

    public static Relationship fromIdField(String idFieldName) {
        String refrenceFieldName;
        if (idFieldName.toLowerCase().endsWith('__c')) {
            refrenceFieldName = idFieldName.replaceAll('(?i)__c', '__r');
        } else if (idFieldName.toLowerCase().endsWith('id')) {
            // cannot really check for any errors here, just have to trust it is correct
            refrenceFieldName = idFieldName.replaceAll('(?i)id', '');
        } else {
            throw new InvalidFieldException(INVALID_RELATIONSHIP_FIELD + idFieldName);
        }
        return new Relationship(refrenceFieldName, idFieldName);
    }
}
