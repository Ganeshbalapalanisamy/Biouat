public class Companydetailautofetch {
    @AuraEnabled(Cacheable=True)
      public static Account  companyinformation(ID RecordID){
             Account lstAccs = [SELECT Id,Name,Phone,Cluster__c,Cluster__r.Name,Cluster__r.States__c,Cluster__r.Bio_Billing_State__c,Territory__c,State__c,Country__c, (SELECT Id,Name,AccountId FROM Contacts) FROM Account WHERE ID = : RecordID]; 
             system.debug(lstAccs);
             return lstAccs;
       
    }
    @AuraEnabled(Cacheable=True)
      public static List<Contact> contactList(ID accountIds){
          
         List<Contact> conlist = [SELECT Id,Name,AccountId FROM Contact where AccountId =:accountIds];
       
          system.debug(conlist);
          
          return conlist;    
    }
     @AuraEnabled(cacheable=true)
    public static Contact conlists(Id conatctId){
        Contact prodresult = [SELECT Name,AccountId,Account.Phone,Account.Territory__c,Account.Cluster__c,Account.State__c,Account.Country__c,MobilePhone,Email,Department__c,Designation__c FROM Contact where Id =:conatctId];
        System.debug(prodresult);
        return prodresult;
    }
     @AuraEnabled
      public static BiomatiQ_Lead__c  companyOppInsert(Id companyId,string comPhone,string country,string state,Id contactId,string mobile,
                                              string Email,string Designation,string Department,string oppSource,string refcolleague,string refCompanyName,string Revival,string oppstage,string Rating,
                                             string domain,string division,string product,Decimal oppValue,string actionable,
                                             string remarks,Date oppFollowup,Date oppClose,string clusterName){
   
           BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
           opp.Company_Name__c=companyId;
           opp.Phone__c=comPhone;
           opp.Country__c=country;                          
           opp.Territory__c=state; 
           opp.Contact__c=contactId;
           opp.Mobile__c=mobile;
           opp.Email__c=Email;
           opp.Designation__c=Designation;
           opp.Department__c=Department;
           opp.Lead_Source__c=oppSource;
           opp.Reffererl_through_Colleague__c=refcolleague;
           opp.Referral_Company_Name__c=refCompanyName;
           opp.Revival__c=Revival;
           opp.Opportunity_Stage__c=oppstage;
           opp.Rating__c=Rating;
         
          
           opp.Domain__c=domain;
           opp.Opportunity_Product_Category__c=division;
           opp.Product_Category_Model_Discussed__c=product;
           opp.Value__c=oppValue;
           opp.Actionables__c=actionable;
           opp.Opportunity_Specific_Remarks__c=remarks;
           opp.Opportunity_Next_Follow_up__c=oppFollowup;
           opp.Opportunity_Closing__c=oppClose;
           opp.Cluster_Lookup__c=clusterName;
                                                
           system.debug('opp====>'+opp);
           try {
                 insert opp;
           } catch (DmlException ex) {
           // Handle the DML exception
            System.debug('Error occurred on LineNumer '+ ex.getLineNumber()+ ': ' + ex.getMessage()+ex.getStackTraceString());
            throw new AuraHandledException(ex.getMessage());
           
           }
           
           return opp;
       
    }
    
    @AuraEnabled(Cacheable=true)
    public static List<Cluster__c> clusterlists(String stateValue){
        if(stateValue !=null){
             List<Cluster__c> clusterList = [SELECT Id,Name,Sales_Person__c,States__c FROM Cluster__c where States__c=:stateValue];
             System.debug(clusterList);
             return clusterList;
        }else{
            return null;
        }
       
    }
     
}