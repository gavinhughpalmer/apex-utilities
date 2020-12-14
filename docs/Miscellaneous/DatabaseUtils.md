---
layout: default
---
# DatabaseUtils class

This class is a utility for the Database class


**Author:** Gavin Palmer

**Date:** 2019-03-13
---
## Properties

### `errorStringSeperator` → `String`

This is the seperator to be used when concatenating the string, defaults to unix new line character

---
## Methods
### `getErrorString(List<Database.Error> errors)` → `String`

This function will concatenate the errors output from the database actions

#### Parameters
|Param|Description|
|-----|-----------|
|`errors` |  a list of database errors that are to be concatenated |

#### Return

**Type**

String

**Description**

a concatenated list of the errors passed into the function

#### Example
```java
Database.SaveResult results = Database.insert(newAccount, false);
String errors = DatabaseUtils.getErrorString(results.getErrors());
```

---
