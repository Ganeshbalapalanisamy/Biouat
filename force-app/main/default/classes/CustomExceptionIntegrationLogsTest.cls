/*Apex:AttendanceOutBoundRest
 Helper apex:CustomExceptionIntegrationLogs
Test Class:CustomExceptionIntegrationLogsTest
 */ 

@isTest 
public class CustomExceptionIntegrationLogsTest {

   @isTest 
    static void validateHelloWorld() {
        
        Daily_Activity_Report__c ds=new Daily_Activity_Report__c();
              
              ds.Name='test';
              ds.Check_In_Time__c=System.Now();
              ds.Remarks__c='From test Method';
              insert ds;
        String resBody='test';
        String JSONBody='test json';String recId=ds.Id;String integrationError='Attendance Exception';String StatusCode='200';
        String msg='test';String statusVal='test';
       System.test.startTest();
        CustomExceptionIntegrationLogs.integrationExceptionLog(resBody,JSONBody,recId,integrationError,StatusCode,msg,statusVal);
        System.test.stopTest();
    }
}