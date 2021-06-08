---
layout: default
---
# Profiler class

This is a generic profiling class, which allows implementations to report on certain limits within the environment.


**Author:** Gavin Palmer

**Date:** 2020-10-08
---
## Constructors
### `Profiler()`
---
## Methods
### `generateProfilingReport()` → `String`

This method is used to generate the report, each line that is breeching the warning will be marked as Warning

### `isBreachingWarning()` → `Boolean`
### `refreshProfiling()` → `void`

This method should be implemented in the base classes to refresh the profiling limits, this will be called from the constructor and then at any point before this is planned to execute

---
