/*
     * Controller:locationTrackerController
     * Test Class : LocationTrackerTest
    Created Date:
Last Modified date:06/05/2023*/

@IsTest
public class LocationTrackerTest {
@TestSetup
    public static void testsetupmethod(){
         User usr=TestDataFactory.createUser('Sales Executive');
    }
            static testmethod void LocationTrackerTest(){ 
                User usr=[Select Id,Name From User Where Username=:'testuser@examplebiomatiq.com' Limit 1];
                Cluster__c cl=TestDataFactory.createCluster();
                cl.Sales_Person__c=usr.Id;
              insert  cl;
                Account acc=TestDataFactory.createAccount();
                acc.Cluster__c=cl.Id;
        insert acc;
                
        Contact con=TestDataFactory.createContact(acc.id);
        insert con;
                BiomatiQ_Price_Book__c pbk=TestDataFactory.createPriceBook();
                insert pbk;
                
        //Instrumentation divison
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Yet to Tap';opp.Opportunity_Product_Category__c='Instrumentation';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
                
                
                Daily_Activity_Report__c wt=new Daily_Activity_Report__c();
         wt.Name='test';
         insert wt;
                
                	                   Visit_Management__c vm = new Visit_Management__c(); 
                   vm.Appointment_Visit_Scheduled_on__c=System.Datetime.now().addHours(2);
                
              
                vm.BiomatiQ_Lead__c=opp.Id;
                  vm.Company__c=acc.Id;
                //vm.Work_Time__c=wt.Id;
                vm.Visit_Suggestions_Comments__c='test';
                
                    System.test.startTest(); 
                insert vm;
locationTrackerController.setLocation1('Visit_Management__c','35','40',vm.Id,true);
               locationTrackerController.getvisitFieldValues(vm.Id);

                       System.test.stopTest(); 

            } 
    
     static testmethod void LocationTrackerTest1(){ 
                	 User usr=[Select Id,Name From User Where Username=:'testuser@examplebiomatiq.com' Limit 1];
                Cluster__c cl=TestDataFactory.createCluster();
                cl.Sales_Person__c=usr.Id;
              insert  cl;
                Account acc=TestDataFactory.createAccount();
                acc.Cluster__c=cl.Id;
        insert acc;
                
        Contact con=TestDataFactory.createContact(acc.id);
        insert con;
         
          BiomatiQ_Price_Book__c pbk=TestDataFactory.createPriceBook();
                insert pbk;
                
        //Instrumentation divison
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Yet to Tap';opp.Opportunity_Product_Category__c='Instrumentation';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
         
         Daily_Activity_Report__c wt=new Daily_Activity_Report__c();
         wt.Name='test';
         insert wt;
                
                
                	                   Visit_Management__c vm = new Visit_Management__c(); 
                vm.BiomatiQ_Lead__c=opp.Id;
         vm.Work_Time__c=wt.Id;
         vm.Company__c=acc.Id;
         
        vm.Appointment_Visit_Scheduled_on__c=System.Datetime.now().addHours(2);
                vm.Visit_Suggestions_Comments__c='test';
         vm.Check_In__c=System.Datetime.now();
         vm.Check_in_Location__Latitude__s=45;vm.Check_in_Location__Longitude__s=45;
                       System.test.startTest(); 
                insert vm;
                locationTrackerController.setLocation1('Visit_Management__c','45','45',vm.Id,false);
         String regexText='first error: (.*?), (.*?)$';
         String error='caused by: System.DmlException: Update failed. First exception on row 0 with id a020w000007xT3gAAE; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, Enter Todays or Future  Date: [Opportunity_Next_Follow_up__c]';
        locationTrackerController.splitStrings(regexText,error);
                       System.test.stopTest(); 

            } 

}