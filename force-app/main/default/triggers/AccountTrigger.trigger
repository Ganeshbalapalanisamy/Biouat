/*
 * Class Name : CompanyRecordSharing
 * Test Class : CompanyRecordSharingTestClass
 * Trigger    : AccountTrigger
 * Created Date : 25/1/2023
*/
trigger AccountTrigger on Account (after insert,after update,before insert,before update) {
    if(trigger.isBefore){
      
             for(Account c:trigger.new){
                 if(c.External_Field__c ==null || c.External_Field__c!=c.Name){
                      c.External_Field__c=c.Name;
                  }
                 
                /* if(c.same_as_billing_address__c == true){
                     system.debug('BillingState==>'+c.BillingStateCode);
                      system.debug('ShippingState==>'+c.ShippingState);
                     c.ShippingStateCode=c.BillingStateCode;
                     
                 }*/
             }
      }
    
    
  else  if(trigger.isAfter){
         Set<Id> accIds=New Set<Id>();
        if(trigger.isInsert){   
      for(Account acc : trigger.new){ 
          accIds.add(acc.Id);
    }
        if(accIds.size()>0){
            CompanyRecordSharing.provideAccesstoClusterManager(accIds);
        }
    }
    
    if(trigger.isUpdate ){
     
      for(Account acc : trigger.new){
          System.debug('new'+acc.Cluster__c);
          System.debug('Old'+Trigger.oldMap.get(acc.Id).Cluster__c);
         if(acc.Cluster__c != Trigger.oldMap.get(acc.Id).Cluster__c){
          
             accIds.add(acc.id);
        }
    }
        if(accIds.Size()>0){
CompanyRecordSharing.provideAccesstoClusterManager(accIds);
                }

          
     
        
     }
  }
    }