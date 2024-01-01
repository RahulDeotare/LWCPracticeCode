trigger AVSTrigger on EFT_Transaction__c (after insert) {
    List<Case> caseList=new List<Case>();
    
    Group avsId=[select id,Name from Group where Name='AVS Queue'];//to take AVS queue record
    ID recId=[select id,Name from RecordType where Name='Assignment'].ID;
    ID salesID=[Select ID,Name, Account__c,Contact__c,Bill_To_Customer__c,Status__c from SalesHeader__c 
                where Status__c='Open' LIMIT 1].Id;
    String accName=[Select ID,Name, Account__c,Contact__c,Bill_To_Customer__c,Status__c,Account__r.Name from SalesHeader__c 
                    where Status__c='Open' LIMIT 1].Account__r.Name;
    String conName=[Select ID,Name, Account__c,Contact__c,Bill_To_Customer__c,Status__c,Contact__r.Name from SalesHeader__c 
                    where Status__c='Open' LIMIT 1].Contact__r.Name;
    String orderName=[Select ID,Sales__c, Account__c,Contact__c,Bill_To_Customer__c,Status__c from SalesHeader__c 
                      where Status__c='Open' LIMIT 1].Sales__c;
    String statusSalesHeader=[Select ID,Sales__c, Account__c,Contact__c,Bill_To_Customer__c,Status__c from SalesHeader__c 
                      where Status__c='Open' LIMIT 1].Status__c;
   
    
    
    
    for(EFT_Transaction__c eft : trigger.New) {  
       if(eft.Method_Name__c =='Credit Card address Verify' && eft.Transaction_Status__c =='Declined' && String.isNotBlank(statusSalesHeader)) {
           system.debug('We are here');
           
           
           Case objcase = new case();
           objcase.Status='New';
           system.debug('Status on Case'+objcase.Status);
           objcase.Origin = 'Internal';
           system.debug('Origin on Case'+objcase.Origin);
           objcase.Account_Name__c = accName;
           system.debug('Account ID on Case'+objcase.Account_Name__c);
           objcase.Contact_Name__c = conName;
           system.debug('Contact ID on Case'+objcase.Contact_Name__c);
           objcase.RecordTypeID= recId;
           
           objcase.OwnerId=avsId.Id;
           //system.debug('OwnerId on Case'+objcase.OwnerId);
           objcase.Reason='Address Did Not Verify';
           //system.debug('Reason on Case'+objcase.Reason);
           objcase.Priority='High';
           //system.debug('Priority on Case'+objcase.Priority);
           
           objcase.Type='Address Did Not Verify';
           //system.debug('Type on Case'+objcase.Type);
           objcase.Subject=accName+ '   ' + objcase.Type;
           //system.debug('Subject on Case'+objcase.Subject);
           objcase.Open_Sales_Order__c=orderName;
           //system.debug('Open_Sales_Order__c on Case'+objcase.Open_Sales_Order__c);
           objcase.Transaction_Status__c=eft.Transaction_Status__c;
           //system.debug('Transaction_Status__c on Case'+objcase.Transaction_Status__c);
           objcase.Sales_Order_Number__c=salesID;
           //system.debug('Sales_Order_Number__c on Case'+objcase.Sales_Order_Number__c);
           objcase.Order_Date__c=eft.Transaction_Date__c;
           //system.debug('Order_Date__c on Case'+objcase.Order_Date__c);
           
           caseList.add(objcase);
           }
        
        system.debug(caseList);
    }
    if(!caseList.isEmpty())
    Database.insert(caseList,false);
}