public class visitmanagementcheckouttoast {
      @AuraEnabled
         public static Visit_Management__c getsuggestionscomments(String recordId){
         system.debug(recordId);
       return[select Id,Check_Out__c,Visit_Suggestions_Comments__c from Visit_Management__c  where Id =:recordId];
     }
      @AuraEnabled
   public static void setCheckout1(String objectApiName,String recordId){
        sObject sObj = Schema.getGlobalDescribe().get(objectApiName).newSObject();
        DateTime dt = System.now();
        sObj.put('Id', recordId);
        List<Visit_Management__c> dalist=[select Id,Name,Check_Out__c from Visit_Management__c where Id =:recordId];
        
            sObj.put('CheckOut_Time__c',dt);
          
            System.debug('sObj--------------'+sObj);
        update sObj;
    }
   
  
}