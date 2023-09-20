public class RepeatOrder {
    @AuraEnabled(Cacheable=True)
      public static Biomatiq_Opportunity__c  Orderinformation(Id OrderId){
          
         Biomatiq_Opportunity__c Ordlst = [SELECT Account_Name__c,Amount__c,Assigned_To__c,
                                           Budget_Confirmed__c,Close_Date__c,Com__c,
                                           Customer_Name__c,Customer_PO_No_Dt__c,
                                           Delivery__c,Del_Sch__c,Del_Size__c,
                                           Description__c,Discovery_Completed__c,
                                           Discovery__c,Div__c,Gen__c,Invoiceable_NO__c,
                                           Lead_Source__c,LF__c,Loss_Reason__c,
                                           Make__c,Man__c,Name,New_Probability__c,
                                           Next_Step__c,On_vendor_order_Details__c,
                                           Opportunity_Priority__c,Opportunity__c,
                                           Person1__c,Person2__c,Person3__c,Person4__c,
                                           Plan_Unplan__c,PO_Number__c,PO_Value__c,Priority__c,
                                           Quotation_Number__c,Repeat_New__c,ROI_Analysis_Completed__c,
                                           Sailor_Remarks__c,Sch_Order_Details__c,SO_Date__c,SO_Number__c,
                                           Stage_icon__c,Stage__c,S_No__c,Tech__c,Total__c,Type__c,Vendor_Number__c,
                                           Vendor_PO_No_Dt__c FROM Biomatiq_Opportunity__c where Id =:OrderId];   
          system.debug(Ordlst);
          return Ordlst;
          
    }

}