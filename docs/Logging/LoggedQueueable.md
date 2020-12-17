---
layout: default
---
# LoggedQueueable class

This class wraps the queueable interface with the logging framework so that developers do not have to worry about writing the logs after the Logger methods are called.


**Author:** Gavin Palmer

**Date:** 2019-02-06
---
## Methods
### `enqueue()` → `Id`

The enqueue method will set the queueable off for execution following the transaction

### `execute(QueueableContext context)` → `void`

This is the implementation of the Queueable method, this does not need to be extended. It adds the logging and general exception handling around the Queueable interface

---
