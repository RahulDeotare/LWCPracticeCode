public class LeadLogs {
    public static void myRecords(){
        List<Lead> leadList=new List<Lead>();
        for(Integer i=0;i<=2;i++){
            Lead objLead1;
            Lead objLead2;
            objLead1=new Lead(FirstName='Rahul'+i,LastName='MyError'+i,Company='123',Status='Closed - Converted');
            objLead2=new Lead(FirstName='Error'+i,LastName='Big'+i,Status='Closed - Converted');
            
            leadList.add(objLead1);
            leadList.add(objLead2);
        }
                    if(!leadList.isEmpty()){
                        
                        Database.SaveResult[] srList = Database.insert(leadList, false);
                        
                        for (Database.SaveResult sr : srList) {
                            system.debug('List received  '+sr);
                            if (sr.isSuccess()) {
                                // Operation was successful, so get the ID of the record that was processed
                                System.debug('Successfully inserted Lead. Lead ID: ' + sr.getId());
                            }
                            else {
                                // Operation failed, so get all errors 
                                	List<Log__c> logList=new List<Log__c>();               
                                for(Database.Error err : sr.getErrors()) {
                                    
                                    Log__c objLog=new Log__c();
                                    objLog.Error__c=err.getMessage();
                                    objLog.Error_Code__c=string.valueOf(err.getStatusCode());
                                    logList.add(objLog);
                                    System.debug('The following error has occurred.');                    
                                    System.debug(err.getStatusCode() + ': ' + err.getMessage());
                                    System.debug('Lead fields that affected this error: ' + err.getFields());
                                    
                    }
                                insert logList;
                }
            }
        }
    }
}