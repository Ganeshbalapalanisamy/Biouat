/*Apex:AttendanceOutBoundRest
 Helper apex:CustomExceptionIntegrationLogs
Test Class:CustomExceptionIntegrationLogsTest
 */ 

public class CustomExceptionIntegrationLogs {

    public static void integrationExceptionLog(String resBody,String JSONBody,String recId,String integrationError,String StatusCode,String msg,String statusVal){
        system.debug('inside error handler -->'+ resBody);
        //Response res = (Response)JSON.deserialize(resBody, Response.class);
        //system.debug('res -->'+ res);
        String trimJSONBody = null;
        if(JSONBody != null)
          trimJSONBody = JSONBody.length() > 100000 ? JSONBody.subString(0,100000) : JSONBody;
        Integration_Exception_Log__c obj = new Integration_Exception_Log__c();
        obj.Response__c = resBody !=null ? resBody : ''; 	
        obj.Request__c =   trimJSONBody != null ? trimJSONBody :'';
        obj.Integration_Name__c = integrationError != null ? integrationError:'';
        obj.Code__c =StatusCode!=null?StatusCode:'';
        obj.Status__c=statusVal!=null?statusVal:'';
        obj.Message__c=msg!=null?msg:'';
        obj.Exception_Work_Time__c=recId;
        if(integrationError=='Attendance Exception'){	
            obj.Type__c='HRMS - Attendance';
        }
        
       insert obj;  
    }
    
    
    /*public class Response{
        
        public string status;
        public string message;
        public ErrorResponseObject responceObject;

    }
    
    
    public class ErrorResponseObject{
        public Error error;
    }
    
    
    public class Error{
        public string code;
        public ErrorMessage message;
    }
    
    public class ErrorMessage{
        public string lang;
        public string value;
    }*/
    
    
}