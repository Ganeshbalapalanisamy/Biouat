trigger clusterTrigger on Cluster__c (after insert,after update) {
     if(trigger.isInsert || trigger.isUpdate){
         ClusterRecordSharing.provideAccess(trigger.new,trigger.newMap);
     }
if(trigger.isUpdate){
    
    for(Cluster__c c:trigger.new){
        if(c.Sales_Person__c != Trigger.oldMap.get(c.Id).Sales_Person__c){
         ClusterRecordSharing.provideAccess(trigger.new,trigger.newMap);
        }
     }
}
}