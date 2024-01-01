public with sharing class AccountProviderLWC {
    
    @AuraEnabled
    public static void createAccount(String accName,  String accPhone){
        try {
                    Account objAcc=new Account(Name=accName, Phone=accPhone);
                    insert objAcc;
                
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static string createNewAccount(Account objAcc){
        try { 
                    insert objAcc;
                    return 'Account Created Successfully!!';
                
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static Account readAccountMethod(Account objAcc){
        try {
                return([select Id,Name,Rating,Type,SLA__c from Account where Name=:objAcc.Name]);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Account> getAllAccounts(){
        try {
            return([Select Id,Name,Rating,Type,SLA__c from Account]);
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Account> getAllAccountsDataTableMethod(){
        try {
            return [Select Id,Name,Rating,Type,SLA__c from Account ORDER BY CreatedDate DESC LIMIT 5] ;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static string updateAccountList(List<Account> accList){
        try {
            Database.update(accList, false);
            return 'Records updated Successfully';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }

    @AuraEnabled
    public static String editAccountMethod(Account objAccount){
        try {
                Database.update(objAccount, false);
                return 'Account Updated Successfuly!!';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static string deleteAccountMethod(Account objA){
        try {
            delete objA;
            return 'Account record deleted successfully';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Account> deleteAccountListMethod(List<Id> accIdSet){
        try {
            Database.delete(accIdSet,false);
            return AccountProviderLWC.getAllAccountsDataTableMethod();
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled
    public static List<Account> saveAccounts(List<Account> lstAccs){
        try {
            insert lstAccs;
            return lstAccs;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    @AuraEnabled(cacheable=true)
    public static List<Account> filterAccountType(string type){
            return [select Id,Name,Type from Account where Type=:type];
    }
    //custom lookup lwc
    @AuraEnabled(cacheable=true)
    public static List<Account> getCustomLookupAccount (String actName){
        List<Account> accLookupList =  new List<Account>();
        if(actName != ''){
            String accountName = '%' + actName + '%';
            accLookupList = [Select Id, Name From Account Where Name like:accountName];
            return accLookupList;
        }
        return accLookupList;
    }   
}