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

This is the implementation of the Schedulable method, this does not need to be extended. It adds the logging and general exception handling around the Schedulable interface

### `schedule(String cronExpression)` → `Id`

This method allows the class to be scheduled, based on the cron expression

### `scheduleDaily()` → `Id`

this method will schedule the class on a daily basis at 00:00

### `setJobName(String jobName)` → `void`

This method will set the job name to be used when schedule is called, if not set the default will be used

---
