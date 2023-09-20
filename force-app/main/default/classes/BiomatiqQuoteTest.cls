/*
 VfPage:BiomatiqQuote
Controller:BiomatiqQuote
TestClass:BiomatiqQuoteTest
Developer:Gowtham
*/


@isTest
public class BiomatiqQuoteTest {
    @isTest
    public static void testBiomatiqQuote(){ 
        Cluster__c clr=new Cluster__c();
        clr.Name='Test1';clr.Country__c='India';clr.States__c='Tamil Nadu';clr.Sales_Person__c=userinfo.getUserId();clr.Branch__c='Bangalore';clr.Bio_Billing_State__c='Karnataka';
        insert clr;
        Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';acc.ShippingState='Tamil Nadu';acc.BillingState='Tamil Nadu';
        acc.Class__c='A - 45 days credit without followup';acc.GST_Treatment__c='overseas';/*acc.Deemed_Export__c='1%';*/acc.Country__c='India';acc.Territory__c='Tamil Nadu';acc.Cluster__c=clr.Id;
         insert acc;
        Contact con=New Contact();
        con.LastName='test';
        con.MobilePhone='1234567890';
        con.Email='test@gmail.com';
        con.AccountId=acc.Id;
        insert con;
        
        BiomatiQ_Price_Book__c bpb=TestDataFactory.createPriceBook();
        insert bpb;
        //Instrumentation divison
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Technical Qualification';opp.Opportunity_Product_Category__c='Molecular Biology';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
        
         User u=[SELECT Id, Name, Email, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager' LIMIT 1];
         Product_Category__c pc=New Product_Category__c();
         pc.Principal__c='VWR';pc.Brand_Name__c='AGME';pc.Segment__c='Microbiology Solutions';
         pc.Category__c='Culture Media';pc.Sub_Category__c='Ready To Use Media';pc.Agreement__c='No';
        pc.Sales_Executive_Discount__c=5;
         pc.Area_Sales_Manager_Discount__c=10;pc.Regional_Sales_Manager_Discount__c=15;pc.Outside_Sales_Director_Discount__c=20;
         pc.Managing_Director_Discount__c=30;pc.Portfolio_Manager__c=u.Id;
         pc.Brand_Contact_Person__c='test';pc.Brand_Contact_Person_Email__c='test@gmail.com';
         insert pc;
        
        Product__c prod=new Product__c();
        prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
        prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';
        prod.HSN_Code__c='12345';
        insert prod;

        
         Product_List__c pl=new  Product_List__c();
        pl.Product__c=prod.Id;pl.Opportunity__c=opp.Id;
        pl.Cgst__c=0.09;
        pl.SGST__c=0.09;
        pl.IGST__c=0.1;
        insert pl;
        
          Quotes__c qt = new Quotes__c(); 
          qt.Opportunity__c=opp.Id;
          insert qt; 
          system.debug('qt.Id==>'+qt.Id);
        
       ApexPages.currentPage().getParameters().put('id',qt.Id);
	ApexPages.StandardController stdController = new ApexPages.StandardController(qt);
	system.debug('stdController==>'+stdController);
     BiomatiqQuote ext = new BiomatiqQuote(stdController);

	PageReference pageRef = Page.BiomatiqQuote;
        system.Test.setCurrentPageReference(pageRef);
	//Test.setCurrentPage(pageRef);
        
        
        
        /*PageReference testPage = Page.BiomatiqQuote; 
       Test.setCurrentPage(testPage);
       testPage.getParameters().put('Id', String.valueOf(qt.Id));        
       ApexPages.StandardController sc = new  ApexPages.StandardController(qt);     
       BiomatiqQuote ext = new BiomatiqQuote(sc); 
       
       List<Quotes__c> ql = [Select Name from Quotes__c where Id=:qt.Id];
       System.assertEquals(1, ql.size()); */
        
   } 
  
      @isTest
      public static void testBiomatiqQuote1(){ 
        Cluster__c clr=new Cluster__c();
        clr.Name='Test1';clr.Country__c='India';clr.States__c='Tamil Nadu';clr.Sales_Person__c=userinfo.getUserId();clr.Branch__c='Bangalore';clr.Bio_Billing_State__c='Karnataka';
        insert clr;
        Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';acc.ShippingState='Tamil Nadu';acc.BillingState='Tamil Nadu';
        acc.Class__c='A - 45 days credit without followup';acc.GST_Treatment__c='overseas';/*acc.Deemed_Export__c='1%';*/acc.Country__c='India';acc.Territory__c='Tamil Nadu';acc.Cluster__c=clr.Id;
        insert acc;
        Contact con=New Contact();
        con.LastName='test';
        con.MobilePhone='1234567890';
        con.Email='test@gmail.com';
        con.AccountId=acc.Id;
        insert con;
          
        BiomatiQ_Price_Book__c bpb=TestDataFactory.createPriceBook();
        insert bpb;
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Technical Qualification';opp.Opportunity_Product_Category__c='Microbiology Solutions';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
      
        User u=[SELECT Id, Name, Email, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager' LIMIT 1];
         Product_Category__c pc=New Product_Category__c();
         pc.Principal__c='VWR';pc.Brand_Name__c='AGME';pc.Segment__c='Microbiology Solutions';
         pc.Category__c='Culture Media';pc.Sub_Category__c='Ready To Use Media';pc.Agreement__c='No';
        pc.Sales_Executive_Discount__c=5;
         pc.Area_Sales_Manager_Discount__c=10;pc.Regional_Sales_Manager_Discount__c=15;pc.Outside_Sales_Director_Discount__c=20;
         pc.Managing_Director_Discount__c=30;pc.Portfolio_Manager__c=u.Id;
         pc.Brand_Contact_Person__c='test';pc.Brand_Contact_Person_Email__c='test@gmail.com';
         insert pc;
        
        Product__c prod=new Product__c();
        prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
        prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';
          prod.HSN_Code__c='12345';
        insert prod;

      
        Product_List__c pl=new  Product_List__c();
        pl.Product__c=prod.Id;pl.Opportunity__c=opp.Id;
        pl.Cgst__c=0.09;
        pl.SGST__c=0.09;
        pl.IGST__c=0.1;
        insert pl;
        
       Quotes__c qt = new Quotes__c(Opportunity__c=opp.Id);   
       insert qt;      
 
       PageReference testPage = Page.BiomatiqQuote; 
       system.Test.setCurrentPageReference(testPage);
       testPage.getParameters().put('Id', String.valueOf(qt.Id));        
       ApexPages.StandardController sc = new  ApexPages.StandardController(qt);     
       BiomatiqQuote ext = new BiomatiqQuote(sc);         
  
       List<Quotes__c> ql = [Select Name from Quotes__c where Id=:qt.Id];
       System.assertEquals(1, ql.size());
        
     
   }
    
    
     public static testMethod void testBiomatiqQuote2(){ 
        // Cluster Object Test data
        Cluster__c clr=new Cluster__c();
        clr.Name='Test1';clr.Country__c='India';clr.States__c='Tamil Nadu';clr.Sales_Person__c=userinfo.getUserId();clr.Branch__c='Bangalore';clr.Bio_Billing_State__c='Karnataka';
        insert clr;
       // Account Object Test data
        Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';acc.ShippingState='Tamil Nadu';acc.BillingState='Tamil Nadu';
        acc.Class__c='A - 45 days credit without followup';acc.GST_Treatment__c='overseas';/*acc.Deemed_Export__c='1%';*/acc.Country__c='India';acc.Territory__c='Tamil Nadu';acc.Cluster__c=clr.Id;
         insert acc;
       
         //Contact Object Test data
        Contact con=New Contact();
        con.LastName='test';
        con.MobilePhone='1234567890';
        con.Email='test@gmail.com';
        con.AccountId=acc.Id;
        insert con;
       
        BiomatiQ_Price_Book__c bpb=TestDataFactory.createPriceBook();
        insert bpb;
         //Opportunity Object Test data
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Technical Qualification';opp.Opportunity_Product_Category__c='Laboratory Consumables';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test'; 
        insert opp;
       
       //Product Brand Category Object Test data
         User u=[SELECT Id, Name, Email, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager' LIMIT 1];
         Product_Category__c pc=New Product_Category__c();
         pc.Principal__c='VWR';pc.Brand_Name__c='AGME';pc.Segment__c='Microbiology Solutions';
         pc.Category__c='Culture Media';pc.Sub_Category__c='Ready To Use Media';pc.Agreement__c='No';
         pc.Sales_Executive_Discount__c=5;
         pc.Area_Sales_Manager_Discount__c=10;pc.Regional_Sales_Manager_Discount__c=15;pc.Outside_Sales_Director_Discount__c=20;
         pc.Managing_Director_Discount__c=30;pc.Portfolio_Manager__c=u.Id;
         pc.Brand_Contact_Person__c='test';pc.Brand_Contact_Person_Email__c='test@gmail.com';
         insert pc;
       
       //Product Object Test data
         Product__c prod=new Product__c();
        prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
        prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';
         prod.HSN_Code__c='12345678';
        insert prod;
         
       //Product List Object Test data
        Product_List__c pl=new  Product_List__c();
        pl.Product__c=prod.Id;pl.Opportunity__c=opp.Id;
        pl.Cgst__c=0.09;
        pl.SGST__c=0.09;
        pl.IGST__c=0.1;
        insert pl;
        
       Quotes__c qt = new Quotes__c(Opportunity__c=opp.Id);   
       insert qt;      
        
       PageReference testPage = Page.BiomatiqQuote; 
        system.Test.setCurrentPageReference(testPage);
       testPage.getParameters().put('Id', String.valueOf(qt.Id));        
       ApexPages.StandardController sc = new  ApexPages.StandardController(qt);     
       BiomatiqQuote ext = new BiomatiqQuote(sc);         
  
       List<Quotes__c> ql = [Select Name from Quotes__c where Id=:qt.Id];
       System.assertEquals(1, ql.size());
          
     
   }
    //E-Scientic
     @isTest
     public static void testBiomatiqQuote3(){ 
        
        //Cluster Object Test data
        Cluster__c clr=new Cluster__c();
        clr.Name='Test1';clr.Country__c='India';clr.States__c='Tamil Nadu';clr.Sales_Person__c=userinfo.getUserId();clr.Branch__c='Bangalore';clr.Bio_Billing_State__c='Karnataka';
        insert clr;
        
        //Account Object Test data
        Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';acc.ShippingState='Tamil Nadu';acc.BillingState='Tamil Nadu';
        acc.Class__c='A - 45 days credit without followup';acc.GST_Treatment__c='overseas';/*acc.Deemed_Export__c='1%';*/acc.Country__c='India';acc.Territory__c='Tamil Nadu';acc.Cluster__c=clr.Id;
        insert acc;
         
        //Contact Object Test data
        Contact con=New Contact();
        con.LastName='test';
        con.MobilePhone='1234567890';
        con.Email='test@gmail.com';
        con.AccountId=acc.Id;
        insert con;
         
        BiomatiQ_Price_Book__c bpb=TestDataFactory.createPriceBook();
        insert bpb;
        //Opportunity Object Test data
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='E-Scientic';
        opp.Opportunity_Stage__c='Technical Qualification';opp.Opportunity_Product_Category__c='Laboratory Consumables';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
        insert opp;
         
        //Product Brand Category object Test data
         User u=[SELECT Id, Name, Email, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager' LIMIT 1];
         Product_Category__c pc=New Product_Category__c();
         pc.Principal__c='VWR';pc.Brand_Name__c='AGME';pc.Segment__c='Microbiology Solutions';
         pc.Category__c='Culture Media';pc.Sub_Category__c='Ready To Use Media';pc.Agreement__c='No';
        pc.Sales_Executive_Discount__c=5;
         pc.Area_Sales_Manager_Discount__c=10;pc.Regional_Sales_Manager_Discount__c=15;pc.Outside_Sales_Director_Discount__c=20;
         pc.Managing_Director_Discount__c=30;pc.Portfolio_Manager__c=u.Id;
         pc.Brand_Contact_Person__c='test';pc.Brand_Contact_Person_Email__c='test@gmail.com';
         insert pc;
         
        //Product Object Test data
        Product__c prod=new Product__c();
        prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
        prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';
         prod.HSN_Code__c='1234';
        insert prod;
         
        //Product List Object Test data
        Product_List__c pl=new  Product_List__c();
        pl.Product__c=prod.Id;pl.Opportunity__c=opp.Id;
        pl.Cgst__c=0.09;
        pl.SGST__c=0.09;
        pl.IGST__c=0.1;
        insert pl;
        
       //Quote Object Test data  
       Quotes__c qt = new Quotes__c(Opportunity__c=opp.Id);   
       insert qt;      
     
       PageReference testPage = Page.BiomatiqQuote; 
        system.Test.setCurrentPageReference(testPage);
       testPage.getParameters().put('Id', String.valueOf(qt.Id));        
       ApexPages.StandardController sc = new  ApexPages.StandardController(qt);     
       BiomatiqQuote ext = new BiomatiqQuote(sc);         
       List<Quotes__c> ql = [Select Name from Quotes__c where Id=:qt.Id];
       System.assertEquals(1, ql.size());
         
     
   }
}