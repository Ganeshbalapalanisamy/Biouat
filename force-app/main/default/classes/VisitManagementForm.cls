public class VisitManagementForm {
     @AuraEnabled(Cacheable=True)
      public static  BiomatiQ_Lead__c oppInformation(String recId){
             BiomatiQ_Lead__c  lstOpp = [SELECT Id,Company_Name__c,Contact__c  FROM BiomatiQ_Lead__c WHERE ID = :recId]; 
             system.debug(lstOpp);
             return lstOpp;
       
    }
     @AuraEnabled(Cacheable=True)
      public static  Contact contactInformation(String recId){
             Contact  lstcontact = [SELECT Id,AccountId  FROM Contact WHERE Id = :recId]; 
             system.debug(lstcontact);
             return lstcontact;
       
    }
    // Method to fetch lookup search result   
    @AuraEnabled(cacheable=true)
    public static list<sObject> fetchLookupData(string searchKey , string sObjectApiName,String recordId) {    
        List < sObject > returnList = new List < sObject > ();
        string sWildCardText = '%' + searchKey + '%';
        string sQuery = 'Select Id,Name,Company_Name__c From ' + sObjectApiName + ' Where Company_Name__c=:recordId AND Name Like : sWildCardText order by createdDate DESC LIMIT 5';
        for (sObject obj: database.query(sQuery)) {
            returnList.add(obj);
        }
        return returnList;
    }

    
}