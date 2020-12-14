---
layout: default
---
# Relationship class

This is a simple class to swap between the id and relationship refrence field when dynamically refrencing relationship fields Usage: // Can be used if you have the relationship field Relationship accountLookup = Relationship.fromRefrenceField('Account'); System.debug(accountLookup.idFieldName); // AccountId // Or if you have the id field accountLookup = Relationship.fromIdField('AccountId'); System.debug(accountLookup.referenceFieldName); // Account // Similarly for custom objects accountLookup = Relationship.fromRefrenceField('Account__r'); System.debug(accountLookup.idFieldName); // Account__c accountLookup = Relationship.fromIdField('Account__c'); System.debug(accountLookup.referenceFieldName); // Account__r


**Author:** Gavin Palmer

**Date:** 2020-05-29
---
## Properties

### `INVALID_RELATIONSHIP_FIELD` → `String`

### `idFieldName` → `String`

### `referenceFieldName` → `String`

---
## Methods
### `fromIdField(String idFieldName)` → `Relationship`
### `fromRefrenceField(String referenceFieldName)` → `Relationship`
---
