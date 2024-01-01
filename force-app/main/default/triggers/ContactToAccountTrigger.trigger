trigger ContactToAccountTrigger on Contact(before insert){
    
    if(trigger.isBefore && trigger.isInsert){
    ContactToAccountHandler.beforeInsert(trigger.new);
        }
}