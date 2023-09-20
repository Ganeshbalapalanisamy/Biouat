/*Trigger Name: BrandProductCategoryTrigger
     * Controller:BrandProductCategoryTriggerHandler
     * Test Class : BrandProductCategoryTriggerHandlerTest
    Created Date:05/06/2023*/
@isTest
public class BrandProductCategoryTriggerHandlerTest {
    @TestSetup
      public static void createUser() {
      UserRole usRole=[SELECT Id, Name FROM UserRole where Name=:'Portfolio Manager' Limit 1];
         User Salesusr=[SELECT Id, Name, Email, ManagerId FROM User WHERE UserRoleId=:usRole.Id ];
        User usr=[SELECT Id, Name, Email, UserRoleId,ProfileId FROM User WHERE Id=:UserInfo.getUserId() ];
     User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Username = 'testuser@examplebiomatiq.com',
            Email = 'testuser@example.com',
            UserRoleId = usRole.Id,
             ManagerId=Salesusr.ManagerId,
            ProfileId = usr.ProfileId,  // Specify the desired profile ID
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;
}
    @isTest
    public static void insertBrandProdCategory(){
        User us=[Select Id,Name From user where Username=:'testuser@examplebiomatiq.com' Limit 1];
        Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=us.Id;
        insert pc;
        Product__c pr=TestDataFactory.createProduct();
        pr.Sub_Category__c=pc.Id;
        System.Test.startTest();
        insert pr;
        Product_Category__c pc1=new Product_Category__c();
        pc1.id=pc.id;
        pc1.Activate__c=false;
        Update pc1;
            System.Test.stopTest();
    }
   

}