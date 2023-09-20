public class RouteMapController {
 @AuraEnabled(cacheable=true) public static List<String> fetchLocationDetails(Id recordId) {
     System.debug('recordId'+recordId);
     Daily_Activity_Report__c workTimeRecs=[select id,Name,Clock_in_Location__c,Clock_in_Location__Latitude__s,Clock_out_Location__Latitude__s,Clock_out_Location__c From Daily_Activity_Report__c where id=:recordId];
   
     //Visit_Management__c visitRecs=[select id,Name,Check_in_Location__c,Check_Out_Location__c,Work_Time__c From Visit_Management__c where Work_Time__c=:recordId];
  List<String> locations=new List<String>();
     String Checkin=String.ValueOf(workTimeRecs.Clock_in_Location__Latitude__s)+','+String.ValueOf(workTimeRecs.Clock_in_Location__Longitude__s);
     String Checkout=String.ValueOf(workTimeRecs.Clock_in_Location__Latitude__s);
System.debug('Checkin'+Checkin);
     System.debug('Checkin'+Checkin);
     System.debug('Checkout'+Checkout);
     
     locations.add(Checkin);
     locations.add(Checkout);
     return locations;
}
}