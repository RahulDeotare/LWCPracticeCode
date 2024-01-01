public class ContactTriggerNewHandler {
	
    public static void afterInsertUpdateMethod(List<Contact> conList){
        List<Task> tskList=new List<Task>();
        for(Contact objCon:conList){
            Task ts=new Task();
                ts.Subject = 'Possible Lead - Notable marketing interaction(s) - Action Required';
                    ts.Priority = 'High';
                    ts.WhoId = objCon.Id;
            ts.OwnerId= objCon.OwnerId;
            ts.Status='Completed';
			tskList.add(ts);		            
        }
        if(tskList.size()>0){
                    Database.insert(tskList, false);                    
                }
    }
}