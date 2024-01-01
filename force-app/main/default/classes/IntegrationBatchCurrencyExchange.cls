global class IntegrationBatchCurrencyExchange Implements Database.Batchable<sObject>, Database.allowsCallouts{
    global Database.QueryLocator start(Database.BatchableContext BC){
        return Database.getQueryLocator('Select Id, Amount,INR_Amount__c from Opportunity');
    }
    global void execute(Database.BatchableContext BC, List<Opportunity> scope){
        
        String endpoint = 'http://api.currencylayer.com/live?access_key=4b175a33feb3f6fd19455e51e03b9649&source=USD&currencies=INR&format=1';

        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        HttpResponse response = h.send(request);

        Decimal amt;
        System.JSONParser jp= JSON.createParser(response.getBody());
        while(jp.nextToken()!=null){
            if(jp.getText()=='USDINR'){
                jp.nextToken();
                amt = (Decimal)jp.getDecimalValue();
            }
        }
        system.debug(amt);
        for(Opportunity eachOpp : scope){
            if(eachOpp.Amount != null){
                eachOpp.INR_Amount__c = 'Rs. '+(eachOpp.Amount * amt);
            }
        }
        update scope;
    }
    global void finish(Database.BatchableContext BC){
    }
    
}