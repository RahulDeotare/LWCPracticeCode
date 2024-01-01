trigger AccountRatingTrigger on Account (before insert) {
    
    if(trigger.isInsert && trigger.isBefore){
        AccountRatingTriggerHandler.updateRating(trigger.new);
    }
}