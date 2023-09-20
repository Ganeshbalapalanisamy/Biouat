@isTest
public class VisitTriggerHandlerTest {
    
    @isTest
    public static void visitReportTest(){
        
        Account acc=new Account();
        acc.Name='test1';
        insert acc;
        
         BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        
        opp.Company_Name__c=acc.Id;
        opp.Opportunity_Stage__c='Yet to Tap';
        opp.Lead_Source__c='Organic - Direct visit';
        opp.Opportunity_Product_Category__c='Microbiology Solutions';
        opp.Actionables__c='Demo Required';
        opp.Opportunity_Specific_Remarks__c='test';
        opp.Opportunity_Next_Follow_up__c=system.today();
        opp.Opportunity_Closing__c=system.today().addDays(5);
        
        insert opp;
        
        List<Visit_Management__c> vmList=new List<Visit_Management__c>();
      
        for(Integer i=0; i<=2; i++){
             Visit_Management__c vm=new Visit_Management__c();
             vm.Company__c=acc.Id;
             vm.Checkbox__c=false;
            vm.Appointment_Visit_Scheduled_on__c=System.Datetime.now().addHours(2);
             vm.BiomatiQ_Lead__c=opp.Id;
             
        vmList.add(vm);
        
        }
       
        insert vmList;
        
        List<Visit_Management__c> visitmList=[select Id,Name,Company__c,Checkbox__c,Appointment_Visit_Scheduled_on__c from Visit_Management__c where Company__c=:acc.Id];
        List<Visit_Management__c> visitmList1=new List<Visit_Management__c>();
        for(Visit_Management__c v:visitmList){
            
            v.Id=v.Id;
            V.Check_In__c=System.Datetime.now();
            v.Visit_Suggestions_Comments__c='test';
            V.Check_Out__c=System.Datetime.now().addHours(5);
            
            v.Checkbox__c=true;
           // v.Appointment_Visit_Scheduled_on__c=System.Datetime.now().addHours(2);
            visitmList1.add(v);
        }
        
        update visitmList1;
        
        
        // VisitTriggerHandler.visitReport(vmList);
        
        
    }

}