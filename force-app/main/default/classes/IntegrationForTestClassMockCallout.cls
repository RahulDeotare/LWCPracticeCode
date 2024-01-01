global class IntegrationForTestClassMockCallout Implements HttpCalloutMock {
    
    global HTTPResponse respond(HTTPRequest req) {
        
        String endpoint = req.getEndpoint();
        String method = req.getMethod();
        system.assertEquals('https://rahul.deotare/study',endpoint);
        system.assertEquals('GET',method);

        HttpResponse res = new HttpResponse();
        res.setBody('Rahul');
        res.setStatusCode(200);
        return res;
    }
    
}