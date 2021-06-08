---
layout: default
---
# TriggerDispatcher class

This trigger dispatcher will be called from each trigger with a list of triggerable actions to perform. As the single point of entry for all triggers this class will manage the disabling and enabling of triggers, as well as tracking the stack of triggers


**Author:** Gavin Palmer

**Date:** 2020-11-18
---
## Methods
### `disable(SObjectType objectType, TriggerOperation operation)` → `void`
### `enable(SObjectType objectType, TriggerOperation operation)` → `void`
### `run(List<Triggerable> actions)` → `void`
### `run()` → `void`
---
