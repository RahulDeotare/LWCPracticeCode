@isTest
public class TestLeadService {

    @isTest
    public static void positiveTestPOST(){
    Lead objLead = new Lead();
    	objLead.FirstName = 'Test';
        objLead.LastName = 'Man';
        objLead.Company = 'Info';
        objLead.Phone = '556699';
        objLead.Email = 'q1@gmail.com';
    		insert objLead;
        
            RestRequest req = new RestRequest();
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/v1/getLeadInformation'; //Request URL
            req.httpMethod = 'POST';
            String body = '{"FirstName": "Rahul", "LastName":"Deo", "Company":"Beans","Phone":"78952","Email":"e1@gmail.com"}';
            req.requestBody = BLOB.valueOf(body);
            RestContext.request = req;
            Test.startTest();
            LeadServiceTrial.createLead();
            Test.stopTest();
	}
    @isTest
    public static void positiveTestPUT(){
        Lead objLead = new Lead(FirstName='Test',LastName='Man',Company='Info',Phone='556699',Email='q1@gmail.com');
    	
    		insert objLead;
        
            RestRequest req = new RestRequest();
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/v1/getLeadInformation'; //Request URL
            req.httpMethod = 'PUT';
            String body = '{"FirstName": "Rahul", "LastName":"Deo"}';
        //objLead.Phone='123485';
        //objLead.Email = 'r1@gmail.com';
        //update objLead;
        	req.requestBody = BLOB.valueOf(body);
            RestContext.request = req;
       /* Lead objLeadResult=[Select FirstName,LastName,Company,Phone,Email from Lead where FirstName=:objLead.FirstName AND 
                           LastName=:objLead.LastName];
                            objLeadResult.Phone='987456';
                            objLeadResult.Email='r1@gmail.com';
                            update objLeadResult;*/
            Test.startTest();
        Lead objLeadResult=[Select FirstName,LastName,Company,Phone,Email from Lead where FirstName=:objLead.FirstName AND 
                           LastName=:objLead.LastName];
                            objLeadResult.Phone='987456';
                            objLeadResult.Email='r1@gmail.com';
                            update objLeadResult;
            LeadServiceTrial.updateLead();
            Test.stopTest();
    }
    
    //For Delete
    @isTest
    public static void positiveTestDelete(){
        Lead objLead = new Lead();
    	objLead.FirstName = 'Test';
        objLead.LastName = 'Man';
        objLead.Company = 'Info';
        objLead.Phone = '556699';
        objLead.Email = 'q1@gmail.com';
    		insert objLead;
        
            RestRequest req = new RestRequest();
            RestResponse res = new RestResponse();
            req.requestURI = '/services/apexrest/v1/getLeadInformation'; //Request URL
            req.httpMethod = 'POST';
            String body = '{"FirstName": "Rahul", "LastName":"Deo", "Company":"Beans","Phone":"78952","Email":"e1@gmail.com"}';
            req.requestBody = BLOB.valueOf(body);
            RestContext.request = req;
       		//if(objLead.FirstName==)
            Test.startTest();
            LeadServiceTrial.deleteLead();
            Test.stopTest();
	}
}