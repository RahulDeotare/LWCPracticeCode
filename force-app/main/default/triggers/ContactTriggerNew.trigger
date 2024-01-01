trigger ContactTriggerNew on Contact (after insert,after update) {
	
    if(trigger.isAfter && trigger.isInsert){
        ContactTriggerNewHandler.afterInsertUpdateMethod(trigger.new);
    }
   /* if(trigger.isAfter && trigger.isUpdate){
        ContactTriggerNewHandler.afterInsertUpdateMethod(trigger.new,trigger.oldMap);
    }*/
}