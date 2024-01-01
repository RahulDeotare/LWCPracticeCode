public class AccountTriggerNovemberHandler {

    public static void updateRelatedContacts(List<Account> accList, Map<Id,Account> oldAccMap){
        List<Contact> conList=new List<Contact>();
        Map<Id,Account> accMap=new Map<Id,Account>();
        for(Account acc:accList){
            if(acc.Phone!=null && acc.Phone!=oldAccMap.get(acc.Id).Phone){
                accMap.put(acc.Id,acc);
            }
        }
        if(accMap.size()>0){
            for(Contact con:[Select Id,HomePhone,AccountId from Contact where AccountId IN:accMap.keyset()]){
                if(accMap.containsKey(con.AccountId)){
                    con.HomePhone=accMap.get(con.AccountId).Phone;
                    conList.add(con);
                }
            }
        }
        if(conList.size()>0){
            update conList;
        }
    }
}