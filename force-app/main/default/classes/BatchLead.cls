global class BatchLead implements Database.Batchable<sObject> {
	
    global Database.QueryLocator start(Database.BatchableContext BC){
        String query='SELECT Name,Email,Status,Company FROM Lead';
        return Database.getQueryLocator(query);
    }
    global void execute(Database.BatchableContext BC, List<Lead> leadList){
        Set<String> emailSet=new Set<String>();
        for(Lead objLead:leadList){
            if(string.isNotBlank(objLead.Email)){
                emailSet.add(objLead.Email);
            }
        }
               Map<String,Lead> leadMap=new Map<String,Lead>();
        if(!emailSet.isEmpty()){
        for(Lead objLead:[SELECT Name,Email,Status,Company FROM Lead where Email IN:emailSet]){
            leadMap.put(objLead.Email, objLead);
            }
    	}
        if(!leadMap.isEmpty()){
            for(Lead objLead:leadList){
                if(leadMap.containsKey(objLead.Email)){
                    objLead.addError(objLead.Email+'  This lead already exists in database');
                }
            }
        }
    }
    global void finish(Database.BatchableContext BC){
        
    }

}