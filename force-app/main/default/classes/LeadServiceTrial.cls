@RestResource(urlMapping='/v1/getLeadInformation')
global class LeadServiceTrial {

    global class Result {
        public Boolean isSuccess;
        public String lead;
        public String status;
    }
    
    global class responseWrapper{ //generalized and need to use everytime
        global Id Id;
        global String company;
        global String name;
        global string firstname;
        global string lastname;
        global string email;
        global string phone;
    }
    
    @httpPost
    global static Result createLead(){
        Result res= new Result();
        res.isSuccess = false;
        res.status = 'Error';
        
        RestRequest req=RestContext.request;
        RestResponse res1=RestContext.response;
        
        string jsonString=req.requestBody.tostring();
        responseWrapper objResWrap=(responseWrapper) JSON.deserialize(jsonString, responseWrapper.class);
        
        Lead objLead=new Lead(FirstName=objResWrap.firstname,LastName=objResWrap.lastname,
                              Email=objResWrap.email,Phone=objResWrap.phone,
                              Id=objResWrap.Id,Company=objResWrap.company);
        insert objLead;
        
        res.isSuccess = true;
        res.status = 'Success';
        res.lead = objLead.Id;
        return res; 
    }
    
    @httpPut
    global static Result updateLead(){
        Result res= new Result();
        res.isSuccess = false;
        res.status = 'Error';
        
        RestRequest req=RestContext.request;
        RestResponse res1=RestContext.response;
        
        string jsonString=req.requestBody.tostring();
        responseWrapper objResWrap=(responseWrapper) JSON.deserialize(jsonString, responseWrapper.class);
        
        Lead objLead=[SELECT FirstName,LastName,Email,Phone FROM Lead WHERE FirstName LIKE :objResWrap.firstname 
                             AND LastName LIKE :objResWrap.lastname LIMIT 1];
        objLead.Phone =objResWrap.phone;
        objLead.Email =objResWrap.email;
        update objLead;
        
        res.isSuccess = true;
        res.status = 'Success';
        res.lead = objLead.Id;
        return res;
    }
    
    @httpDelete
    global static Result deleteLead(){
        Result res= new Result();
        res.isSuccess = false;
        res.status = 'Error';
        
        RestRequest req=RestContext.request;
        RestResponse res1=RestContext.response;
        
        string jsonString=req.requestBody.tostring();
        responseWrapper objResWrap=(responseWrapper) JSON.deserialize(jsonString, responseWrapper.class);
        
        Lead objLead=[SELECT FirstName,LastName,Email,Phone FROM Lead WHERE FirstName=:objResWrap.firstname AND 
                     LastName=:objResWrap.lastname AND Email=:objResWrap.email AND Phone=:objResWrap.phone];
        delete objLead;
        
        res.isSuccess = true;
        res.status = 'Success';
        res.lead = objLead.Id;
        return res;
    }
}