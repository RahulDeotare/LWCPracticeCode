trigger TestTrigger on Contact (before insert) {
    
    List<String> contactEmaildomains = new List<String>();
        for(Contact objcontact:Trigger.new){
            
            contactEmaildomains.add('%'+objcontact.Domain__c+'%');
        }
            System.debug(contactEmaildomains);
            List<Account> accList = [SELECT Id, Domain__c FROM Account WHERE Domain__c LIKE :contactEmaildomains];
            System.debug(accList);
    
            Map<String, Id> domains = new Map<String, Id>();
            for(Account record: accList) {
                for(String dom:record.Domain__c.Split(','))
                    domains.put(dom, record.Id);
            }
            for(Contact record: Trigger.new) {
                if(domains.get(record.Domain__c) != null) {
                    record.AccountId = domains.get(record.Domain__c);
                } 
        }
}