@isTest
public class OpportunityTriggerHandlerTest {

    @isTest
    public static void populateLatestAmt(){
        List<Account> accList=new List<Account>();
        List<Opportunity> oppList=new List<Opportunity>();
        for(Integer i=0;i<5;i++){
            Account objAcc=new Account();
            objAcc.Name='Test'+i;
            accList.add(objAcc);
        }
        insert accList;
        for(Account acc:accList){
            Opportunity objOpp=new Opportunity();           
            objOpp.Name=acc.Name;
            objOpp.StageName='Prospecting';
            objOpp.CloseDate=system.today();
            objOpp.Amount=50000;
            objOpp.AccountId=acc.Id;
            oppList.add(objOpp);
        }
        Test.startTest();
        insert oppList;
        Test.stopTest();
        List<Account> accUpdate=[Select Id,Latest_Opportunity_Amount__c from Account where Id=:accList[0].Id];
 		system.assertEquals(oppList[0].Amount, accUpdate[0].Latest_Opportunity_Amount__c);
        system.assertEquals(50000, accUpdate[0].Latest_Opportunity_Amount__c);
    }
    @isTest
    public static void updateAccountAmount(){
        
        List<Opportunity> oppList=new List<Opportunity>();
        
            Account objAcc=new Account();
            objAcc.Name='Test';
        	insert objAcc;
        
        
            Opportunity objOpp=new Opportunity();           
            objOpp.Name=objAcc.Name;
            objOpp.StageName='Prospecting';
            objOpp.CloseDate=system.today();
            objOpp.Amount=100;
            objOpp.AccountId=objAcc.Id;
            insert objOpp;
        
        	Opportunity objOpp2=new Opportunity();           
            objOpp2.Name=objAcc.Name;
            objOpp2.StageName='Prospecting';
            objOpp2.CloseDate=system.today();
            objOpp2.Amount=200;
            objOpp2.AccountId=objAcc.Id;
            insert objOpp2;
        	Test.startTest();
        	objOpp2.Amount=300;
        	update objOpp2;
        	Test.stopTest();
        Account accUpdate=[Select Id,Latest_Opportunity_Amount__c from Account where Id=:objAcc.id];
        system.assertEquals(400, accUpdate.Latest_Opportunity_Amount__c);
    }
}