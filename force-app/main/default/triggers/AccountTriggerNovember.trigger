trigger AccountTriggerNovember on Account (after update) {

    if(trigger.isAfter){
        if(trigger.isUpdate){
            AccountTriggerNovemberHandler.updateRelatedContacts(trigger.new,trigger.oldMap);
        }
    }
}