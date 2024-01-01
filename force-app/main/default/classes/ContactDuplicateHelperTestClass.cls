@isTest
public class ContactDuplicateHelperTestClass {

    @isTest
    public static void testContactDuplicateTrigger(){
        List<Contact> conList=new List<Contact>();
            Contact objCon=new Contact();
            objCon.LastName='Test';
            objCon.Email='a1@gmail.com';
        	objCon.HomePhone='12345';
        	insert objCon;
        
        	Contact objCon1=new Contact();
        	objCon1.LastName='Test';
            objCon1.Email='a1@gmail.com';
        	objCon1.HomePhone='12345';
        	Test.startTest();
        	insert objCon1;
        	Test.stopTest();
        
    }
}