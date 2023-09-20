@isTest
global class EmployeeCheckinTestClass  implements HttpCalloutMock{
   
    
         global HTTPResponse respond(HTTPRequest req) {
        // Optionally, only send a mock response for a specific endpoint
        // and method.
        System.assertEquals('https://hrm-in1.runtime.one/api/tpi/attendance/punch', req.getEndpoint());
        System.assertEquals('POST', req.getMethod());
        
        // Create a fake response
        HttpResponse res = new HttpResponse();	
        res.setHeader('Content-Type', 'application/json');
        res.setBody('{"example":"test"}');
        res.setStatusCode(200);
        return res;
    }
          @isTest  static  void checkintest()
          {
              System.test.startTest(); 
              
                System.Test.setMock(HttpCalloutMock.class, new EmployeeCheckinTestClass());
              EmployeeCheckinandCheckoutController.setCheckin('Daily_Activity_Report__c','35','33');
              System.test.stopTest(); 
             
          }

            @isTest static  void checkOuttest()
          { 
              Daily_Activity_Report__c ds=new Daily_Activity_Report__c();
              
              ds.Name='Sowmya R';
              ds.Check_In_Time__c=System.Now();
              ds.Remarks__c='From test Method';
              insert ds;
              System.test.startTest(); 
              System.Test.setMock(HttpCalloutMock.class, new EmployeeCheckinTestClass());
              EmployeeCheckinandCheckoutController.setCheckout('Daily_Activity_Report__c','35','33');
              System.test.stopTest(); 
          }

}