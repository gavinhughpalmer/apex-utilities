---
layout: default
---
# StringBuilder class

In Apex String is an immutable object, meaning that whenever you wish to append to a string you are creating a new instance of the object, string builder mitigates this by only generating the string when it is needed. This class can be useful when joining a large number of strings together Usage: StringBuilder text = new StringBuilder(); for (Integer i = 0; i < 10; i++) { text.append(String.valueOf(i)); } System.debug(text.toString());


**Author:** Gavin Palmer

**Date:** 2018-06-28
---
## Constructors
### `StringBuilder()`
### `StringBuilder(Object value)`
---
## Methods
### `append(String value)` → `StringBuilder`
### `append(Object value)` → `StringBuilder`
### `append(StringBuilder stringBuilder)` → `StringBuilder`
### `capacity()` → `Integer`
### `length()` → `Integer`
### `setSeparator(String separator)` → `void`
### `toString()` → `String`
---
