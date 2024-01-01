trigger AccountConOppTrigger on Account (after insert) {
	
    AccountConOppTriggerHandler.createContactAndOpp(trigger.new);
    AccountConOppTriggerHandler.createContactwithClientContact(trigger.new);
}