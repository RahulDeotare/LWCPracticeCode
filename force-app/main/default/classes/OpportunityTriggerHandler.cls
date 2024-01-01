public class OpportunityTriggerHandler {

    public static void updateAccountLatestOppAmt(List<Opportunity> oppList){
        List<Account> accList=new List<Account>();
        for(Opportunity objOpp:oppList){
            if(objOpp.AccountId !=null && objOpp.Amount!=null){
            Account objAcc=new Account();
            objAcc.Id=objOpp.AccountId;
            objAcc.Latest_Opportunity_Amount__c=objOpp.Amount;
            accList.add(objAcc);
           }
        }
        if(!accList.isEmpty()){
            update accList;
        }
    }
    public static void updateOpportunity(List<Opportunity> oppList){
        
        Set<Id> setId = new Set<Id>(); 
        Map<Id, Decimal> accmap = new Map<Id, Decimal>();
        Decimal mydecval = 0;
        
        for(Opportunity oppObj : oppList){
            setId.add(oppObj.AccountId);
            system.debug('##Set Data '+setId);
        }
        //system.debug('setId ' + setId);
        List<AggregateResult> agrObj =[SELECT AccountId, SUM(Amount) totalAmount FROM Opportunity WHERE AccountId=:setId GROUP BY AccountId];
        system.debug('##aggregate result '+agrObj);
        for(Opportunity opt:oppList){
            
            for(AggregateResult agr:agrObj){
                mydecval = (Decimal)agr.get('totalAmount');
                system.debug('##value '+mydecval);
                accmap.put((Id)agr.get('AccountId') ,(Decimal)agr.get('totalAmount'));
                Account accItem = new Account(); 
                accItem.Id=(Id)agr.get('AccountId'); 
                accItem.Latest_Opportunity_Amount__c = mydecval;
                
                //system.debug('accmap44 ' + accItem);
                //system.debug('keySet111 ' + accmap.keySet());
                // system.debug('keyVal ' + accmap.values());
                
              //Campaign cpm = new Campaign();
                //cpm.Id = opt.CampaignId;
                //cpm.ActualCost=mydecval;
               // system.debug('cpm22 ' + cpm);
               // update cpm;                
                update accItem;
                system.debug('## accItem data  '+accItem);
                //system.debug('## campaign data  '+cpm);
            }
            
        }  
                
        system.debug('mydecval!! ' + mydecval);
        
    }
}