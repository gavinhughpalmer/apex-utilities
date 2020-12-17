---
layout: default
---
# AbstractSObjectTestFactory class

This factory class will be used as a base for any SObject creation in test classes, this pattern will define attributes that can be set in the test classes. This allows any required fields / validations to be defined in what is returned in the getSObject method allowing developers to easily enforce required fields accross all test classes if they are ever added in the UI. The method for inserting the records can be injected if specific ties around the insert need to be added for a specific use case, eg in the abstract SObject test factory test class


**Author:** Gavin Palmer

**Date:** 2018-10-23
---
## Properties

### `uniqueValue` → `String`

---
## Methods
### `FactoryDependancy(String parentIdField, AbstractSObjectTestFactory parentFactory)` → `public`
### `addDependancy(String parentIdField, AbstractSObjectTestFactory parentFactory)` → `void`
### `allowDuplicatesOnSave(Boolean areRulesOn)` → `void`
### `createDependanciesFor(List<SObject> childSObjects)` → `void`
### `createDependancyFor(SObject childSObject)` → `void`
### `getMultipleSObjects(Integer numberToCreate)` → `List<SObject>`
### `getSObject()` → `SObject`
### `insertMultipleSObjects(Integer numberToInsert)` → `List<SObject>`
### `insertMultipleWithDependancies(Integer numberToInsert)` → `List<SObject>`
### `insertSObject()` → `SObject`
### `insertWithDependancies()` → `SObject`
### `setInserter(Insertable inserter)` → `void`
---
