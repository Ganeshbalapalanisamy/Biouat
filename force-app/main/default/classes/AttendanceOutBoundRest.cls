/*Apex Controller:AttendanceOutBoundRest
 * Trigger:AttendanceOutBoundRestTrigger
 * TestClass:EmployeeCheckinTestClass
*/
global class AttendanceOutBoundRest {
    @future(callout=true)
    
    global static void postPuchDetails(String employee_id,Datetime date_time,Decimal lattitude,Decimal longitude,String comments,String recId){
        
       
        User userDetail=[Select Id,Name,Domain__c,Employee_Id__c From User where Id=:employee_id ];
        String EmpNum=userDetail.Employee_Id__c;
        String Domain=userDetail.Domain__c;
        string EMP3Words=EmpNum.substring(0,3);
        string key;
        if(EMP3Words == 'BQS'){
            //BQS API:
             key=Label.BQS_Key;
            
        }else{
            //ESLE API:
             key=Label.ESLE_API_Key;
            
        }
          
        
        if(employee_id != null && lattitude != null && longitude != null){
            JSONGenerator gen= JSON.createGenerator(true);
            gen.writeStartObject();	
            if(EmpNum!=null){
            gen.writeStringField('employee_id',EmpNum);
            }
              gen.writeDateTimeField('date_time', date_time);
            gen.writeNumberField('latitude', lattitude);
            gen.writeNumberField('longitude',longitude);      
             gen.writeStringField('comments',comments);
            gen.writeEndObject(); 
            string json=gen.getAsString();
            system.debug('Json'+json);
            Blob headerValue=blob.valueOf(key);
            string authorizationHeader=Encodingutil.base64Encode(headerValue);
            string endpoint =Label.Attendance_Punch_Endpoint;
             //string endpoint ='https://staging.runtime.one/api/tpi/attendance/punch';
           
            HttpRequest req = new HttpRequest();
            req.setEndpoint(endpoint);
            req.setHeader('Authorization', key);
            req.setMethod('POST');
            req.setbody(json);
            req.setHeader('Content-type','application/json');
            Http http = new Http();
            HTTPResponse response = http.send(req);
            system.debug('response'+ response.getBody()+ response.getStatus()+ response.getStatusCode());
            
            ResponseWrapper wResp=(ResponseWrapper) System.JSON.deserialize(response.getBody(), ResponseWrapper.class);
            system.debug('wResp -->' + wResp);
            
            String StatusCode=String.valueOf(response.getStatusCode()) ;
			String statusVal=response.getStatus();
            String msg=wResp.message;
           // if(wResp.status == 'success'){
               if(response.getStatusCode() == 200){
                System.debug('Success');
                
            }
            else{
             CustomExceptionIntegrationLogs.integrationExceptionLog(response.getBody(),json,recId,'Attendance Exception',StatusCode,msg,statusVal);
            }
            
        }
       
    } 
    

    public class ResponseWrapper
    {
        public string status { get; set; }
        public string message { get; set; }
    } 


}