public with sharing class FieldSetClassLwcAssignment {
    public FieldSetClassLwcAssignment() {

    }
    @AuraEnabled(cacheable=true)
    public static Map<String, String> getObjectList()
    {
       
        Map<String, String> sObjectNamebyLabel = new Map<String, String>();
        for(SObjectType objectType : Schema.getGlobalDescribe().values()) {
            DescribeSObjectResult sObjectDescribe = objectType.getDescribe();
            if(sObjectDescribe.isAccessible() && sObjectDescribe.isQueryable()) {
                sObjectNamebyLabel.put(sObjectDescribe.getLabel(),sObjectDescribe.getName());
            }
        }        
        return sObjectNamebyLabel;

        
    }
    
@AuraEnabled(cacheable=true)
public static string allRecord(String objectApiNames, string fieldsetName){
    Map<String, String> returnMap = new Map<String,String>();
    if(!String.isEmpty(objectApiNames) && !String.isEmpty(fieldsetName)){
        //get fields from FieldSet
        SObject sObj = (SObject)(Type.forName('Schema.'+ objectApiNames).newInstance());
        List<Schema.FieldSetMember> lstFSMember = 
            sObj.getSObjectType().getDescribe().fieldSets.getMap().get(fieldsetName).getFields();

    //prepare SOQL query based on fieldAPIs	
    String query = 'SELECT ';
    for(Schema.FieldSetMember f : lstFSMember) {
        query += f.getFieldPath() + ', ';
        }
        query += 'Id FROM ' + objectApiNames ;

        // //Just in case criteria field not specified then it will return all records
        // if(!(String.isEmpty(criteriaField) && String.isEmpty(criteriaFieldValue))){
        //     query += ' WHERE ' + criteriaField + '=\'' + criteriaFieldValue + '\'';
        // }
                    
    //execute query
         List<SObject> lstRecords = Database.query(query);
        
         //prepare a map which will hold fieldList and recordList and return it
     returnMap.put('FIELD_LIST', JSON.serialize(lstFSMember));
     returnMap.put('RECORD_LIST', JSON.serialize(lstRecords));
     return JSON.serialize(returnMap);
    }
    return null;
    }

    @AuraEnabled( cacheable = true )
    public static list<Contact> ContacttList(){
        list<Contact> lstAcc=[Select Id,FirstName,LastName,Email,Account.Name from Contact];
        return lstAcc;
    }
    @AuraEnabled
    public static string checkEmail(List<string> emailId){
        try {
            list<Contact> lstAcc=[Select Email from Contact where Email IN :emailId];
            List<String> email = new List<String>();
            system.debug(lstAcc);
            for(Contact con:lstAcc){
               email.add(con.Email); 
            }
            if(lstAcc.size()>0){
                system.debug('"status":"false","data":"'+email+'"');
                return '{"status":"false","data":"'+email+'"}';
            }
            else{
                system.debug('"status":"true","data":"'+email+'"');
                return '{"status":"true","data":"'+email+'"}';
            }
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}