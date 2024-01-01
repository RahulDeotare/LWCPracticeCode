@isTest
public class CaseNumberPopulateHandlerTest {

    @isTest
    public static void testCaseNumbHandler(){
        List<Account> accList=new List<Account>();
        List<Case> csList=new List<Case>();
        for(Integer i=0;i<5;i++){
            Account objAcc=new Account();
            objAcc.Name='test'+i;
            accList.add(objAcc);
        }
        insert accList;
        for(Account ac:accList){
            Case cs=new Case();
            cs.AccountId=ac.Id;
            cs.Status='New';
            cs.Origin='Phone';
            csList.add(cs);
        }
        Test.startTest();
        insert csList;
        Test.stopTest();
        List<Account> acList=[Select Latest_Case_Number__c from Account where ID=:accList[0].Id];
        List<Case> cList=[Select CaseNumber from Case where ID=:csList[0].Id];
        System.assertEquals(accList[0].Latest_Case_Number__c, csList[0].CaseNumber);
    }
}