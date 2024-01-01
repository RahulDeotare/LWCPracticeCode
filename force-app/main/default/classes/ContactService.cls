@RestResource(urlMapping='/v1/getAllContactRecords/*')
global class ContactService {
	
    global List<Accounts> listOfAccount;
    global class accountParameters{   
        global String Name;
        global List<contactParameters> contacts;
        
    }
    global ContactService(){
        listOfAccount=new List<Accounts>();
    }
    global class Accounts{
        global string Name;
        global Id myId; 
    }
    
     global class contactParameters{ //generalized and need to use everytime
        global Id Id;
        global String firstname;
        global string lastname;
        global string email;
        global string phone;
        
    }
  
    @httpGet
    global static List<Account> getContactRecords(){
        RestRequest req = RestContext.request;
        system.debug('##rest request  '+req);
        //accountParameters parameters = (accountParameters)JSON.deserialize(req.requestBody.toString(), accountParameters.Class);
        //system.debug('###deserialize parameters  '+parameters);
            RestResponse res = new RestResponse();
    		RestContext.response = res;
            string accId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        		//system.debug('##account Id  '+parameters.myId);
        
        system.debug('## parametes'+req.requestBody.toString());
            list<Account> accList = [Select Id, Name,(Select Id,FirstName,LastName from Contacts) from Account where Id=:accId];
        	res.responseBody = Blob.valueOf(JSON.serialize(accList));
                System.debug('## Record  '+accList);
                if(!accList.isEmpty()){
                    for(Account A:accList){
                     list<Contact> adlist = A.Contacts;
                        for(Contact AD:adlist){
                            System.debug('##Data  '+AD);
                        }
                    }
                }
        
            return accList;
        }
    @HttpPost
    global static List<String> createContact() {
         
        RestRequest req=RestContext.request;
         system.debug('###rest request post  '+req);
        accountParameters parameters = (accountParameters)JSON.deserialize(req.requestBody.toString(), accountParameters.Class);
         system.debug('###deserialize parameters  '+parameters);
            List<Account> acctList = new List<Account>();
            List<String> returnResponse = new List<String>();
            List<Contact> contacts=new List<Contact>();
                Account objAcc=new Account(Name=parameters.Name);
                insert objAcc;
        
        if(!parameters.contacts.isEmpty()){
            for(contactParameters CP : parameters.contacts){
                Contact con = new Contact();
                con.LastName = CP.lastname;
                con.FirstName = CP.firstname;
                con.AccountId = objAcc.Id;
                con.Email=CP.email;
                con.Phone=CP.phone;
                 
                contacts.add(con);
            }
        }
				insert contacts;
        		return returnResponse;
    }
}