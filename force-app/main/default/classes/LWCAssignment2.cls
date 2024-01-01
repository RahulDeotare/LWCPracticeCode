public with sharing class LWCAssignment2 {
    public LWCAssignment2() {

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
    @AuraEnabled
    public static FieldSetForm getForm(Id recordId, String objectName, String fieldSetName) {
        FieldSetForm form = new FieldSetForm();        
        form.Fields = getFields(recordId, objectName, fieldSetName);
        
        return form;
    }
    
    private static List<FormField> getFields(Id recordId, String objectName, String fieldSetName) {
        Schema.SObjectType objectType = null;
        
        if (recordId != null) {
            objectType = recordId.getSobjectType();
        }
        else if (String.isNotBlank(objectName)) {
            objectType = Schema.getGlobalDescribe().get(objectName);
        }
        
        Schema.DescribeSObjectResult objectDescribe = objectType.getDescribe();
        Map<String, Schema.FieldSet> fieldSetMap = objectDescribe.fieldSets.getMap();
        Schema.FieldSet fieldSet = fieldSetMap.get(fieldSetName);
        List<Schema.FieldSetMember> fieldSetMembers = fieldSet.getFields();
        
        List<FormField> fields = new List<FormField>();
        for (Schema.FieldSetMember fsm : fieldSetMembers) {
            FormField f = new FormField(fsm);
            fields.add(f);
        }
        
        return fields;
    }
    
    public class FieldSetForm {
        @AuraEnabled
        public List<FormField> Fields { get; set; }
        
        public FieldSetForm() {
            Fields = new List<FormField>();
        }
    }
    //for assignment two
    @AuraEnabled (cacheable=true)
    public static List<EntityDefinition> retreieveObjects(){
        return [SELECT Id, MasterLabel,  
                    DeveloperName, 
                    QualifiedApiName 
                    FROM EntityDefinition 
                    WHERE IsApexTriggerable = true And DeveloperName In ('Lead','Account','Case')
                    ORDER BY MasterLabel
                    ];
    }

  
    @AuraEnabled(cacheable=true)
    public static string getAllRecords(String objectApiNames, string fieldsetName){
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

     //Retrieve field details based on Object API Name
     @AuraEnabled (cacheable=true)
     public static String getListOfFields(String objectAPIName){
         Map<string, string> fieldList = new Map<string, string>();
         if(!String.isEmpty(objectAPIName)){
             Map<String, String> mapField = new Map<String, String>();
             Map<string,SObjectField> lstFields = 
                 schema.getGlobalDescribe().get(objectAPIName).getDescribe().fields.getMap();
 
             for(String str: lstFields.keySet()){
                 mapField.put(str, lstFields.get(str).getDescribe().getLabel());                
             }
             System.debug(System.JSON.serializePretty(mapField));
             return System.JSON.serializePretty(mapField);
         }
         return null;
     }

     
   //Retrieve records based on selected fields and object.
   @AuraEnabled (cacheable=true)
   public static List<SObject> retreieveRecords(String objectName, String fieldAPINames,String soId){
       String strQuery = 'SELECT ' + String.escapeSingleQuotes(fieldAPINames) 
                       + ' FROM ' + String.escapeSingleQuotes(objectName);
       return System.database.query(strQuery);
   }
}