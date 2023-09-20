/* Trigger:PriceBookEntryTrigger
Class:PriceBookEntryTriggerHandler
TestClass:PriceBookEntryTriggerHandlerTest
Developer:Gowtham.K
Created Date : 26/06/2023*/
@isTest
public class PriceBookEntryTriggerHandlerTest {
    @isTest
    public static void insertPriceBookentry(){
        
       UserRole  usrRole=[SELECT Id, Name, DeveloperName FROM UserRole where Name=:'Portfolio Manager' Limit 1];
        User us=[Select Id,Name From User where UserRoleId=:usrRole.Id]; 
              BiomatiQ_Price_Book__c prbook=TestDataFactory.createPriceBook();
        
        System.Test.startTest();
       insert prbook;
        
        Product_Category__c prcat=TestDataFactory.createBrandProdCategory();
        prcat.Portfolio_Manager__c=us.id;
        insert prcat;
        
        
                Product__c p=TestDataFactory.createProduct();
        p.Sub_Category__c=prcat.id;
        insert p;
BiomatiQ_Book_Entry__c pbe=New BiomatiQ_Book_Entry__c();
        pbe.Product__c=p.Id;
        pbe.Biomatiq_Price_Book__c=prbook.Id;
        pbe.Active__c=true;
                     Database.SaveResult priceBookEntryResult = Database.insert(pbe, false);
        System.assert(priceBookEntryResult.isSuccess(), true);
        System.Test.stopTest();
    }
    
    
    @isTest
    public static void insertPriceBookentry2(){
        
       UserRole  usrRole=[SELECT Id, Name, DeveloperName FROM UserRole where Name=:'Portfolio Manager' Limit 1];
        User us=[Select Id,Name From User where UserRoleId=:usrRole.Id]; 
          BiomatiQ_Price_Book__c prbook1=TestDataFactory.createPriceBook();
        
              BiomatiQ_Price_Book__c prbook=TestDataFactory.createPriceBook();
         prbook.Is_Standard_Price_Book__c=false;
        prbook.Name='Custom';
        System.Test.startTest();
        insert prbook1;
       insert prbook;
        
        Product_Category__c prcat=TestDataFactory.createBrandProdCategory();
        prcat.Portfolio_Manager__c=us.id;
        insert prcat;
        
        
                Product__c p=TestDataFactory.createProduct();
        p.Sub_Category__c=prcat.id;
        insert p;
        
BiomatiQ_Book_Entry__c pbe=New BiomatiQ_Book_Entry__c();
        pbe.Product__c=p.Id;
        pbe.Biomatiq_Price_Book__c=prbook.Id;
        pbe.Active__c=true;
             Database.SaveResult priceBookEntryResult = Database.insert(pbe, false);
        System.assertEquals(priceBookEntryResult.isSuccess(), false);
        System.Test.stopTest();
    }
}