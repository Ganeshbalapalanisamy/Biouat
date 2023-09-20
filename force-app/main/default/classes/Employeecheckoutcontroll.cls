public class Employeecheckoutcontroll {
    @AuraEnabled(cacheable = true)
     public static Daily_Activity_Report__c getFieldValues(String recordId){
        system.debug(recordId);
       return[select Id,CheckOut_Time__c,Remarks__c from Daily_Activity_Report__c  where Id =:recordId];
     }
    
      @AuraEnabled
        public static void setCheckout(String objectApiName,String recordId,string lat1,string long1){
        sObject sObj = Schema.getGlobalDescribe().get(objectApiName).newSObject();
        DateTime dt = System.now();
        sObj.put('Id', recordId);
        List<Daily_Activity_Report__c> dalist=[select Id,Name,Clock_in_Location__c,Clock_out_Location__c from Daily_Activity_Report__c where Id =:recordId];
            sObj.put('Clock_out_Location__Latitude__s', Decimal.valueOf(lat1)); 
             sObj.put('Clock_out_Location__Longitude__s', Decimal.valueOf(long1));
            sObj.put('CheckOut_Time__c',dt);
            System.debug('sObj--------------'+sObj);
        update sObj;
    }
   

}