---
layout: default
---
# SObjectRecordTypes class

Utility class to help make interacting with an objects record types slightly easier eg cal call SObjectRecordTypes opportunityRecordTypes = new SObjectRecordTypes('Opportunity'); Id defaultOpportunityRecordTypeId = opportunityRecordTypes.getDefaultId();


**Author:** Gavin Palmer

**Date:** 2019-09-24
---
## Constructors
### `SObjectRecordTypes(final String objectApiName)`
---
## Methods
### `getDefaultId()` → `Id`
### `getRecordTypeDeveloperName(final Id recordTypeId)` → `String`
### `getRecordTypeId(final String developerName)` → `Id`
---
