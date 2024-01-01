@RestResource(urlMapping='/createAccount/*')
global class IntegrationRestService {
    
    @HttpPost
    global static string createAccountJson(string name,string phone,string industry){
        
        System.JSONGenerator jp = JSON.createGenerator(true);
        jp.writeStartObject();
        
        
        try {
            Account acc = new Account();
            acc.Name = name;
            acc.Phone = phone;
            acc.Industry = industry;
            insert acc;

            jp.writeStringField('Status', 'Success');
            jp.writeStringField('AccountId', acc.Id);
            jp.writeStringField('Name', acc.Name);
        } catch (Exception e) {
            jp.writeStringField('Status', 'Failed');
            jp.writeStringField('Status', e.getMessage());
        }
        
        jp.writeEndObject();
        String jsonStr = jp.getAsString();
        System.debug('jsonStr is ' + jsonStr);
        return jsonStr;
    }

    @HttpGet
    global static string getAccount(){
        
        RestRequest req = RestContext.request;
        Map<string, string> urlMap = req.params;
        System.JSONGenerator jp = JSON.createGenerator(true);
        jp.writeStartObject();
        try{
            Account acc = new Account();
            acc.Name = urlMap.get('name');
            acc.Phone = urlMap.get('phone');
            acc.Industry = urlMap.get('industry');
            insert acc;

            jp.writeStringField('Status', 'Success');
            jp.writeStringField('AccountId', acc.Id);
            jp.writeStringField('Name', acc.Name);
        }
        catch(Exception e){
            jp.writeStringField('Status', 'Failed');
            jp.writeStringField('Status', e.getMessage());
        }
        jp.writeEndObject();
        String jsonStr = jp.getAsString();
        System.debug('jsonStr is ' + jsonStr);
        return jsonStr;
    }
}