@IsTest
public class Companydetailfetchtest {
   
    static testmethod void  setup(){
         List<User> usrlist=[Select Id,Name From User where IsActive=:true Limit 2];
          String usr1=usrlist[0].Id;
          String usr2=usrlist[1].Id;
    Cluster__c cls=TestDataFactory.createCluster();
        cls.Sales_Person__c=usr2;
        insert cls;
    Account test=TestDataFactory.createAccount();
        test.Cluster__c=cls.Id;
    insert test; 
    Companydetailautofetch.companyinformation(test.Id);      

    }
   static testmethod void  setup1(){
       
           Contact con=new contact();
        con.LastName='prakash';
        
        con.Email='rajsaran1027@gmail.com';
        con.MobilePhone='8907654321';
        con.Phone='9566524873';
        insert con;
          Companydetailautofetch.conlists(con.Id); 
       
       
}
    
      static testmethod void  setup2(){
         
           List<User> usrlist=[Select Id,Name From User where IsActive=:true Limit 2];
          String usr1=usrlist[0].Id;
          String usr2=usrlist[1].Id;
        Cluster__c cls=TestDataFactory.createCluster();
          cls.Sales_Person__c=usr2;
        insert cls;
           Account test1=TestDataFactory.createAccount();
          test1.Cluster__c=cls.Id;
          insert test1; 
          
           Contact con1=TestDataFactory.createContact(test1.Id);
        insert con1;
          
          Companydetailautofetch.contactList(con1.Id); 
       

      }
    
     static testmethod void  OpportunityInsert(){
          
            List<User> usrlist=[Select Id,Name From User where IsActive=:true Limit 2];
          String usr1=usrlist[0].Id;
          String usr2=usrlist[1].Id;
         
          Cluster__c cls=TestDataFactory.createCluster();
cls.Sales_Person__c=usr2;
         insert cls;
         
     Account test1=TestDataFactory.createAccount();
         test1.Cluster__c=cls.Id;
    insert test1; 
          
           Contact con1=TestDataFactory.createContact(test1.Id);
        insert con1;  
         
         
        BiomatiQ_Price_Book__c bpb=TestDataFactory.createPriceBook();
         insert bpb;
         
    BiomatiQ_Lead__c test=TestDataFactory.createOpportunity(test1.Id, con1.Id);
    test.Company_Name__c=test1.Id;
    test.Lead_Source__c='Organic - Direct visit';
         test.Opportunity_Stage__c='Yet to Tap';
         test.Opportunity_Product_Category__c='Instrumentation';
         test.Actionables__c='Demo Required';
         test.Opportunity_Next_Follow_up__c=System.today()+1;
         test.Opportunity_Specific_Remarks__c='test';
         test.Opportunity_Closing__c=System.today()+2;
           test.Country__c='India';
         test.Territory__c='Telangana';
         test.Cluster_Lookup__c=cls.Id;
         test.Phone__c='9566524873';
         test.Contact__c=con1.Id;
        test.Mobile__c='9566524873';
         test.Email__c='rajsaran1027@gmail.com';
         test.Department__c='Engineering';
         test.Designation__c='test';
         test.Rating__c='Cold';	
         test.Domain__c='Biomatiq';
         test.Product_Category_Model_Discussed__c='test';
         test.Value__c=1000;
         test.Reffererl_through_Colleague__c=null;
         test.Referral_Company_Name__c='test';test.Revival__c=null;
         
    //insert test;
    Companydetailautofetch.clusterlists(cls.States__c);
   Companydetailautofetch.companyOppInsert(test1.Id,test.Phone__c,test.Country__c,test.Territory__c,test.Contact__c,test.Mobile__c,
                                               test.Email__c,test.Designation__c,test.Department__c,test.Lead_Source__c,test.Reffererl_through_Colleague__c,test.Referral_Company_Name__c,test.Revival__c,test.Opportunity_Stage__c,test.Rating__c,
                                              test.Domain__c,test.Opportunity_Product_Category__c,
                                            test.Product_Category_Model_Discussed__c,test.Value__c,test.Actionables__c,
                                             test.Opportunity_Specific_Remarks__c,test.Opportunity_Next_Follow_up__c,test.Opportunity_Closing__c,test.Cluster_Lookup__c);      

    }
       
   }