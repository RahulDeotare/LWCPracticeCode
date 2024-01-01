trigger AccountNewTrigger on Account (before insert) {
    
    if(trigger.isInsert && trigger.isBefore){
        AccountNewTriggerHandler.insertValues(trigger.new);
    }
}