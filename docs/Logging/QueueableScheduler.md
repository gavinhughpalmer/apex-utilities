---
layout: default
---
# QueueableScheduler class

This class will schedule a queuebale class to run by injecting the queuebale into the class Usage: QueueableScheduler scheduler = new QueueableScheduler(new MyQueueable()); scheduler.scheduleDaily();


**Author:** Gavin Palmer

**Date:** 2019-03-11
---
## Constructors
### `QueueableScheduler(LoggedQueueable queueableToRun)`
---
## Methods
### `execute()` → `void`
### `getRunningQueueableId()` → `Id`
---
