---
layout: default
---
# LoggedSchedulable class

This wraps the standard Schedulable interfaece and allows the logs to be written without developers needing to write the logs specifically


**Author:** Gavin Palmer

**Date:** 2019-03-11
---
## Properties

### `DEFAULT_JOB_NAME` → `String`

---
## Methods
### `execute(SchedulableContext context)` → `void`
### `schedule(String cronExpression)` → `Id`
### `scheduleDaily()` → `Id`
### `setJobName(String jobName)` → `void`
---
