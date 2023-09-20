@isTest
public class EmployeeCheckoutTestClass {
   @isTest
          static void checkouttest()
          {
              Daily_Activity_Report__c ds=new Daily_Activity_Report__c();
               ds.Name = 'Test Class 2';
              ds.Remarks__c='Nothing';
              insert ds;
              test.startTest(); 
              Employeecheckoutcontroll.setCheckout('Daily_Activity_Report__c',ds.Id);
              test.stopTest(); 
          }
}