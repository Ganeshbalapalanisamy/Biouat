/*
     * Controller:locationTrackerController
     * Test Class : LocationTrackerTest
    Created Date:
Last Modified date:06/05/2023*/
public with sharing class locationTrackerController { 
    @AuraEnabled(cacheable=true) 
     public static Visit_Management__c getvisitFieldValues(String recordId1){
         Visit_Management__c dar=[select Id,Appointment_Visit_Scheduled_on__c,Check_In__c,Check_Out__c,MOM__c from Visit_Management__c where Id =:recordId1];
         system.debug('dar-------------'+dar);
       return dar;
     }
    @AuraEnabled
    public static String setLocation1(String objectApiName, String lat1, String long1, String recordId, Boolean isCheckin){
        sObject sObj = Schema.getGlobalDescribe().get(objectApiName).newSObject();
        DateTime dt = System.now();     
        String result='You cannot Check-In and Check-Out for Past/Future Appointments';
        String WorkTimeName='';
         Database.SaveResult visitSaveResult;
            sObj.put('Id', recordId);
        List<Visit_Management__c> vmlist=[Select Id,Visit_Suggestions_Comments__c,Company__c,Appointment_Visit_Scheduled_on__c,Name,Check_in_Location__c,Check_Out_Location__c,Check_In__c,Check_Out__c,Work_Time__r.Name,Work_Time__c from Visit_Management__c where id=:recordId];
        if(vmlist.size()>0)
        {
            
           for(Visit_Management__c  s:vmlist)
    {
       DateTime Vdt1 = s.Appointment_Visit_Scheduled_on__c;
        Date d = Vdt1.date();
        system.debug('Appointment_Visit_Scheduled_on__c'+d);
        WorkTimeName=s.Work_Time__c;
        DateTime dT1 = System.now();
        Date d1= Date.newInstance(dT1.year(), dT1.month(), dT1.day());
         system.debug('Today'+d1);
        
                System.debug('isCheckin '+isCheckin +'d==d1'+d==d1+'s.Check_in_Location__c'+s.Check_in_Location__c+'s.Check_Out_Location__c'+s.Check_Out_Location__c+'s.Check_Out__c'+s.Check_Out__c);

        if(isCheckin ==true &&  d==d1 && s.Check_in_Location__c==null && s.Check_In__c==null){
            sObj.put('Check_in_Location__Latitude__s', Decimal.valueOf(lat1));
            sObj.put('Check_in_Location__Longitude__s', Decimal.valueOf(long1));
            sObj.put('Check_In__c',dt);
            //result=true;
            try{ 
       update sObj;
            result='success';
        }catch(Exception e){
            result=e.getMessage();
             System.debug('getMessage'+e.getMessage());
      String regexPattern = '(?s)caused by: (.*)$';
          result=splitStrings(regexPattern,e.getMessage());
        }
        }

        else if(isCheckin ==false && d==d1 && s.Check_in_Location__c!=null && s.Check_In__c!=null && s.Check_Out_Location__c==null && s.Check_Out__c==null){
            sObj.put('Check_Out_Location__Latitude__s', Decimal.valueOf(lat1));
            sObj.put('Check_Out_Location__Longitude__s', Decimal.valueOf(long1));
            sObj.put('Check_Out__c',dt);
            //sObj.put('MOM__c',mom);
            sObj.put('Checkbox__c',true);
                 //visitSaveResult = Database.update(sObj, true);
           // sObj.put('Completed_Company__c',s.Company__c);
      // result=true;
      try{ 
       update sObj;
            result='success';
        }catch(Exception e){
            System.debug('getMessage'+e.getMessage());
        
        result=e.getMessage();
          String regexPattern = '(?s)caused by: (.*)$';
           result=splitStrings(regexPattern,e.getMessage());
            
        }
        }
        
        
        }
        }
        //ReportGeneration.calculatevalues(WorkTimeName);
     
        
      
      return result; 
        
    }
    public static string splitStrings(String regex,String errmsg){
        String regexPattern = regex;
String tempResult;
Pattern pattern = Pattern.compile(regexPattern);
Matcher matcher = pattern.matcher(errmsg);

if (matcher.find()) {
    String causedByDetails = matcher.group(1);
    tempResult=causedByDetails;
    System.debug(causedByDetails.trim());
} else {
    tempResult=errmsg;
    System.debug('Caused by details not found in the string.');
}
        return tempResult;
    }
}