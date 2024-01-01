public class AssignmentVFPage_CX {
    
    public List<Account> accList {get; set;}
    public Account objAcc {get; set;}
    
    public AssignmentVFPage_CX(ApexPages.StandardController controller) {
        accList=[Select Name,Type,SLA__c,Rating,(select id,Name from Account.attachments) from Account LIMIT 10];
        objAcc= (Account) controller.getRecord();
        
    }
    public  PageReference Save(){
         PageReference objPageRefer;
            insert objAcc;
            objPageRefer = new PageReference('/'+objAcc.ID);
            return objPageRefer;
        }
    }