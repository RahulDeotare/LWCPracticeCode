public class ContactCount{

        Public static void associatedcontacts()
        {
                List<Account> accList =[SELECT Name,ID,Count_of_Contacts__c
                FROM Account
                WHERE Name='Eternus'];
                System.debug(accList);
                //Q5= Child parrent querry
                List<Contact> conList = [SELECT lastName, Account.Name,Account.ID
                FROM Contact
                WHERE Account.Name='Eternus'];
                system.debug(conList.size());
                System.debug(conList);
                for(Account acc :accList)
                {
                acc.Count_of_Contacts__c = conList.size();
                System.debug(acc.Count_of_Contacts__c);
                }
                update accList;
        }

}