trigger OpportunityTrigger on Opportunity (after insert,after update) {
	
    if(trigger.isAfter){
        if(trigger.isUpdate){
            OpportunityTriggerHandler.updateOpportunity(trigger.new);
        }
        if(trigger.isInsert){
            //OpportunityTriggerHandler.updateAccountLatestOppAmt(trigger.new);
            //OpportunityTriggerHandler.updateOpportunity(trigger.new);
        }
    
        }
}