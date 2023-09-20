public class existingopportunity {
  @AuraEnabled(Cacheable=True)
    public static BiomatiQ_Lead__c opportunityinformation(ID RecordID){
       BiomatiQ_Lead__c oppList= [SELECT Actionables__c,Phone__c,Company_Name__c,Contact__c,
            Department__c,Designation__c,
            Domain__c,Email__c,Instrument_Brands_Lead__c,
            Lead_Source__c,Lead_Status__c,Mobile__c,Name,Opportunity_Closing__c,
            Opportunity_Next_Follow_up__c,Opportunity_Product_Category__c,Opportunity_Specific_Remarks__c,
            Owner__c,PONumber__c,
            Product_Category_Model_Discussed__c,QuoteNumber__c,Rating__c,
            Referral_Company_Name__c,Reffererl_through_Colleague__c,
            Regular_Brands_Lead__c,Remarks_for_Lost__c,Remarks__c,Revival__c,Country__c,Cluster_Lookup__c,Territory__c,
            Speciality_Brands_Lead__c,Opportunity_Stage__c,Branch__c,
            Task_Completed__c,Urgent__c,Value__c,Website__c FROM BiomatiQ_Lead__c where Id=:RecordID];
        system.debug('existingopportunity'+ oppList);
        return oppList;
        
    }
    
    @AuraEnabled
    public static void updateVisitRec(ID visitId,string Status,String OppName){
        Visit_Management__c vmRec=[Select Id,Opportunities_Closed_Won_Lost__c from Visit_Management__c where id=:visitId];
        Visit_Management__c vm=New Visit_Management__c();
        vm.Id=visitId;
        
        System.debug('Status'+Status);
        if(vmRec.Opportunities_Closed_Won_Lost__c!=null){
            System.debug('Status1'+Status);
        vm.Opportunities_Closed_Won_Lost__c=vmRec.Opportunities_Closed_Won_Lost__c+'\n'+OppName+'-'+Status;
        }
        else{
            vm.Opportunities_Closed_Won_Lost__c=OppName+'-'+Status;
        }
        update vm;
    }
}