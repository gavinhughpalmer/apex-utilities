/**
 * @author Gavin Palmer
 * @description This class can be used to build custom HTTP responses to be used in test classes
 * Usage:
 * Test.setMock(
 *     HttpCalloutMock.class,
 *     MockHttpResponse.builder().statusCode(200).body('{"field":"value"}').cookie('aCookie')
 * );
 *
 * @date 2019-05-09
 **/
public class MockHttpResponse implements HttpCalloutMock {
    private final List<Mock> mocks = new List<Mock>();

    public static MockHttpResponse builder() {
        MockHttpResponse mockResponse = new MockHttpResponse();
        mockResponse.next();
        return mockResponse;
    }

    public MockHttpResponse next() {
        mocks.add(new Mock());
        return this;
    }

    public MockHttpResponse statusCode(Integer statusCode) {
        getCurrentResponse().setStatusCode(statusCode);
        return this;
    }

    public MockHttpResponse status(String status) {
        getCurrentResponse().setStatus(status);
        return this;
    }

    public MockHttpResponse cookie(String cookie) {
        getCurrentResponse().setHeader('Set-Cookie', cookie);
        return this;
    }

    public MockHttpResponse contentType(String contentType) {
        getCurrentResponse().setHeader('Content-Type', contentType);
        return this;
    }

    public MockHttpResponse body(String body) {
        getCurrentResponse().setBody(body);
        return this;
    }

    public HttpResponse respond(HttpRequest req) {
        HttpResponse response = getCurrentResponse();
        mocks.remove(mocks.size() - 1);
        return response;
    }

    private HttpResponse getCurrentResponse() {
        return mocks[mocks.size() - 1].response;
    }

    private class Mock {
        private HttpResponse response;

        public Mock() {
            response = new HttpResponse();
            response.setStatusCode(200);
        }
    }
}
