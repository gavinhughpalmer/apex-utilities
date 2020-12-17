---
layout: default
---
# ConfigurationManager class

This uses a custom setting underneath that will allow callers to programatically disable triggers, workflows, process builders and validation rules through code. This requires all new configurations to include a catch as the first line so that they can all be turned off. If you are using some form of a trigger framework the catch can be added in there so that this doesn't need to be remembered by all developers when adding new triggers. The class is mostly useful for turning off automation while setting up test data in test classes so that you can fully test your classes


**Author:** Gavin Palmer

**Date:** 2018-06-27
---
## Methods
### `areTriggersOff()` → `Boolean`
### `areTriggersOn()` → `Boolean`
### `commitChanges()` → `void`
### `getInstance()` → `ConfigurationManager`
### `isAllowedDelete()` → `Boolean`
### `isNotAllowedDelete()` → `Boolean`
### `turnAutomationsOff()` → `void`
### `turnAutomationsOn()` → `void`
### `turnDeletionOff()` → `void`
### `turnDeletionOn()` → `void`
### `turnProcessesOff()` → `void`
### `turnProcessesOn()` → `void`
### `turnTriggersOff()` → `void`
### `turnTriggersOn()` → `void`
### `turnValidationsOff()` → `void`
### `turnValidationsOn()` → `void`
### `turnWorkflowsOff()` → `void`
### `turnWorkflowsOn()` → `void`
---
