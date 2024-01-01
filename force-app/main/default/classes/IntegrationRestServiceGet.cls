@RestResource(urlMapping='/getAccount/*')
global class IntegrationRestServiceGet {

    @HttpGet
    global static string getAccount(){
        
        RestRequest req = RestContext.request;
        Map<string, string> urlMap = req.params;
        System.JSONGenerator jp = JSON.createGenerator(true);
        jp.writeStartObject();
        
            List<Account> accList = [SELECT Name, Rating, Industry FROM Account WHERE Rating =: urlMap.get('rating') AND Rating!=null];

            for(Account acc : accList){
                jp.writeStringField('Name', acc.Name);
                jp.writeStringField('Rating', acc.Rating);
                if(acc.Industry != null){
                    jp.writeStringField('Industry', acc.Industry);
                }
                

            }
            jp.writeEndObject();
            String jsonStr = jp.getAsString();
            System.debug('jsonStr is ' + jsonStr);
            return jsonStr;
        
    }
    @HttpGet
    global static string getAccountList(){
        Http h = new Http();
        HttpRequest req = new HttpRequest();
        req.setEndpoint('https://rahul.deotare/study');
        req.setMethod('GET');
        HttpResponse res = h.send(req);
        return res.getBody();
        Account acc = [SELECT Id, Name FROM Account];
        return acc.Name;
        System.JSONParser jp = JSON.createParser(res.getBody());
        while(jp.nextToken()!=null){
            
            System.debug('Name is ' + jp.getText());
        }
    }
}