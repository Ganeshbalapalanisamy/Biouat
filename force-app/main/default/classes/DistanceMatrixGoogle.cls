/*APEX:DistanceMatrixGoogle
 
 */
public class DistanceMatrixGoogle {
 @future(callout=true)
public static void getgeoLocation(String recordId){
      // Visit_Management__c recordName = [SELECT Id, Name, Check_in_Location__Latitude__s, Check_in_Location__Longitude__s, Check_Out_Location__Latitude__s, Check_Out_Location__Longitude__s  FROM Visit_Management__c where Id =: recordId];
       Daily_Activity_Report__c recordName=[SELECT  Id, Name,Clock_in_Location__Latitude__s, Clock_in_Location__Longitude__s, Clock_out_Location__Latitude__s, Clock_out_Location__Longitude__s FROM Daily_Activity_Report__c where Id =: recordId];
       HttpRequest req = new HttpRequest();
       Http http = new Http();
       req.setMethod('GET');
    String key='AIzaSyBNjz8W6_yVKZUIYI3c-OtkqnRfmshJH7w';
   String EndpointUrl='https://maps.googleapis.com/maps/api/distancematrix/json?';
       String url = EndpointUrl+'origins='+recordName.Clock_in_Location__Latitude__s + ',' + recordName.Clock_in_Location__Longitude__s + '&destinations=' + recordName.Clock_out_Location__Latitude__s + ',' + recordName.Clock_out_Location__Longitude__s +'&mode=driving&key='+key+'&units=metric'+'&language=en'+'&mode=driving';
       req.setEndPoint(url);
       HTTPResponse resp = http.send(req);
       String json = resp.getBody();
     system.debug('response'+ resp.getBody()+ resp.getStatus()+ resp.getStatusCode());
       DistanceMatrixGoogle obj = DistanceMatrixGoogle.parse(json);
    
    
       DistanceMatrixGoogle.Rows row = (DistanceMatrixGoogle.Rows)obj.rows.get(0);
       DistanceMatrixGoogle.Elements elem = (DistanceMatrixGoogle.Elements)row.elements.get(0);
       DistanceMatrixGoogle.Distance dist = (DistanceMatrixGoogle.Distance)elem.distance;
      DistanceMatrixGoogle.Distance dura = (DistanceMatrixGoogle.Distance)elem.duration;
       String distMile = dist.text;
        String distKM =String.valueOf(dist.value);
       system.debug('distMile'+ distMile);
       system.debug('distKM'+distKM);
    String duraHrs=dura.text;
    system.debug('durationHrs'+ dura.text);
    system.debug('duration in seconds'+ dura.value);
    
    if(resp.getStatusCode()==200){
        system.debug('success');
        /*Visit_Management__c vm=new Visit_Management__c();
        vm.Id=recordId;
        //vm.Travel_Distace_From_Matrix__c=distKM;
      vm.Travel_Duration_Matrix__c=duraHrs;
        update vm;*/
         Daily_Activity_Report__c DWT=new  Daily_Activity_Report__c();
         DWT.Id=recordId;
         DWT.Total_Visit_Distance_Travelled__c=distKM;
         DWT.Is_ClockOut__c=true;
         update DWT;
    }
      
   }
   public class Elements {
       public Distance distance;
       public Distance duration;
       public String status;
   }
   public class Distance {
       public String text;
           public Integer value;
   }
    
   public List<String> destination_addresses;
   public List<String> origin_addresses;
   public List<Rows> rows;
   public String status;
   public class Rows {
       public List<Elements> elements;
   }
   public static DistanceMatrixGoogle parse(String json) {
       return (DistanceMatrixGoogle) System.JSON.deserialize(json, DistanceMatrixGoogle.class);
   }


}