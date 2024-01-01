public with sharing class OpportunityApplyDiscountController 
{
	public Decimal DiscountPercentage { get; set; } 
	
	private ApexPages.StandardController standardController = null;
	
	private ApexPages.StandardSetController standardSetController = null; 
	
	public OpportunityApplyDiscountController(ApexPages.StandardController controller)
	{
		standardController = controller;
	}
	
	public OpportunityApplyDiscountController(ApexPages.StandardSetController controller)
	{
		standardSetController = controller;
	}
	
	public PageReference applyDiscount()
	{
		try
		{
			// Apply discount entered to the current Opportunity
			OpportunitiesService.applyDiscounts(
				new Set<Id> { standardController.getId() }, DiscountPercentage);
		}
		catch (Exception e)
		{
			ApexPages.addMessages(e);
		}		
		
		return ApexPages.hasMessages() ? null : standardController.view();				
	}

	public PageReference applyDiscounts()
	{
		try
		{
			// Selected Opportunity Id's
			Set<Id> selectedOpportunityIds =
				new Map<Id, SObject>(standardSetController.getSelected()).keySet();
			
			// Apply discount entered to the selected Opportunities
			OpportunitiesService.applyDiscounts(
					selectedOpportunityIds, DiscountPercentage);
			
			// Confirm submission
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.INFO, 'Opportunities updated.'));
		}
		catch (Exception e)
		{
			ApexPages.addMessages(e);
		}		
		
		return null;				
	}
}