---
layout: default
---
# MockHttpResponse class

This class can be used to build custom HTTP responses to be used in test classes Usage: Test.setMock( HttpCalloutMock.class, MockHttpResponse.builder().statusCode(200).body('{"field":"value"}').cookie('aCookie') );


**Author:** Gavin Palmer

**Date:** 2019-05-09
---
## Methods
### `Mock()` → `public`
### `body(String body)` → `MockHttpResponse`
### `builder()` → `MockHttpResponse`
### `contentType(String contentType)` → `MockHttpResponse`
### `cookie(String cookie)` → `MockHttpResponse`
### `next()` → `MockHttpResponse`
### `respond(HttpRequest req)` → `HttpResponse`
### `status(String status)` → `MockHttpResponse`
### `statusCode(Integer statusCode)` → `MockHttpResponse`
---
