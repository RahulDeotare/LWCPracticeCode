public with sharing class IntegrationLeadToSMSThree {
    
    @future(callout=true)
    public static void leadToSmsSend(Set<Id> setofIds){
        List<Lead> l = [SELECT Id, Name, MobilePhone FROM Lead WHERE MobilePhone != null AND ID IN:setofIds];

        for(Lead l1 : l){
            String endpt='https://api.textlocal.in/send/?';
        endpt = endpt+'apikey=NDEzMjQ1NGY2Nzc5Njc1OTQ1NDU0ODZjNTM0ODM2NTY=';
        endpt = endpt+'&numbers='+'91'+l1.MobilePhone;
        endpt = endpt+'&sender=TXTLCL';
        endpt = endpt+'&message='+'Welcome! '+l1.Name+' to Salesforce.';

        Http h = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpt);
        request.setMethod('GET');
        HttpResponse response = h.send(request);
        }
        
    }
}