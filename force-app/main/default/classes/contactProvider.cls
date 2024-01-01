public with sharing class contactProvider {
    public contactProvider() {

    }
    @AuraEnabled
    public static List<Contact> saveContacts(List<Contact> conList){
        try {
            insert conList;
            return conList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Contact>  getAllContacts(){
        try {
            List<Contact> conList =[Select Id,LastName,LeadSource,
                                Level__c,Account.Name,Phone FROM Contact limit 10];
        return conList;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}