trigger AccountTrigger on Account (After insert) {
    
    if(ConeHandler.runOnce()){
         List<Account> accList= new List<Account>();
        for(Account record: trigger.new){
            accList.add(record.clone(false,false,false,false));
        }
        if(accList.size()>0){
            insert accList;
        }
    }
}