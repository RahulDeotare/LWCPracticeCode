@RestResource(urlMapping='/v1/getLead')
global class LeadManipulationService {
    
    global class Result {
        public Boolean isSuccess;
        public String lead;
        public String status;
    }
    
    @httpGet
    global static List<Lead> getLeadRecords(){
        //get request URI
        //String requestURI=RestContext.request.requestURI;
        //lead ID
        //string leadId=requestURI.substring(requestURI.lastIndexOf('/')+1);
        //get lead
        return ([Select Id,FirstName,LastName,Email,phone, company from Lead LIMIT 10]);
    }
    
    
  @HttpPost
    global static Result createLead(String firstName, String lastName, String email, String phone, String company) {
        Result res= new Result();
        res.isSuccess = false;
        res.status = 'Error';
        
        Lead objLead = new Lead();
        objLead.FirstName = firstName;
        objLead.LastName = lastName;
        objLead.Email = email;
        objLead.Phone = phone;
        objLead.Company = company;
        
        
        try {
            insert objLead;
        }catch(DMLException e) {
            return res;
        }
        
     res.isSuccess = true;
        res.status = 'Success';
        res.lead = objLead.Id;
        return res;   
        
    }
       
    @HttpPut
    global static Result updateLead(String firstName, String lastName, String email, String phone) {
        Result res= new Result();
        res.isSuccess = false;
        res.status = 'Error';
        
        List<Lead> leadList = [SELECT FirstName,LastName,Email,Phone FROM Lead WHERE FirstName LIKE :firstName AND
                               LastName LIKE :lastName LIMIT 1];
  
        leadList[0].FirstName = firstName;
        leadList[0].LastName = lastName;
        leadList[0].Email = email;
        leadList[0].Phone = phone;
        
        
        try {
            update leadList;
        }catch(DMLException e) {
            return res;
        }
        
     	res.isSuccess = true;
        res.status = 'Success';
        res.lead = leadList[0].Id;
        return res;   
 		}
    
    
    
    @HttpDelete
   	global static Result deleteLead() {
        Result res= new Result();
        res.isSuccess = false;
        res.status = 'Error';
        
        String firstName = RestContext.request.params.get('firstName');
        String lastName = RestContext.request.params.get('lastName');
        String email = RestContext.request.params.get('email');
        String phone = RestContext.request.params.get('phone');
        
        List<Lead> leadList = [Select Id from Lead where FirstName = :firstName AND LastName = :lastName AND Email = :email
                               AND Phone = :phone];
        try {
            delete leadList;
        }catch(DMLException e) {
            return res;
        }
        
     res.isSuccess = true;
        res.status = 'Success';
        res.lead = leadList[0].Id;
        return res;   
        
    }
   
}