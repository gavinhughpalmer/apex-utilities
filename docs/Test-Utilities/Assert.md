---
layout: default
---
# Assert class

This class is intended to extend the usage of the standard System.assert methods in salesforce, the class has been anotated with @IsTest because it is untestable due to the assert statement


**Author:** Gavin Palmer

**Date:** 2018-06-27
---
## Methods
### `contains(String fullString, String substring)` → `void`

This assertion will check for a string within a secondary substring, this mainly wraps to add the defult error message

#### Parameters
|Param|Description|
|-----|-----------|
|`fullString` |  The full string that you wish to check |
|`substring` |  The substring that you are checking exists within the fullString |

### `doesNotHavePageMessages()` → `void`

This assertion validates there is page not messages provided

### `fail(String message)` → `void`

This is a simple assertion to force a failure, can be used if an exception is expected to be thown in a test

#### Parameters
|Param|Description|
|-----|-----------|
|`message` |  The message you wish to throw if this assertion is ever hit |

### `hasPageMessages()` → `void`

This assertion validates there is page messages provided

### `pageMessage(final String expectedPageMessage)` → `void`

This assertion will check the page message provided exists within the page messages

---
