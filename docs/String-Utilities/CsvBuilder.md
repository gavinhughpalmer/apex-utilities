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
### `newRow()` → `CsvBuilder`
### `toString()` → `String`
### `totalRows()` → `Integer`
---
## Inner Classes

### CsvBuilder.InvalidRowException class
---
