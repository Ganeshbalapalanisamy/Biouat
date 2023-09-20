@isTest
public class ProductTriggerTest {
    
    
    @isTest
    static void productTest(){
        User ur=[SELECT Id, Name, UserRole.Name FROM User where UserRole.Name='Portfolio Manager'];
        Product_Category__c pc1=TestDataFactory.createBrandProdCategory();
        pc1.Portfolio_Manager__c=ur.Id;
        insert pc1;
        
        Product__c pro=TestDataFactory.createProduct();
        pro.Sub_Category__c=pc1.id;
        insert pro;
        
        Product_Category__c pc = New Product_Category__c();
        pc.Principal__c='Airwell';pc.Brand_Name__c='Airwell';pc.Segment__c='Laboratory Equipment';pc.Category__c='General Laboratory instruments';pc.Sub_Category__c='Furnaces';
        pc.Agreement__c='No';pc.Brand_Contact_Person__c='Test Contact person';pc.Brand_Contact_Person_Email__c='TestContactperson@gmail.com'; pc.Portfolio_Manager__c=ur.Id;
        pc.Sales_Executive_Discount__c=10;pc.Area_Sales_Manager_Discount__c=15;pc.Regional_Sales_Manager_Discount__c=20;pc.Outside_Sales_Director_Discount__c=25;
        pc.Portfolio_Manager_Discount__c=30;pc.Managing_Director_Discount__c=35; 
        
       insert pc;
        
       pro.Sub_Category__c=pc.id;
        
       update pro;
        
    }

}