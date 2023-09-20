/*
 * Class Name : QuoteTriggerHandler
 * Test Class : QuoteTriggerHandlerTestClass
 * Trigger    : QuoteTrigger
 * Created Date : 21/06/2023
*/

@isTest
public class QuoteTriggerHandlerTestClass {
@testSetup
    public static void testSetupmethod(){
        User u=TestDataFactory.createUser('Managing Director');
    }
    
    @isTest
    Public static void createQuoteTest(){
        System.Test.startTest();
        User usr=[Select Id,Name From User Where Username=:'testuser@examplebiomatiq.com'];
         UserRole usRole=[SELECT Id, Name FROM UserRole where Name=:'Portfolio Manager' Limit 1];
         User portFolioUser=[SELECT Id, Name, Email, ManagerId FROM User WHERE UserRoleId=:usRole.Id Limit 1];
        Cluster__c clus=TestDataFactory.createCluster();
        clus.Sales_Person__c=usr.Id;
        insert clus;
        Account acc=TestDataFactory.createAccount();
        acc.Cluster__c=clus.Id;
        Insert acc;
        Contact con=TestDataFactory.createContact(acc.Id);
        insert con;
        
        BiomatiQ_Price_Book__c bpb=TestDataFactory.createPriceBook();
        insert bpb;
        
        BiomatiQ_Lead__c opp=TestDataFactory.createOpportunity(acc.Id, con.Id);
        insert opp;
 
        opp.Lead_Status__c='Technical Qualification';
        update opp;
    Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=portFolioUser.Id;
        insert pc;
        Product__c pr=TestDataFactory.createProduct();
        pr.Sub_Category__c=pc.Id;
        insert pr;
        Product_List__c pl=TestDataFactory.createProductList(pr.Id,opp.Id);
        
        insert pl;
        
            Quotes__c q=TestDataFactory.createQuote(opp.Id);
        Quotes__c q2=TestDataFactory.createQuote(opp.Id);
         Quotes__c q3=TestDataFactory.createQuote(opp.Id);
        System.Test.stopTest();
    }
}