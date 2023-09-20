trigger ExclusivityTrigger on Exclusivity__c (before insert,before update) {
    
   switch on Trigger.operationType {
    when BEFORE_INSERT {
      // Do something before an insert operation.
      ExclusivityTriggerHandler.restrictRegionWiseBeforeInsert(Trigger.New);
      
    }
    when BEFORE_UPDATE {
      // Do something before an update operation.
       ExclusivityTriggerHandler.restrictRegionWiseBeforeUpdate(Trigger.New,Trigger.Old);

    }
   /* when BEFORE_DELETE {
      // Do something before a delete operation.
    }*/
  }

}