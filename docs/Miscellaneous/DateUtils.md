---
layout: default
---
# DateUtils class

This class will be used for reusable date functions


**Author:** Gavin Palmer

**Date:** 2019-03-11
---
## Methods
### `getNow()` → `Datetime`

This method should be used be used in place of the standard datetime method, to allow date injection in test classes

#### Return

**Type**

Datetime

**Description**

The current datetime, or the one injected in a test method

### `getToday()` → `Date`

This method should be used be used in place of the standard date method, to allow date injection in test classes

#### Return

**Type**

Date

**Description**

The current date, or the one injected in a test method

### `toEndOfMonth(final Date input)` → `Date`

This function will return a date that is at the end of the month

#### Return

**Type**

Date

**Description**

A date at the end of the month

---
