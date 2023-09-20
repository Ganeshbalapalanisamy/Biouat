/*
 * Class Name : ClusterRecordSharing
 * Test Class : CompanyRecordSharingTestClass
 * Trigger    : clusterTrigger
 * Created Date : 25/1/2023
*/

public class ClusterRecordSharing {
    public static void provideAccess(List<Cluster__c> clusterList,Map<Id,Cluster__c> clusterMap){
         List<Cluster__Share> clustShrs  = new List<Cluster__Share>();
        Cluster__Share clusterShr;
        String ownerId;
        String salesuser;
        for(Cluster__c job : clusterList){
            if(job.Sales_Person__c!=null){
            ownerId=job.OwnerId;
            salesuser=job.Sales_Person__c;
            clusterShr = new Cluster__Share();
            clusterShr.ParentId = job.Id;
            clusterShr.UserOrGroupId = job.Sales_Person__c;
            clusterShr.AccessLevel = 'edit';
             //clusterShr.RowCause = Schema.Cluster__Share.RowCause.Sales_Person__c;
           clusterShr.RowCause = Schema.Cluster__Share.RowCause.Manual;
            clustShrs.add(clusterShr);
            }
        }
        Map<Id,Account> accountMap=New Map<Id,Account>();
        for(Account ac:([Select Id,Name,Cluster__c from Account Where Cluster__c IN:clusterMap.Keyset()])){
            accountMap.put(ac.Id, ac);
        }
        if(ownerId!=salesuser && clustShrs!=null){
          
          
        Database.SaveResult[] lsr = Database.insert(clustShrs,false);
            
            
        Integer i=0;

        for(Database.SaveResult sr : lsr){
            if(!sr.isSuccess()){

                Database.Error err = sr.getErrors()[0];
              
                if(!(err.getStatusCode() == StatusCode.FIELD_FILTER_VALIDATION_EXCEPTION  &&  err.getMessage().contains('AccessLevel'))){
                   
                   clusterMap.get(clustShrs[i].ParentId).addError('Unable to grant sharing access due to following exception: ' + err.getMessage());
                }
            }
            else if(accountMap.size()>0){
                CompanyRecordSharing.provideAccesstoClusterManager(accountMap.Keyset());
            }
            i++;
            
        }
            
        }   
    }
}