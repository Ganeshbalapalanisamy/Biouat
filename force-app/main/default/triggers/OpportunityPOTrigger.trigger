trigger OpportunityPOTrigger on Biomatiq_Opportunity__c (After  insert,After update) {
      OpportunityPOTriggerHandler.getOppList(Trigger.new,Trigger.oldMap);
}