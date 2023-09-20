@isTest
public class ReusableLookupControllerTest {
    
    @isTest
    Static void fetchRecordsTest(){
        User ur=[SELECT Id, Name, UserRole.Name FROM User where UserRole.Name='Portfolio Manager'];
        Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=ur.Id;
        insert pc;
        
        Product__c pro=TestDataFactory.createProduct();
        pro.Sub_Category__c=pc.id;
        insert pro;
        
       ReusableLookupController.SearchWrapper inputWrapper = new ReusableLookupController.SearchWrapper();
        inputWrapper.fieldApiName = 'Cat_No__c';
        inputWrapper.otherFieldApiName = 'Name';
        inputWrapper.objectApiName = 'Product__c';
        inputWrapper.searchString = 'test catg';
        
       List<ReusableLookupController.ResultWrapper> results = ReusableLookupController.fetchRecords(inputWrapper);
        
        System.assertEquals(1, results.size());
        System.assertEquals('test catg', results[0].mainField);
        System.assertEquals('test', results[0].subField);

        
    }
    
 
     @isTest
    Static void fetchRecordsTest1(){
        User ur=[SELECT Id, Name, UserRole.Name FROM User where UserRole.Name='Portfolio Manager'];
        Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=ur.Id;
        insert pc;
        
        Product__c pro=TestDataFactory.createProduct();
        pro.Sub_Category__c=pc.id;
        insert pro;
        
       ReusableLookupController.SearchWrapper inputWrapper = new ReusableLookupController.SearchWrapper();
        inputWrapper.fieldApiName = 'Cat_No__c';
        inputWrapper.otherFieldApiName = 'Name';
        inputWrapper.objectApiName = '';
        inputWrapper.searchString = 'test catg';
        
        
        try {
            List<ReusableLookupController.ResultWrapper> results = ReusableLookupController.fetchRecords(inputWrapper);
        } catch (AuraHandledException e) {
            // Test for the exception
            System.assertEquals('Script-thrown exception', e.getMessage());
        }
      
    }
    
    @isTest
    static void insertAccessoryTest(){
        User ur=[SELECT Id, Name, UserRole.Name FROM User where UserRole.Name='Portfolio Manager'];
        Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=ur.Id;
        insert pc;
        
        Product__c pro=TestDataFactory.createProduct();
        pro.Sub_Category__c=pc.id;
        insert pro;
        
       
         Product__c prod=new Product__c();
         prod.Brand_Picklist__c='Airwell';prod.Cat_No__c='test catg1';prod.SKU__c='Test';prod.Sub_Category__c=pc.Id;
         prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Equipment';prod.Tax_GST__c='12%';
        prod.Name='test1';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';prod.HSN_Code__c='123344';        
       
        insert prod;
        String accId=ReusableLookupController.insertAccessory(prod.Id,pro.Id);
        system.debug('accId==>'+accId);
        
        system.assertEquals(true,String.isNotBlank(accId));
        
     
        
    }
    
      @isTest
    static void insertAccessoryTest1(){
        User ur=[SELECT Id, Name, UserRole.Name FROM User where UserRole.Name='Portfolio Manager'];
        Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=ur.Id;
        insert pc;
        
        Product__c pro=TestDataFactory.createProduct();
        pro.Sub_Category__c=pc.id;
        insert pro;
        
       
         Product__c prod=new Product__c();
         prod.Brand_Picklist__c='Airwell';prod.Cat_No__c='test catg1';prod.SKU__c='Test';prod.Sub_Category__c=pc.Id;
         prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Equipment';prod.Tax_GST__c='12%';
        prod.Name='test1';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';prod.HSN_Code__c='123344';        
       
        insert prod;
       
      
        
         try {
            // Code that might throw an exception
            String accId=ReusableLookupController.insertAccessory(pro.Id,prod.Id);
        } catch (AuraHandledException e) {
            // Test for the exception
            System.assertEquals('Script-thrown exception', e.getMessage());
        }
        
     
        
    }

    
   

}