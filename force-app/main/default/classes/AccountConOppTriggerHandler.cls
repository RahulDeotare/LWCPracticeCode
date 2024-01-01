public class AccountConOppTriggerHandler {
	
    public static void createContactAndOpp(List<Account> accList){
        List<Contact> conList=new List<Contact>();
        List<Opportunity> oppList=new List<Opportunity>();
        for(Account objAcc:accList){
            if(objAcc.New_Contact__c){
                Contact objCon=new Contact();
                objCon.LastName='Test  '+objAcc.Name;
                objCon.LastName='New  '+objAcc.Name;
                objCon.AccountId=objAcc.Id;
                conList.add(objCon);
            }
            if(objAcc.New_Opportunity__c){
                Opportunity opp=new Opportunity();
                opp.Name='New Test  '+objAcc.Name;
                opp.StageName='Prospecting';
                opp.CloseDate=system.today();
                opp.AccountId=objAcc.Id;
                oppList.add(opp);
            }
        }
        if(!conList.isEmpty()){
        insert conList;
            }
        if(!oppList.isEmpty()){
        insert oppList;
            }
    }
    public static void createContactwithClientContact(List<Account> accList){
        List<Contact> conList=new List<Contact>();
        Set<ID> accIdSet=new Set<ID>();
        for(Account objAcc:accList){
            Contact con=new Contact();
            con.LastName=objAcc.Name;
            con.AccountId=objAcc.Id;
            conList.add(con);
            accIdSet.add(con.AccountId);
        }
        if(conList.size()>0){
            insert conList;
        }
            Map<ID,Account> accMap=new Map<ID,Account>();
            for(Account acc:[Select ID,Client_Contact__c from Account where ID IN:accIdSet]){
                accMap.put(acc.Id,acc);
            }
        List<Account> accUpdateList=new List<Account>();
        for(Contact objCon:conList){
            if(accMap.containsKey(objCon.AccountId)){
                Account aobj=accMap.get(objCon.AccountId);
                aobj.Client_Contact__c=objCon.Id;
                accUpdateList.add(aobj);
            }
        }
        if(accUpdateList.size()>0){
            Database.update(accUpdateList, false);
        }
    }
}