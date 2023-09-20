/*Trigger Name: ProductListTrigger
     * Controller:ProductListTriggerHandler
     * Test Class : ProductListTriggerHandlerTest
    Created Date: 19/5/2023*/
@isTest
public class ProductListTriggerHandlerTest {
    
    
     @testSetup
    static void setupTestData() {
        
        UserRole usRole=[SELECT Id, Name FROM UserRole where Name='Sales Executive' Limit 1];
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

    @isTest  public static void prodtListInsert(){
         
       
        System.Test.startTest();
         Cluster__c clr=new Cluster__c();
         clr.Name='Test1';clr.Country__c='India';clr.States__c='Tamil Nadu';clr.Sales_Person__c=userinfo.getUserId();clr.Branch__c='Bangalore';clr.Bio_Billing_State__c='Karnataka';
         insert clr;
        Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';acc.ShippingState='Tamil Nadu';acc.BillingState='Tamil Nadu';
        acc.Class__c='A - 45 days credit without followup';acc.GST_Treatment__c='SEZ Developer';/*acc.Deemed_Export__c='1%';*/acc.Country__c='India';acc.Territory__c='Tamil Nadu';acc.Cluster__c=clr.Id;
         insert acc;
        Contact con=New Contact();
        con.LastName='test';
        con.MobilePhone='1234567890';
        con.Email='test@gmail.com';
        con.AccountId=acc.Id;
        insert con;
        
       BiomatiQ_Price_Book__c pc1=TestDataFactory.createPriceBook();
       insert pc1;
   
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Yet to Tap';opp.Opportunity_Product_Category__c='Instrumentation';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
        
         User u=[SELECT Id, Name, Email, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
         Product_Category__c pc=New Product_Category__c();
         pc.Principal__c='VWR';pc.Brand_Name__c='AGME';pc.Segment__c='Microbiology Solutions';
         pc.Category__c='Culture Media';pc.Sub_Category__c='Ready To Use Media';pc.Agreement__c='No';
        pc.Sales_Executive_Discount__c=5;
         pc.Area_Sales_Manager_Discount__c=10;pc.Regional_Sales_Manager_Discount__c=15;pc.Outside_Sales_Director_Discount__c=20;
         pc.Managing_Director_Discount__c=30;pc.Portfolio_Manager__c=u.Id;
         pc.Brand_Contact_Person__c='test';pc.Brand_Contact_Person_Email__c='test@gmail.com';
         insert pc;
        
         Exclusivity__c exc=New Exclusivity__c();
         exc.Brand_Product_Category__c=pc.Id;exc.Account_Wise_Exclusivity__c=acc.Id;
         exc.Dealing_Through__c=opp.Domain__c;
         insert exc;

         
        
         Product__c prod=new Product__c();
         prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
         prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';prod.HSN_Code__c='12345678';prod.SAC_Code__c='87654321';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';
        insert prod;
        
        
        Product_List__c pl=new Product_List__c();
        pl.Opportunity__c=opp.id;
        pl.Product__c=prod.id;
        pl.Sub_Category__c=pc.id;
        pl.Brand_Name_Text__c=pc.Brand_Name__c;
        
        insert pl;
        
         Product_List__c pl1=new Product_List__c();
        pl1.id=pl.id;
        pl1.Quantity__c=5;
        pl1.Discount__c=40;
        
        update pl1;
        
        System.Test.stopTest();
        
    }
    
    
    
     @isTest 
    public static void prodtListInsertTestMethod3(){
        UserRole usRole=[SELECT Id, Name FROM UserRole where Name='Regional Sales Manager' Limit 1];
        User usr=[SELECT Id, Name, Email, UserRoleId FROM User WHERE UserRoleId=:usRole.Id Limit 1];
         
         User testUser = [SELECT Id FROM User WHERE Username = 'testuser@examplebiomatiq.com' LIMIT 1];
    
   
         System.runAs(testUser){
        System.Test.startTest();
         Cluster__c clr=new Cluster__c();
         clr.Name='Test1';clr.Country__c='India';clr.States__c='Tamil Nadu';clr.Sales_Person__c=usr.Id;clr.Branch__c='Bangalore';clr.Bio_Billing_State__c='Karnataka';
         insert clr;
        Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';acc.ShippingState='Tamil Nadu';acc.BillingState='Tamil Nadu';
        acc.Class__c='C - Above 90 days credit or Poor payment';acc.GST_Treatment__c='SEZ Developer';/*acc.Deemed_Export__c='1%';*/acc.Country__c='India';acc.Territory__c='Tamil Nadu';acc.Cluster__c=clr.Id;
         insert acc;
        Contact con=New Contact();
        con.LastName='test';
        con.MobilePhone='1234567890';
        con.Email='test@gmail.com';
        con.AccountId=acc.Id;
        insert con;

       BiomatiQ_Price_Book__c pc1=TestDataFactory.createPriceBook();
       insert pc1;     
             
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Yet to Tap';opp.Opportunity_Product_Category__c='Instrumentation';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
   
        
         User u=[SELECT Id, Name, Email, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
         Product_Category__c pc=New Product_Category__c();
         pc.Principal__c='VWR';pc.Brand_Name__c='AGME';pc.Segment__c='Microbiology Solutions';
         pc.Category__c='Culture Media';pc.Sub_Category__c='Ready To Use Media';pc.Agreement__c='No';
         pc.Sales_Executive_Discount__c=5;
         pc.Area_Sales_Manager_Discount__c=10;pc.Regional_Sales_Manager_Discount__c=15;pc.Outside_Sales_Director_Discount__c=20;
         pc.Managing_Director_Discount__c=30;pc.Portfolio_Manager__c=u.Id;
         pc.Brand_Contact_Person__c='test';pc.Brand_Contact_Person_Email__c='test@gmail.com';
         insert pc;
        
         Exclusivity__c exc=New Exclusivity__c();
         exc.Brand_Product_Category__c=pc.Id;exc.Account_Wise_Exclusivity__c=acc.Id;
         exc.Dealing_Through__c=opp.Domain__c;
         insert exc;

         
        
         Product__c prod=new Product__c();
         prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
         prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';prod.HSN_Code__c='12345678';prod.SAC_Code__c='87654321';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';
        insert prod;
        
     
        Product_List__c pl=new Product_List__c();
        pl.Opportunity__c=opp.id;
        pl.Product__c=prod.id;
        pl.Sub_Category__c=prod.Sub_Category__c;
        pl.Brand_Name_Text__c=prod.Brand_Picklist__c;
        
        insert pl;
        
         Product_List__c pl1=new Product_List__c();
        pl1.id=pl.id;
        pl1.Quantity__c=5;
        pl1.Discount__c=20;
        
        update pl1;
         
        
        System.Test.stopTest();
         }
    }
    
    
     @isTest  public static void prodtListInsertTestMethod2(){
        UserRole usRole=[SELECT Id, Name FROM UserRole where Name='Sales Executive' Limit 1];
        User usr=[SELECT Id, Name, Email, UserRoleId,ManagerId FROM User WHERE UserRoleId=:usRole.Id Limit 1];
         
        

         System.runAs(usr) {
        System.Test.startTest();
         Cluster__c clr=new Cluster__c();
         clr.Name='Test1';clr.Country__c='India';clr.States__c='Tamil Nadu';clr.Sales_Person__c=usr.Id;clr.Branch__c='Bangalore';clr.Bio_Billing_State__c='Karnataka';
         insert clr;
        Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';acc.ShippingState='Tamil Nadu';acc.BillingState='Tamil Nadu';
        acc.Class__c='D - New Customers';acc.GST_Treatment__c='SEZ Developer';/*acc.Deemed_Export__c='1%';*/acc.Country__c='India';acc.Territory__c='Tamil Nadu';acc.Cluster__c=clr.Id;
         insert acc;
        Contact con=New Contact();
        con.LastName='test';
        con.MobilePhone='1234567890';
        con.Email='test@gmail.com';
        con.AccountId=acc.Id;
        insert con;
        
        BiomatiQ_Price_Book__c pc1=TestDataFactory.createPriceBook();
       insert pc1; 
             
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Yet to Tap';opp.Opportunity_Product_Category__c='Laboratory Consumables';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
   
        
         User u=[SELECT Id, Name, Email, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
         Product_Category__c pc=New Product_Category__c();
         pc.Principal__c='VWR';pc.Brand_Name__c='AGME';pc.Segment__c='Microbiology Solutions';
         pc.Category__c='Culture Media';pc.Sub_Category__c='Ready To Use Media';pc.Agreement__c='No';
        pc.Sales_Executive_Discount__c=5;
         pc.Area_Sales_Manager_Discount__c=10;pc.Regional_Sales_Manager_Discount__c=15;pc.Outside_Sales_Director_Discount__c=20;
         pc.Managing_Director_Discount__c=30;pc.Portfolio_Manager__c=u.Id;
         pc.Brand_Contact_Person__c='test';pc.Brand_Contact_Person_Email__c='test@gmail.com';
         insert pc;
        
         Exclusivity__c exc=New Exclusivity__c();
         exc.Brand_Product_Category__c=pc.Id;exc.Account_Wise_Exclusivity__c=acc.Id;
         exc.Dealing_Through__c=opp.Domain__c;
         insert exc;

         
        
         Product__c prod=new Product__c();
         prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
         prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';prod.HSN_Code__c='12345678';prod.SAC_Code__c='87654321';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';
        insert prod;
        
     
        Product_List__c pl=new Product_List__c();
        pl.Opportunity__c=opp.id;
        pl.Product__c=prod.id;
        pl.Sub_Category__c=prod.Sub_Category__c;
        pl.Brand_Name_Text__c=prod.Brand_Picklist__c;
        
        insert pl;
        
         Product_List__c pl1=new Product_List__c();
        pl1.id=pl.id;
        pl1.Quantity__c=5;
        pl1.Discount__c=30;
        
        update pl1;
         
        
        System.Test.stopTest();
         }
    }
    


 @isTest  public static void prodtListInsertTestMethod4(){
     UserRole usRole=[SELECT Id, Name FROM UserRole where Name='Area Sales Manager' Limit 1];
        User usr=[SELECT Id, Name, Email, UserRoleId,ManagerId FROM User WHERE UserRoleId=:usRole.Id Limit 1];
  
        User usrAdmin=[SELECT Id, Name, Email, UserRoleId,ProfileId FROM User WHERE Id=:UserInfo.getUserId() ];
           User testUser = new User(
            FirstName = 'Test',
            LastName = 'User',
            Username = 'testuser1@examplebiomatiq.com',
            Email = 'testuser1@example.com',
            UserRoleId = usRole.Id,
             ManagerId=usr.ManagerId,
            ProfileId = usrAdmin.ProfileId,  // Specify the desired profile ID
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;
     
        
     System.runAs(testUser){
        System.Test.startTest();
         Cluster__c clr=new Cluster__c();
         clr.Name='Test1';clr.Country__c='India';clr.States__c='Tamil Nadu';clr.Sales_Person__c=usr.Id;clr.Branch__c='Bangalore';clr.Bio_Billing_State__c='Karnataka';
         insert clr;
        Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';acc.ShippingState='Tamil Nadu';acc.BillingState='Tamil Nadu';
        acc.Class__c='B - 90 days credit without followup';acc.GST_Treatment__c='SEZ Developer';/*acc.Deemed_Export__c='1%';*/acc.Country__c='India';acc.Territory__c='Tamil Nadu';acc.Cluster__c=clr.Id;
         insert acc;
        Contact con=New Contact();
        con.LastName='test';
        con.MobilePhone='1234567890';
        con.Email='test@gmail.com';
        con.AccountId=acc.Id;
        insert con;
        
         BiomatiQ_Price_Book__c pc1=TestDataFactory.createPriceBook();
       insert pc1;
         
         BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Yet to Tap';opp.Opportunity_Product_Category__c='Laboratory Equipment';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
   
        
         User u=[SELECT Id, Name, Email, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
         Product_Category__c pc=New Product_Category__c();
         pc.Principal__c='VWR';pc.Brand_Name__c='AGME';pc.Segment__c='Microbiology Solutions';
         pc.Category__c='Culture Media';pc.Sub_Category__c='Ready To Use Media';pc.Agreement__c='No';
        pc.Sales_Executive_Discount__c=5;
         pc.Area_Sales_Manager_Discount__c=10;pc.Regional_Sales_Manager_Discount__c=15;pc.Outside_Sales_Director_Discount__c=20;
         pc.Managing_Director_Discount__c=30;pc.Portfolio_Manager__c=u.Id;
         pc.Brand_Contact_Person__c='test';pc.Brand_Contact_Person_Email__c='test@gmail.com';
         insert pc;
        
         Exclusivity__c exc=New Exclusivity__c();
         exc.Brand_Product_Category__c=pc.Id;exc.Account_Wise_Exclusivity__c=acc.Id;
         exc.Dealing_Through__c=opp.Domain__c;
         insert exc;

         
        
         Product__c prod=new Product__c();
         prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
         prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';prod.HSN_Code__c='12345678';prod.SAC_Code__c='87654321';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';
        insert prod;
        
        Product_List__c p=new Product_List__c(Opportunity__c=opp.id,Sub_Category__c=prod.Sub_Category__c);
        insert p;
        Product_List__c pl=new Product_List__c();
        pl.Opportunity__c=opp.id;
        pl.Product__c=prod.id;
        pl.Sub_Category__c=prod.Sub_Category__c;
        pl.Brand_Name_Text__c=prod.Brand_Picklist__c;
        
        insert pl;
        
         Product_List__c pl1=new Product_List__c();
        pl1.id=pl.id;
        pl1.Quantity__c=5;
        pl1.Discount__c=30;
        
        update pl1;
         
        
        System.Test.stopTest();
    }
 }

    
    
    @isTest  public static void prodtListInsertTestMethod5(){
     UserRole usRole=[SELECT Id, Name FROM UserRole where Name='Inside Sales Manager' Limit 1];
        User usr=[SELECT Id, Name, Email, UserRoleId,ManagerId FROM User WHERE UserRoleId=:usRole.Id Limit 1];
  
        User usrAdmin=[SELECT Id, Name, Email, UserRoleId,ProfileId FROM User WHERE Id=:UserInfo.getUserId() ];
         
     User testUser = new User(
            FirstName = 'Test2',
            LastName = 'User2',
            Username = 'testuser2@examplebiomatiq.com',
            Email = 'testuser2@example.com',
            UserRoleId = usRole.Id,
             ManagerId=usr.ManagerId,
            ProfileId = usrAdmin.ProfileId,  // Specify the desired profile ID
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;     
        
     System.runAs(testUser){
        System.Test.startTest();
         Cluster__c clr=new Cluster__c();
         clr.Name='Test1';clr.Country__c='India';clr.States__c='Tamil Nadu';clr.Sales_Person__c=usr.Id;clr.Branch__c='Bangalore';clr.Bio_Billing_State__c='Karnataka';
         insert clr;
        Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';acc.ShippingState='Tamil Nadu';acc.BillingState='Tamil Nadu';
        acc.Class__c='D - New Customers';acc.GST_Treatment__c='SEZ Developer';/*acc.Deemed_Export__c='1%';*/acc.Country__c='India';acc.Territory__c='Tamil Nadu';acc.Cluster__c=clr.Id;
         insert acc;
        Contact con=New Contact();
        con.LastName='test';
        con.MobilePhone='1234567890';
        con.Email='test@gmail.com';
        con.AccountId=acc.Id;
        insert con;
         
       BiomatiQ_Price_Book__c pc1=TestDataFactory.createPriceBook();
       insert pc1;
         
         BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
  
        
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Yet to Tap';opp.Opportunity_Product_Category__c='Instrumentation';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
   
        
         User u=[SELECT Id, Name, Email, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
         Product_Category__c pc=New Product_Category__c();
         pc.Principal__c='VWR';pc.Brand_Name__c='AGME';pc.Segment__c='Microbiology Solutions';
         pc.Category__c='Culture Media';pc.Sub_Category__c='Ready To Use Media';pc.Agreement__c='No';
         pc.Sales_Executive_Discount__c=5;
         pc.Area_Sales_Manager_Discount__c=10;pc.Regional_Sales_Manager_Discount__c=15;pc.Outside_Sales_Director_Discount__c=20;
         pc.Managing_Director_Discount__c=30;pc.Portfolio_Manager__c=u.Id;
         pc.Brand_Contact_Person__c='test';pc.Brand_Contact_Person_Email__c='test@gmail.com';
         insert pc;
        
         Exclusivity__c exc=New Exclusivity__c();
         exc.Brand_Product_Category__c=pc.Id;exc.Account_Wise_Exclusivity__c=acc.Id;
         exc.Dealing_Through__c=opp.Domain__c;
         insert exc;

         
        
         Product__c prod=new Product__c();
         prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
         prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';prod.HSN_Code__c='12345678';prod.SAC_Code__c='87654321';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';
        insert prod;
        
     
        Product_List__c pl=new Product_List__c();
        pl.Opportunity__c=opp.id;
        pl.Product__c=prod.id;
        pl.Sub_Category__c=prod.Sub_Category__c;
        pl.Brand_Name_Text__c=prod.Brand_Picklist__c;
        
        insert pl;
        
         Product_List__c pl1=new Product_List__c();
        pl1.id=pl.id;
        pl1.Quantity__c=5;
        pl1.Discount__c=25;
        
        update pl1;
         
        
        System.Test.stopTest();
    }
 }
    
    
   /*  @isTest  public static void prodtListInsertTestMethod6(){
     UserRole usRole=[SELECT Id, Name FROM UserRole where Name='Inside Sales team' Limit 1];
        User usr=[SELECT Id, Name, Email, UserRoleId,ManagerId FROM User WHERE UserRoleId=:usRole.Id Limit 1];
  
        User usrAdmin=[SELECT Id, Name, Email, UserRoleId,ProfileId FROM User WHERE Id=:UserInfo.getUserId() ];
         
     User testUser = new User(
            FirstName = 'Test3',
            LastName = 'User3',
            Username = 'testuser3@examplebiomatiq.com',
            Email = 'testuser3@example.com',
            UserRoleId = usRole.Id,
             ManagerId=usr.ManagerId,
            ProfileId = usrAdmin.ProfileId,  // Specify the desired profile ID
            Alias = 'tuser',
            TimeZoneSidKey = 'America/Los_Angeles',
            LocaleSidKey = 'en_US',
            EmailEncodingKey = 'UTF-8',
            LanguageLocaleKey = 'en_US'
        );
        insert testUser;     
        
     System.runAs(testUser){
        System.Test.startTest();
         Cluster__c clr=new Cluster__c();
         clr.Name='Test1';clr.Country__c='India';clr.States__c='Tamil Nadu';clr.Sales_Person__c=usr.Id;clr.Branch__c='Bangalore';clr.Bio_Billing_State__c='Karnataka';
         insert clr;
        Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';acc.ShippingState='Tamil Nadu';acc.BillingState='Tamil Nadu';
        acc.Class__c='D - New Customers';acc.GST_Treatment__c='SEZ Developer';acc.Country__c='India';acc.Territory__c='Tamil Nadu';acc.Cluster__c=clr.Id;
         insert acc;
        Contact con=New Contact();
        con.LastName='test';
        con.MobilePhone='1234567890';
        con.Email='test@gmail.com';
        con.AccountId=acc.Id;
        insert con;
         BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
  
        
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Yet to Tap';opp.Opportunity_Product_Category__c='Instrumentation';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
   
        
         User u=[SELECT Id, Name, Email, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
         Product_Category__c pc=New Product_Category__c();
         pc.Principal__c='VWR';pc.Brand_Name__c='AGME';pc.Segment__c='Microbiology Solutions';
         pc.Category__c='Culture Media';pc.Sub_Category__c='Ready To Use Media';pc.Agreement__c='No';
         pc.Authorization__c='No';pc.Dealing_Through__c='Biomatiq';pc.Sales_Executive_Discount__c=5;
         pc.Area_Sales_Manager_Discount__c=10;pc.Regional_Sales_Manager_Discount__c=15;pc.Outside_Sales_Director_Discount__c=20;
         pc.Portfolio_Manager_Discount__c=25;pc.Managing_Director_Discount__c=30;pc.Portfolio_Manager__c=u.Id;
         pc.Brand_Contact_Person__c='test';pc.Brand_Contact_Person_Email__c='test@gmail.com';
         insert pc;
        
         Exclusivity__c exc=New Exclusivity__c();
         exc.Brand_Product_Category__c=pc.Id;exc.Account_Wise_Exclusivity__c=acc.Id;
         exc.Dealing_Through__c=opp.Domain__c;
         insert exc;

         
        
         Product__c prod=new Product__c();
         prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
         prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';
        insert prod;
        
     
        Product_List__c pl=new Product_List__c();
        pl.Opportunity__c=opp.id;
        pl.Product__c=prod.id;
        pl.Sub_Category__c=prod.Sub_Category__c;
        pl.Brand_Name_Text__c=prod.Brand_Picklist__c;
        
        insert pl;
        
         Product_List__c pl1=new Product_List__c();
        pl1.id=pl.id;
        pl1.Quantity__c=5;
        pl1.Discount__c=25;
        
        update pl1;
         
        
        System.Test.stopTest();
    }
 }*/

}