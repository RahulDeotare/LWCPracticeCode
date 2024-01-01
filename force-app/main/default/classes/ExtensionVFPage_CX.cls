public class ExtensionVFPage_CX {
    public List<Account> accList {get; set;}
    public ExtensionVFPage_CX(ApexPages.StandardController controller) {
        accList = [select Id, Name, Type, Rating,SLA__c, (select id from CombinedAttachments) from Account LIMIT 5];
    }

}