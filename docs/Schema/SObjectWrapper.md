---
layout: default
---
# SObjectWrapper class

This is a wrapper around the SObject class that its primary function is to be able to retrieve parent fields dynamically Usage: Account myContact = [SELECT Account.Name FROM Contact LIMIT 1]; SObjectWrapper wrappedContact = new SObjectWrapper(myContact); String accountName = (String) wrappedContact.get('Account.Name');


**Author:** Gavin Palmer

**Date:** 2019-03-23
---
## Constructors
### `SObjectWrapper(SObject sObjectToWrap)`
---
## Properties

### `INVALID_PARENT_MESSAGE` → `String`

### `NON_INITIALISED_RELATIONSHIP` → `String`

### `relatedFieldName` → `String`

### `relationshipApiName` → `String`

---
## Methods
### `RelationshipField(String fieldApiName)` → `public`
### `describe(String fieldApiName)` → `DescribeFieldResult`
### `get(String fieldApiName)` → `Object`
### `put(String fieldApiName, Object fieldValue)` → `void`
---
