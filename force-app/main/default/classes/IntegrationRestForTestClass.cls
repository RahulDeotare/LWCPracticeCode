public  class IntegrationRestForTestClass {
    
    public void invoke(){
        string endpt = 'https://rahul.deotare/study';

        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpt);
        request.setMethod('GET');
        HttpResponse response = h.send(request);
        string responseBody = response.getBody();

        Account acc = new Account();
        acc.Name = responseBody;
        insert acc;
    } 
}