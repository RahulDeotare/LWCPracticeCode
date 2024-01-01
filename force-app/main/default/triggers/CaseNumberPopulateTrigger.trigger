trigger CaseNumberPopulateTrigger on Case (after insert) {

    if(trigger.isAfter && trigger.isInsert){
        CaseNumberPopulateHandler.afterInsertPopulateCaseNumb(trigger.new);
    }
}