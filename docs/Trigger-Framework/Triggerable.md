---
layout: default
---
# Triggerable class

This interface will be implemented by any action that is used in a trigger, this allows each trigger to loop over the set of records once to complete all the actions in the system. intention is that any initial setup actions can be performed in the constructor (ie set up some required data), then the register will determine if the new record should have any actions performed and add to a private list, then finally the performAction will run any dml / soql, essentially the bulk of the logic


**Author:** Gavin Palmer

**Date:** 2018-06-28
---
## Methods
### `performAction()` → `void`
### `register(SObjectTriggerWrapper wrappedSObject)` → `void`
---
