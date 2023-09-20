public class newContactOppForm {

     @AuraEnabled(cacheable=true)
    public static Contact conlists(Id conatctId){
        Contact prodresult = [SELECT Name,AccountId,Account.Phone,Account.Territory__c,MobilePhone,Email,Department__c,Designation__c FROM Contact where Id =:conatctId];
        System.debug(prodresult);
        return prodresult;
    }
     @AuraEnabled(Cacheable=True)
      public static Account  companyinformation(ID RecordID){
             Account lstAccs = [SELECT Id,Name,Phone,Territory__c, (SELECT Id,Name,AccountId FROM Contacts) FROM Account WHERE ID = : RecordID]; 
             system.debug(lstAccs);
             return lstAccs;
       
    }
     @AuraEnabled
      public static BiomatiQ_Lead__c  contactOppInsert(Id companyId,string comPhone,string state,string clusters,Id contactId,string mobile,
                                              string Email,string Designation,string Department,string oppSource,string refcolleague,string refCompanyName,string Revival,string oppstage,string Rating,
                                              string timeToAction,string priority,string domain,string division,string Instrumentation,
                                             string regularEssentials,string specialtyProducts,string product,Decimal oppValue,string actionable,
                                             string remarks,Date oppFollowup,Date oppClose){
             
           system.debug('companyId==>'+companyId+'comPhone==>'+comPhone+'state==>'+state+' clusters==>'+ clusters+'contactId==>'+contactId+'refCompanyName==>'+refCompanyName+'Revival==>'+Revival+
                       'mobile==>'+mobile+'Email==>'+Email+' Designation==>'+ Designation+'Department==>'+Department+'oppSource==>'+oppSource+'Rating==>'+Rating+
                       'timeToAction==>'+timeToAction+'priority==>'+priority+'refcolleague==>'+refcolleague+'domain==>'+domain+'division==>'+division+
                      'Instrumentation==>'+Instrumentation+'regularEssentials==>'+regularEssentials+'specialtyProducts==>'+specialtyProducts+'product==>'+product+
                      'oppValue==>'+oppValue+'actionable==>'+actionable+'remarks==>'+remarks+'oppFollowup==>'+oppFollowup+'oppClose==>'+oppClose);
           BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
           opp.Company_Name__c=companyId;
           opp.Phone__c=comPhone;
           opp.Territory__c=state;
           //opp.Clusters__c=clusters;
           opp.Contact__c=contactId;
           opp.Mobile__c=mobile;
           opp.Email__c=Email;
           opp.Designation__c=Designation;
           opp.Department__c=Department;
           opp.Lead_Source__c=oppSource;
          // opp.Referral_through_Colleague_name__c=refcolleague;
           opp.Referral_Company_Name__c=refCompanyName;
          //opp.Revival_Name__c=Revival;
           opp.Opportunity_Stage__c=oppstage;
           opp.Rating__c=Rating;
           opp.Urgent__c=timeToAction;
          // opp.Opportunity_Time_to_Action__c=priority;
          
           opp.Domain__c=domain;
           opp.Opportunity_Product_Category__c=division;
           opp.Instrument_Brands_Lead__c=Instrumentation;
           opp.Regular_Brands_Lead__c=regularEssentials;
           opp.Speciality_Brands_Lead__c=specialtyProducts;
           opp.Product_Category_Model_Discussed__c=product;
           opp.Value__c=oppValue;
           opp.Actionables__c=actionable;
           opp.Opportunity_Specific_Remarks__c=remarks;
           opp.Opportunity_Next_Follow_up__c=oppFollowup;
           opp.Opportunity_Closing__c=oppClose;
            
                                                  
           insert opp;
           system.debug('opp====>'+opp);
           
return opp;
       
    }

}