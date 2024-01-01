@RestResource(urlMapping='/v1/getLeadRecords')

global class LeadProvider {
	
    @httpGet
    global static List<Lead> getAllLeads(){ //to fetch records from target org eternus org
        return ([Select Id, FirstName,LastName,Email,Phone,Company from Lead LIMIT 5]);
    }
    
    /*@httpGet
    global static Lead 	getSelectedLeads(){
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
        string jsonString=req.requestBody.tostring();
        responseWrapper objResWrap=(responseWrapper) JSON.deserialize(jsonString, responseWrapper.class);
        
        return ([Select Id, FirstName,LastName,Email,Phone,Name from Lead where Name=:objResWrap.Name ]);
    }*/
    
    /*@httpPost
    global static Lead 	getSelectedLeads(){
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        
        string jsonString=req.requestBody.tostring();
        responseWrapper objResWrap=(responseWrapper) JSON.deserialize(jsonString, responseWrapper.class);
        
        Lead objLead=new Lead(FirstName=objResWrap.firstname,LastName=objResWrap.lastname,
                              Email=objResWrap.email,Phone=objResWrap.phone,
                              Id=objResWrap.Id,Company=objResWrap.company);
        insert objLead;
        return objLead;
    }*/
    
    global class responseWrapper{ //generalized and need to use everytime
        global Id Id;
        global String company;
        global String name;
        global string firstname;
        global string lastname;
        global string email;
        global string phone;
    }
}