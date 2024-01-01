public class TrialAssignment_CX {
     public Account objAcc {get; set;}
    public TrialAssignment_CX(ApexPages.StandardController controller) {
        String accID =  ApexPages.currentPage().getParameters().get('Id');
         //String accName=  ApexPages.currentPage().getParameters().get('Name');  
         //System.debug('#Parameter ID = '+accID+ 'and Name = '+accName);
         
          if(accID!=null || String.isNotBlank(accID) || accId!=''){              
            objAcc=[select id, Name,Type,Rating,SLA__c, (select id,Title,FileType,ExternalDataSourceType,ContentUrl from CombinedAttachments) from Account where Id=: accID ];
    }
   }
   public  PageReference Save(){
         PageReference objPageRefer;
            update objAcc;
            objPageRefer = new PageReference('/'+objAcc.ID);
            return objPageRefer;
        }
   }