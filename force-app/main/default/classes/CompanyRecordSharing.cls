/*
 * Class Name : CompanyRecordSharing
 * Test Class : CompanyRecordSharingTestClass
 * Trigger    : AccountTrigger
 * Created Date : 25/1/2023
*/


global class CompanyRecordSharing {
   
   @future
  public static void provideAccesstoClusterManager(Set<Id> accIdList){

      List<Account> accountList=[SELECT Id,Name,Cluster__c,OwnerId from Account Where Id IN :accIdList];
      Map<Id,Account> accountMap=New Map<Id,Account>();
         List<AccountShare> acctShrs  = new List<AccountShare>();
        AccountShare accountShr;
     String cluster;
     String OwnerId;
     Id salesPerson;
     for(Account ac : accountList){
         cluster=ac.Cluster__c;
         OwnerId=ac.OwnerId;
         accountMap.put(ac.Id,ac);
      
     }
     if(cluster!=null){
     salesPerson=[Select Id,Name,Sales_Person__c from Cluster__c where Id=:cluster].Sales_Person__c;
     }
     if(salesPerson!=null){
        for(Account acc : accountList){
            accountShr = new AccountShare();
            accountShr.AccountId = acc.Id;
            accountShr.UserOrGroupId = salesPerson;
            accountShr.AccountAccessLevel = 'read';
            accountShr.OpportunityAccessLevel='read';
            accountShr.RowCause = Schema.AccountShare.RowCause.Manual;
            acctShrs.add(accountShr);
        }
        
  
     if(OwnerId!=salesPerson && acctShrs!=null){
        Database.SaveResult[] lsr = Database.insert(acctShrs,false);
        Integer i=0;
   
        for(Database.SaveResult sr : lsr){
            if(!sr.isSuccess()){

                Database.Error err = sr.getErrors()[0];
                
               
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION   &&  err.getMessage().contains('AccessLevel'))){
                System.debug('Error'+err.getMessage());
                    if(accountList.size()==1){
                        
                    
                     accountMap.get(acctShrs[i].AccountId). addError(  'Unable to grant sharing access due to following exception: ' + err.getMessage());
                    }
                    }
            }
            i++;
        }  
     }
     }
    }
    
}