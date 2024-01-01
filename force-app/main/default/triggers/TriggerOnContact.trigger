trigger TriggerOnContact on Contact (before insert,before update,after undelete) {
    
    if(trigger.isBefore && trigger.isInsert){
        ContactDuplicateHandler.beforeInsert(trigger.new);
        
    }
    if(trigger.isBefore && trigger.isUpdate){
        ContactDuplicateHandler.beforeUpdate(trigger.new);
        
    }
    if(trigger.isAfter && trigger.isUndelete){
        ContactDuplicateHandler.afterUndelete(trigger.new);
        
    }
}