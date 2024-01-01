public class CaseNumberPopulateHandler {

    public static void afterInsertPopulateCaseNumb(List<Case> csList){
        List<Account> accList=new List<Account>();
        for(Case cs:csList){
            if(cs.AccountId!=null){
            Account objAcc=new Account();
            objAcc.Id= cs.AccountId;
            objAcc.Latest_Case_Number__c=cs.CaseNumber;
            accList.add(objAcc);
           }
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
}