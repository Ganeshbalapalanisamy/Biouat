@isTest
public class OpportunitiesHandlerTest {
    
    @isTest
    static void contactBasedEmailPhoneTest(){
        
       Cluster__c clu=TestDataFactory.createCluster();
        clu.Sales_Person__c=Userinfo.getUserId();
       insert clu;
        
       Account acc=TestDataFactory.createAccount();
       acc.Territory__c='Telangana';
       acc.Cluster__c=clu.Id;
      
       insert acc;
        
       Contact con=TestDataFactory.createContact(acc.Id);
       con.Phone='1234567890';
       con.Designation__c='test';
       con.Department='Engineering';
       
        insert con;
       BiomatiQ_Price_Book__c pc=TestDataFactory.createPriceBook();
       insert pc;
        
       BiomatiQ_Lead__c opp=TestDataFactory.createOpportunity(acc.Id,con.Id);
        
        insert opp;
        
       Contact c = new Contact();
        c.LastName='test1';
        c.MobilePhone='1234567899';
        c.Email='test1@gmail.com';
        c.Department='Engineering';
        c.Designation__c='Test1';
        c.Phone='0987654321';
        c.AccountId=acc.Id;
       
        insert c;
        
        
        System.Test.startTest();
        
        opp.Contact__c=c.Id;
        update opp;
        
        
        System.Test.stopTest();
        
    }

}