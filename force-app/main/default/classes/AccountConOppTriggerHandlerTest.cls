@isTest
public class AccountConOppTriggerHandlerTest {

    @isTest
    public static void createOppAndCon(){
        List<Account> accList=new List<Account>();
        for(Integer i=1;i<10;i++){
            Account acc=new Account();
            acc.Name='Test'+i;
            if(math.mod(i, 2)==0){
            acc.New_Contact__c=true;
            }
            else{
                acc.New_Opportunity__c=true;
            }
            accList.add(acc);
        }
        Test.startTest();
        insert accList;
        Test.stopTest();
        List<Contact> updateCon=[Select Id,Name from Contact where AccountId=:accList[0].Id];
        List<Opportunity> updateOpp=[Select Id,Name from Opportunity where AccountId=:accList[1].Id];
        System.assert(updateCon!=null, 'No contact is There');
        System.assert(updateOpp!=null, 'No contact is There');
    }
}