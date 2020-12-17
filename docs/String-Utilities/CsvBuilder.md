---
layout: default
---
# CsvBuilder class

The CsvBuilder is used to build csv files from some input


**Author:** Gavin Palmer

**Date:** 2018-06-28
---
## Constructors
### `CsvBuilder(String lineEnding)`
### `CsvBuilder()`
---
## Properties

### `UNIX_LINE_ENDING` → `String`

### `WINDOWS_LINE_ENDING` → `String`

---
## Methods
### `ColumnBuilder(String lineEnding)` → `public`
### `RowBuilder()` → `public`
### `append(RowBuilder rowToAdd)` → `ColumnBuilder`
### `appendField(String headerName, String fieldValue)` → `CsvBuilder`

append field will add a field into the existing CSV, if nothing is added to a row for a header, it will be left blank

#### Parameters
|Param|Description|
|-----|-----------|
|`headerName` |  the header name the field should be added to, |
|`fieldValue` |  The field value that should be added to the header, |

### `newRow()` → `CsvBuilder`

This method will move the CSV to processing a new row

### `toString()` → `String`
### `totalRows()` → `Integer`
---
## Inner Classes

### CsvBuilder.InvalidRowException class
---
