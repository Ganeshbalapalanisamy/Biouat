/*
     * Controller:newproductFormController
     * Test Class : newProdoctFormTest
     * LWC:newProductForm
    Created Date:
Last Modified date:27/06/2023*/

@IsTest
public class newProdoctFormTest {
 static testmethod void newProductLookup(){ 
     
        Product__c prod=TestDataFactory.createProduct();
        prod.Name='test';//prod.Brand_Name__c=brand.Id;
    // prod.Unit__c='Test';
    prod.HSN_Code__c='12345678';prod.SAC_Code__c='12345678';
     
     prod.Cat_No__c='TestCat';
          UserRole usRole=[SELECT Id, Name FROM UserRole where Name=:'Portfolio Manager' Limit 1];
     User us=[Select Id,Name From User Where UserRoleId=:usRole.Id];
     Product_Category__c pc=TestDataFactory.createBrandProdCategory();
    pc.Portfolio_Manager__c=us.Id;
     insert pc;
     prod.Sub_Category__c=pc.Id;
     insert prod;
     newproductFormController.fetchLookupData('Test','Product__c');
     newproductFormController.fetchLookupDataUnits('Test','Product__c');
     newproductFormController.fetchLookupDataSAC('Test','Product__c');
     newproductFormController.fetchSubCategoryRecord(pc.id);
  newproductFormController.fetchProductsByCatNo('TestCat');
     newproductFormController.fetchSubCategoryRecords('Test');
     newproductFormController.fetchLookupDataProdFamily('Test','Product__c');
}
}