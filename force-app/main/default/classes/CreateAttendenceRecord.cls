public class CreateAttendenceRecord {

   
    
    @AuraEnabled
    public static Id createNewEntry(string firstName,string lastName, string email,string employeeId, string ipAddress){
        
        Attendence__c attInstance = new Attendence__c();
        attInstance.EmployeeFirstName__c = firstName;
        attInstance.EmployeeLastName__c = lastName;
        attInstance.Email__c = email;
        attInstance.EmployeeId__c = employeeId;
        attInstance.IpAddress__c = ipAddress;
        insert attInstance;
        return attInstance.Id;
    }

}