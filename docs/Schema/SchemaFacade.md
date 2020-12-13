---
layout: default
---
# SchemaFacade class

This is a facade for the schema describe functions to make accessing the schema much easier within apex. It is implemented as a sigleton so that it can perform some form of cacheing, this probably isn't nessisary as I think salesforce implements cacheing on the schema methods anyway, but this is just to be safe SchemaFacade schema = SchemaFacade.getInstance(); DescribeSObjectResult accountDescribe = schema.getDescribe('Account'); System.debug(accountDescribe.getName()); DescribeFieldResult fieldDescribe = schema.getFieldDescribe('Account', 'Name'); System.debug(fieldDescribe.getName());


**Author:** Gavin Palmer

**Date:** 2019-02-02
---
## Methods
### `getDescribe(String objectApiName)` → `DescribeSObjectResult`
### `getFieldDescribe(String objectApiName, String fieldApiName)` → `DescribeFieldResult`
### `getInstance()` → `SchemaFacade`
### `isNotValidField(String objectApiName, String fieldApiName)` → `Boolean`
### `isNotValidSObject(String objectApiName)` → `Boolean`
### `isValidField(String objectApiName, String fieldApiName)` → `Boolean`
### `isValidSObject(String objectApiName)` → `Boolean`
---
## Inner Classes

### SchemaFacade.InvalidDescribeException class
---
