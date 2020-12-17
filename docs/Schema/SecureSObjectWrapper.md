---
layout: default
---
# SecureSObjectWrapper class

This class is a secure wrapper for the sobject that obeys field level security for the user accessing it. This wraps [SObjectWrapper](/docs/Schema/SObjectWrapper.md) so the recursive retrieves will be enabled


**Author:** Gavin Palmer

**Date:** 2019-03-23
---
## Constructors
### `SecureSObjectWrapper(SObject sObjectToWrap)`
---
## Methods
### `get(String fieldApiName)` → `Object`
### `put(String fieldApiName, Object fieldValue)` → `void`
---
