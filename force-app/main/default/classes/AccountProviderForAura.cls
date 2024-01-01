public class AccountProviderForAura {
	@AuraEnabled
    public static String createNewAccount(String accountName){
        Account objAcc=new Account(Name=accountName);
        	Database.insert(objAcc, false);
    			return accountName+'Account Created Successfully!';
    }
    @AuraEnabled
    public static String createNewAccountMulti(Account objAcc){
        try{
            insert objAcc;
            System.debug('Hi I am Ok');
        }
        catch(Exception ex){
            System.debug('There is problem'+ex);
        }
        return 'Record inserted successfully';
    }
    @AuraEnabled
    public static Account getAccountData(Account objAcc){
        return ([Select Id,Name,Type,SLA__c,Rating from Account where Name =:objAcc.Name LIMIT 1]);
    }
    @AuraEnabled
    public static List<Account> selectedAccountTypeTableMethod(Account objAcc){
        return ([SELECT AccountNumber,AccountSource,Active__c,AnnualRevenue,BillingAddress,BillingCity,BillingCountry,BillingGeocodeAccuracy,BillingLatitude,BillingLongitude,BillingPostalCode,BillingState,BillingStreet FROM Account where Type=:objAcc.Type]);
}
    @AuraEnabled
    public static Account tableAccountContactData(Account objAcc){
        return ([Select Id,Name,Type,SLA__c,Rating from Account where Name =:objAcc.Name LIMIT 1]);
    }
    @AuraEnabled
    public static List<Contact> getContactRecords(String AccountID){
        List<Contact> conList=new List<Contact>();
        if(AccountID!=null){
            conList=[Select Id,FirstName,LastName,LeadSource from Contact where AccountId=:AccountID];
        }
        return conList;
    }
    @AuraEnabled
    public static String deleteSelectedContactRecords(List<Contact> conDeleteList){
        if(!conDeleteList.isEmpty()){
        delete conDeleteList;
            return 'Record has been deleted successfully';
            }
        else{
            return 'records cannot be deleted';
        }
    }
}