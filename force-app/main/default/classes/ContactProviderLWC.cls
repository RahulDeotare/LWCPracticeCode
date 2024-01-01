public with sharing class ContactProviderLWC {
    public ContactProviderLWC() {

    }
    @AuraEnabled
    public static Contact searchContactMethod(Contact objCon){
        try {
                return([select Id, FirstName,LastName,Educational_Background__c,Gender__c from Contact where Name=:objCon.Name]);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}