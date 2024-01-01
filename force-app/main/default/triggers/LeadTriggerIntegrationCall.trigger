trigger LeadTriggerIntegrationCall on Lead (after insert) {

    //Map<Id,Lead> leadMap = new Map<Id,Lead>([SELECT Id, Name, MobilePhone FROM Lead WHERE MobilePhone != null]);
    Map<Id,Lead> leadMap = Trigger.newMap;
    Set<Id> keys = leadMap.keySet();
    IntegrationLeadToSMSThree.leadToSmsSend(keys);

}