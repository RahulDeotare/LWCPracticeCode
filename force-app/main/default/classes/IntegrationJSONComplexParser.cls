public with sharing class IntegrationJSONComplexParser {

    public String jsonString{get; set;}
    public Map<string, Object> result{get; set;}
    
    public void methodParsedComplexData(){


        jsonString = '{ "Status":"Success","Code":200,"Account":[{"Name": "John", "Phone": 3000, "Rating": "Hot"},{"Name": "Mike", "Phone": 4000, "Rating": "Cold"}], "Contact":[{"FirstName": "Johny", "LastName": "Deer"},{"FirstName": "Micky", "LastName": "Arthur"}]}';

        System.JSONParser jp= JSON.createParser(jsonString); // complex approach

        while(jp.nextToken()!=null){
            if(jp.getText()=='Account'){
                jp.nextToken();
                List<Account> accList = (List<Account>)jp.readValueAs(List<Account>.class);
                insert accList;
            }
            if(jp.getText()=='Contact'){
                jp.nextToken();
                List<Contact> conList = (List<Contact>)jp.readValueAs(List<Contact>.class);
                insert conList;
            }
        }
    }
}