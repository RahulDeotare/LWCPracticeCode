@isTest
public class AccountRatingTriggerHandlerTest {
	
    @isTest
    public static void updateRatingTest(){
        List<Account> accList=new List<Account>();
        for(Integer i=0;i<5;i++){
            Account objAcc=new Account();
            objAcc.Name='Test'+i;
            objAcc.Industry='Agriculture';
            accList.add(objAcc);
        }
        Test.startTest();
        insert accList;
        Test.stopTest();
        List<Account> updateAcc=[Select Id,Rating from Account where ID=:accList[0].Id];
        system.assertEquals('Hot', updateAcc[0].Rating);
    }
}