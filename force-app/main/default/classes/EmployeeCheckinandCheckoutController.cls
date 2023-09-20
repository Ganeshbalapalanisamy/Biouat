/*
 Apex:EmployeeCheckinandCheckoutController
TestClass:EmployeeCheckinTestClass
LWC:EmployeeCheckinCheckout
 */
    public class EmployeeCheckinandCheckoutController {     
@AuraEnabled
    public static void setCheckin(String objectApiName,string lat1,string long1){
        sObject sObj = Schema.getGlobalDescribe().get(objectApiName).newSObject();
        DateTime dt = Datetime.now();
        Id userId=UserInfo.getUserId();
        User usr = [Select Name From User where Id = :userId];
               sObj.put('Check_In_Time__c',dt);
               sObj.put('Name',usr.Name);
               sObj.put('Clock_in_Location__Latitude__s', Decimal.valueOf(lat1)); 
               sObj.put('Clock_in_Location__Longitude__s', Decimal.valueOf(long1)); 
           
            System.debug('sObj-------'+sObj);
            insert sObj; 
     
    }
    
    @AuraEnabled
        public static Daily_Activity_Report__c setCheckout(String objectApiName,string lat2,string long2){
            sObject sObj = Schema.getGlobalDescribe().get(objectApiName).newSObject();
           Daily_Activity_Report__c dailyactivity=null;
          DateTime dt = System.now();
             Daily_Activity_Report__c setvalues=null;            
        List<Daily_Activity_Report__c> dailyactivityrecords=[select Id,Name,Remarks__c,Clock_in_Location__c,Clock_out_Location__c,Check_In_Time__c,CheckOut_Time__c from Daily_Activity_Report__c 
                                               where CreatedDate=Today AND OwnerID =: Userinfo.getUserId() order by CreatedDate DESC LIMIT 1];
            if(dailyactivityrecords.size() >0 )
            {
              dailyactivity=dailyactivityrecords[0];                
            
                if(dailyactivity.CheckOut_Time__c==null){
             sObj.put('Id',dailyactivity.Id);
             sObj.put('Remarks__c',dailyactivity.Remarks__c);
             sObj.put('Clock_out_Location__Latitude__s', Decimal.valueOf(lat2)); 
             sObj.put('Clock_out_Location__Longitude__s', Decimal.valueOf(long2));
             sObj.put('CheckOut_Time__c',dt);
             update sObj;
                }
            } 
            return dailyactivity;         
    }
     @AuraEnabled
    public static String parseJSONResponse(String objectApiName,string addr,string addr1) {  
        System.debug('add'+12.9796905+'add1'+addr1);   
        String address=addr+'+'+addr1;
        system.debug('address'+address);
        String key='AIzaSyBNjz8W6_yVKZUIYI3c-OtkqnRfmshJH7w';
        Http httpProtocol = new Http();
        // Create HTTP request to send.
        HttpRequest request = new HttpRequest();
        // Set the endpoint URL.
        String endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?address='+address+'&key='+key;
        request.setEndPoint(endpoint);
        // Set the HTTP verb to GET.
        request.setMethod('GET');
        // Send the HTTP request and get the response.
        // The response is in JSON format.
        HttpResponse response = httpProtocol.send(request);

        String json=response.getBody();
       
       // Map<String,Object> m = (Map<String,Object>) JSON.deserialize(json, Map<String,Object>.class);
       // String formatted_address = m.get('formatted_address');
       // System.debug(formatted_address);
        EmployeeCheckinandCheckoutController obj = EmployeeCheckinandCheckoutController.parse(json);
        EmployeeCheckinandCheckoutController.results row = (EmployeeCheckinandCheckoutController.results)obj.results.get(0);
          
        String addre=row.formatted_address;
        System.debug('####Body : '+response.getBody());
        System.debug('addre'+addre);
        Daily_Activity_Report__c dailyactivity=null;
        sObject sObj = Schema.getGlobalDescribe().get(objectApiName).newSObject();
         List<Daily_Activity_Report__c> dailyactivityrecords=[select Id,Name,Remarks__c,Clock_in_Location__c,Clock_out_Location__c,Check_In_Time__c,CheckOut_Time__c from Daily_Activity_Report__c 
                                               where CreatedDate=Today AND OwnerID =: Userinfo.getUserId() order by CreatedDate DESC LIMIT 1];
       if(dailyactivityrecords.size() >0 )
            {
              dailyactivity=dailyactivityrecords[0];                
            
                
             sObj.put('Id',dailyactivity.Id);
             sObj.put('CheckInaddress__c',addre);
             
             update sObj;
               
            }      
      return addre;
    } 
     @AuraEnabled
    public static String parseJSONResponse1(String objectApiName,string addr,string addr1) {  
        System.debug('add'+12.9796905+'add1'+addr1);   
        String address=addr+'+'+addr1;
        system.debug('address'+address);
        String key='AIzaSyBNjz8W6_yVKZUIYI3c-OtkqnRfmshJH7w';
        Http httpProtocol = new Http();
        // Create HTTP request to send.
        HttpRequest request = new HttpRequest();
        // Set the endpoint URL.
        String endpoint = 'https://maps.googleapis.com/maps/api/geocode/json?address='+address+'&key='+key;
        request.setEndPoint(endpoint);
        // Set the HTTP verb to GET.
        request.setMethod('GET');
        // Send the HTTP request and get the response.
        // The response is in JSON format.
        HttpResponse response = httpProtocol.send(request);

        String json=response.getBody();
       
       // Map<String,Object> m = (Map<String,Object>) JSON.deserialize(json, Map<String,Object>.class);
       // String formatted_address = m.get('formatted_address');
       // System.debug(formatted_address);
        EmployeeCheckinandCheckoutController obj = EmployeeCheckinandCheckoutController.parse(json);
        EmployeeCheckinandCheckoutController.results row = (EmployeeCheckinandCheckoutController.results)obj.results.get(0);
          
        String addre=row.formatted_address;
        System.debug('####Body : '+response.getBody());
        System.debug('addre'+addre);
        Daily_Activity_Report__c dailyactivity=null;
        sObject sObj = Schema.getGlobalDescribe().get(objectApiName).newSObject();
         List<Daily_Activity_Report__c> dailyactivityrecords=[select Id,Name,Remarks__c,Clock_in_Location__c,Clock_out_Location__c,Check_In_Time__c,CheckOut_Time__c from Daily_Activity_Report__c 
                                               where CreatedDate=Today AND OwnerID =: Userinfo.getUserId() order by CreatedDate DESC LIMIT 1];
       if(dailyactivityrecords.size() >0 )
            {
              dailyactivity=dailyactivityrecords[0];                
            
                
             sObj.put('Id',dailyactivity.Id);
             sObj.put('CheckoutAddress__c',addre);
             
             update sObj;
              
            }      
      return addre;
    } 
  /* public class address_components {
       public String ;
       public String ;
       public String ;
       public String ;
           public Integer value;
   }
    public List<results> results;
    public class results {
       public List<address_components> address_components;
   } */
   public List<results> results;
   public class results {
		public String formatted_address;	
	}
     public static EmployeeCheckinandCheckoutController parse(String json) {
       return (EmployeeCheckinandCheckoutController) System.JSON.deserialize(json, EmployeeCheckinandCheckoutController.class);
   } 

  @AuraEnabled
        public static void intervalLocation(String objectApiName,string lat1,string long1){
             sObject sObj = Schema.getGlobalDescribe().get(objectApiName).newSObject();
             String Location=lat1+','+long1;
             Daily_Activity_Report__c dailyactivity=null;
             List<Daily_Activity_Report__c> dailyactivityrecords=[select Id,Name,Remarks__c,IntervalLocation__c,Clock_in_Location__c,Clock_out_Location__c,Check_In_Time__c,CheckOut_Time__c from Daily_Activity_Report__c 
                                               where CreatedDate=Today AND OwnerID =: Userinfo.getUserId() order by CreatedDate DESC LIMIT 1];
            
          if(dailyactivityrecords.size() >0 )
            {
              dailyactivity=dailyactivityrecords[0];                
              sObj.put('Id',dailyactivity.Id);
              sObj.put('IntervalLocation__c',dailyactivity.IntervalLocation__c+'New'+Location);
             
             update sObj;
               
            }   
        }
        
        @AuraEnabled(cacheable=true)
        public static Daily_Activity_Report__c checkDayIn(){
            return[select Id,Name,Clock_in_Location__c from Daily_Activity_Report__c 
                  where CreatedDate=Today AND OwnerID =: Userinfo.getUserId() order by CreatedDate DESC LIMIT 1];
        }
   
  
}