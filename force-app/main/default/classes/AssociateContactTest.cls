@isTest
public class AssociateContactTest 
{
    
    @isTest
    public static void contactToAccountPositiveTest(){
        
        Account objAcc= new Account(Name='Eternus', Domain__c='yahoo.com');
        	insert objAcc;
		Contact objCon=new Contact(FirstName='Rahul', LastName='Deo',Email='rahul@yahoo.com');
        	insert objCon;
                Account objResult=[Select Id,Name,Domain__c from Account where Id=: objAcc.Id];
                Contact objConData=[Select Id, LastName, Domain__c from Contact where Domain__c='yahoo.com'];
                   System.assertEquals(objConData.Domain__c, objResult.Domain__c);   
        }
    @isTest
    public static void contactToAccountNegativeTest(){
        	Account objAcc= new Account(Name='Eternus', Domain__c='yahoo.com');
        		insert objAcc;
			Contact objCon=new Contact(FirstName='Rahul', LastName='Deo',Email='rahul@gmail.com');
        		insert objCon;
                    Account objResult=[Select Id,Name,Domain__c from Account where Id=: objAcc.Id];
                    Contact objConData=[Select Id, LastName, Domain__c from Contact where Domain__c='gmail.com'];
        			system.assertNotEquals(objConData.Domain__c, objResult.Domain__c);
    	}
    @isTest
    public static void contactToAccountGmailTest(){
        
        Account objAcc= new Account(Name='Eternus', Domain__c='gmail.com');
        	insert objAcc;
		Contact objCon=new Contact(FirstName='Rahul', LastName='Deo',Email='rahul@gmail.com');
        	insert objCon;
                Account objResult=[Select Id,Name,Domain__c from Account where Id=: objAcc.Id];
                Contact objConData=[Select Id, LastName, Domain__c from Contact where Domain__c='gmail.com'];
                   System.assertEquals(objConData.Domain__c, objResult.Domain__c);   
        }
    @isTest
    public static void contactToAccountEternusTest(){
        
        Account objAcc= new Account(Name='Eternus', Domain__c='eternus.com');
        	insert objAcc;
		Contact objCon=new Contact(FirstName='Rahul', LastName='Deo',Email='rahul@eternus.com');
        	insert objCon;
                Account objResult=[Select Id,Name,Domain__c from Account where Id=: objAcc.Id];
                Contact objConData=[Select Id, LastName, Domain__c from Contact where Domain__c='eternus.com'];
                   System.assertEquals(objConData.Domain__c, objResult.Domain__c);   
        }
    }