@isTest
public class TestOpportunityPricing {
	
    @isTest
    public static void testOpportunityVF(){
        Date dt=Date.parse('06/06/1991');
        Opportunity objOpp=new Opportunity(Name='GujratTitans',StageName='Prospecting',CloseDate=dt,Pricing_Type__c=
                                           'Consumer',Type='New Customer');
        //insert objOpp;
        Pricebook2 objPrice=new Pricebook2(Name='Consumer');
        insert objPrice;
        ApexPages.StandardController controller=new ApexPages.StandardController(objOpp);
        OpportunityPricingTypeVF_CX objPriceController=new OpportunityPricingTypeVF_CX(controller);
        objPriceController.saveRecords();
        String pricebook=[Select Id,Name,Pricebook2Id from Opportunity where ID=:objOpp.Id].Pricebook2Id;
        system.debug('#Pricebook information  '+pricebook);
        system.assertEquals(objOpp.Pricebook2Id, pricebook);
    }
}