public with sharing class contactProviderNov {
    
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContacts(string accId){
        try {
            return [
                Select AccountId,Id,FirstName,LastName
                from Contact
                where AccountId=:accId
                WITH SECURITY_ENFORCED
            ];
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> getAccountList(string accId) {
        List<Account> dataAcc=[Select Id, Name,(Select Id,FirstName,LastName,Email,Phone from Contacts) from Account where Id=:accId];
        system.debug('data from apex  '+dataAcc);
        return dataAcc ;
    }
    @AuraEnabled(cacheable=true)
    public static List<Contact> getContactsRecord(String accountId){
        return [Select Id,FirstName,LastName,Email,Phone,AccountId,Account.Name from Contact where AccountId=:accountId];
         
    }  
    @AuraEnabled(cacheable=true)
    public static List<Contact> getAllContacts(){
        return [Select Id,FirstName,LastName,Email,Phone,AccountId from Contact LIMIT 10];
         
    } 
    @AuraEnabled
    public static Id deleteContactMethod(Contact conId){
        try {
            delete conId;
            return 'Contact record deleted successfully';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static string cloneMethod(String contactId){
        
        Contact con=[Select Id,FirstName,LastName,Email,Phone from Contact where Id=:contactId];

        system.debug('## con data'+con);

        Contact conData  = con.clone(false, false, false, false);
        insert conData;
        system.debug('###Contact Data'+conData.Id);
        return 'Record cloned successfully'+conData.Id;
    } 
}