@isTest
public class AccountTriggerNovemberHandlerTest {

    @isTest
    public static void updateRelatedContactTest(){
        List<Account> accList=new List<Account>();
        List<Contact> conList=new List<contact>();
        for(Integer i=0;i<10;i++){
            Account objAcc=new Account();
            objAcc.Name='Test'+i;
            objAcc.Phone='12345';
            accList.add(objAcc);
        }
        Test.startTest();
        insert accList;
        for(Account acc:accList){
            Contact con=new Contact(LastName=acc.Name);
            con.AccountId=acc.Id;
            conList.add(con);
        }
        insert conList;
        for(Account acc:accList){
            acc.Phone='64546';
        }
        update accList;
        List<Contact> updateConList=[Select Id,Name,AccountId,HomePhone from Contact where Id=:conList[0].Id];
        system.assertEquals('64546',updateConList[0].HomePhone);
        Test.stopTest();
    }
}