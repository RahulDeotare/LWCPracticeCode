public class OpportunityPricingTypeVF_CX {
	
    public Opportunity objOpp;
    
    public OpportunityPricingTypeVF_CX(ApexPages.StandardController controller){
        objOpp=(Opportunity) controller.getRecord();
    }
    public PageReference saveRecords(){
        if(String.isNotBlank(objOpp.Pricing_Type__c)){
                Pricebook2 pricebook=[Select Id,Name from Pricebook2 where Name=:objOpp.Pricing_Type__c];
            system.debug('#pricebook value'+pricebook);
            objOpp.Pricebook2Id=pricebook.Id;
            system.debug('#opportunity pricebook field value'+objOpp.Pricebook2Id);
            insert objOpp;
        }
        PageReference prpage=new PageReference('/'+objOpp.Id);
        prpage.setRedirect(true);
        return prpage;
    }
}