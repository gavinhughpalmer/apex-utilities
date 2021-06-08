---
layout: default
---
# StateCountryCodeMapper class

This class is used to get around a salesforce bug where the state/country field is not updated in a trigger, rather the state code is. Other code in the org has been written to rely on the state/country field rather than the code


**Author:** Gavin Palmer

**Date:** 2020-02-11
---
## Methods
### `register(SObjectTriggerWrapper wrappedSObject)` → `void`
---
