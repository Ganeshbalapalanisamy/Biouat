@isTest
public class worktimetriggercontrollerTest {

     @isTest
    static void Methodcheck()
    {
        Daily_Activity_Report__c ds=new Daily_Activity_Report__c();
              list<Daily_Activity_Report__c> dss=new list<Daily_Activity_Report__c>();
        
              ds.Name='Sowmya R';
              ds.Check_In_Time__c=System.Now();
              ds.Remarks__c='From test Method';
              insert ds;
        dss.add(ds);
              test.startTest(); 
        
              worktimetriggercontroller.setuserinfo(dss);
              test.stopTest(); 

    }
    
}