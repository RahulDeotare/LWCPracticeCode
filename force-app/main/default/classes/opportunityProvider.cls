public with sharing class opportunityProvider {
    public opportunityProvider() {

    }
    @AuraEnabled
    public static string createOpportunity(Opportunity objOpp){
        try {
            insert objOpp;
                    return 'Account Created Successfully!!';
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}