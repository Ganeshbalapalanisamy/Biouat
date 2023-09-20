@isTest
public class  LookupTest {
  
    static testmethod void Methodcheck()
    {
     
       Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';
        //acc.GST_Location__c='Intra State';
        insert acc;
        Contact con=New Contact();
        con.LastName='test';
        con.MobilePhone='1234567890';
        con.Email='test@gmail.com';
        con.AccountId=acc.Id;
        insert con;
        //Instrumentation divison
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Yet to Tap';opp.Opportunity_Product_Category__c='Instrumentation';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
        
        Biomatiq_Opportunity__c ord=new Biomatiq_Opportunity__c();
        ord.Close_Date__c=System.today().addDays(20);
        ord.Account_Name__c=acc.Id;ord.Opportunity__c=opp.Id;ord.Name='Test';
        insert ord;
        
        String strObjectName = 'Biomatiq_Opportunity__c';
        String strCompanyid =  ord.Account_Name__c;
        String searchTerm='';
        String filter='';
        
       // Lookup controller = new Lookup();
       
         Lookup.search('', strObjectName, '', strCompanyid);
         Lookup.search('', strObjectName, 'Contct', strCompanyid);
         Lookup.searchOpport('', 'BiomatiQ_Lead__c', '', acc.Id);
         Lookup.searchOpport('test', 'BiomatiQ_Lead__c', 'test', acc.Id);
       
     
    }
    
}