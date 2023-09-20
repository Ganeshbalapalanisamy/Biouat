@istest()
public class RepeatOrdertestclass {
     static testmethod void setup(){
          
         Biomatiq_Opportunity__c ord=new Biomatiq_Opportunity__c();
         
    ord.Name='CTS';
   // ord.CreatedDate= Datetime.now().addDays(-90);
   // ord.Close_Date__c=Datetime.now().addDays(1);
    ord.Name='Test Phase 2';
    ord.Quotation_Number__c='312424';
         
       ord.Close_Date__c=Date.newInstance(2022, 12, 9);
    insert ord; 
      
    RepeatOrder.Orderinformation(ord.id);      
     }

}