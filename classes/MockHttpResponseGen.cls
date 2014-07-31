public class MockHttpResponseGen implements HttpCalloutMock {
    public HTTPResponse respond(HTTPRequest req) {
        System.assert(req.getEndpoint().contains('https://api.twilio.com/2010-04-01/Accounts/'), 'Wrong endpoint.');
        System.assertEquals('POST', req.getMethod(), 'Wrong request method.');
        String body = req.getBody();
        System.assert(body.contains('To'), 'Body did not contain a To number');
        System.assert(body.contains('From'), 'Body did not contain a From number');
        System.assert(body.contains('Body'), 'Body did not contain a Body element');

        HttpResponse res = new HttpResponse();
        res.setHeader('Content-Type', 'text/xml');
        res.setStatusCode(200);
        return res;
    }
}