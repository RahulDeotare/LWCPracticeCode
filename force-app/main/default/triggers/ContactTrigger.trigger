trigger ContactTrigger on Contact (before insert,before update,after undelete){
    Set<String> conEmailSet=new Set<String>();
    Set<String> conMobSet=new Set<String>();
    
    for(Contact objContact:trigger.new){
        if(String.isNotBlank(objContact.Email) || objContact.HomePhone!=null){
            conEmailSet.add(objContact.Email);
            conMobSet.add(objContact.HomePhone);
        }
    }
    Map<String,Contact> conMap=new Map<String,Contact>();
    
        if(!conEmailSet.isEmpty() || !conMobSet.isEmpty()){
            for(Contact objContact: [Select Name,Email,HomePhone from Contact where Email IN:conEmailSet OR
                                        HomePhone IN:conMobSet]){
                conMap.put(objContact.Email, objContact);
                conMap.put(objContact.HomePhone, objContact);
            }
        }
        if(!conMap.isEmpty()){
            for(Contact objContact:trigger.new){
                if(conMap.containsKey(objContact.Email)){
                    objContact.Email.addError('This Email Already Exists');
                }
                    if(conMap.containsKey(objContact.HomePhone)){
                    objContact.HomePhone.addError('This Phone Number Already Exists');
                }
                }
            }
        }