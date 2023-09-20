@isTest
public class AddProductsControllerTest {
    
     @isTest static void addProductListTest(){ 
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
   
         BiomatiQ_Price_Book__c pb=TestDataFactory.createPriceBook();
         insert pb;
         
         
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Contact__c=con.Id;
        opp.Company_Name__c=acc.Id;opp.Lead_Source__c='Organic - Direct visit';opp.Domain__c='Biomatiq';
        opp.Opportunity_Stage__c='Yet to Tap';opp.Opportunity_Product_Category__c='Instrumentation';
        opp.Actionables__c='Demo Required';opp.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        opp.Opportunity_Closing__c=System.today().addDays(2);opp.Opportunity_Specific_Remarks__c='test';
         opp.Price_Book__c=pb.Id;
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
         List<Id> pcList=New List<Id>();
         pcList.add(pc.Id);
         Exclusivity__c exc=New Exclusivity__c();
         exc.Brand_Product_Category__c=pc.Id;exc.Account_Wise_Exclusivity__c=acc.Id;
         exc.Dealing_Through__c=opp.Domain__c;
         insert exc;

         
        
         Product__c prod=new Product__c();
         prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
         prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';prod.SAC_Code__c='87654321';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';prod.HSN_Code__c='12345678';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';
        insert prod;
         
        /*  Product__c prod1=new Product__c();
          prod.Brand_Picklist__c='AGME';prod.Sub_Category__c=pc.Id;prod.Cat_No__c='test catg';prod.SKU__c='Test';
         prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';
    
        insert prod1;*/
         
         
         
         BiomatiQ_Book_Entry__c pbe=TestDataFactory.createPriceBookEntry(pb.Id,prod.Id);
         Insert pbe;
         
         List<String> prolist=New List<String>();
         prolist.add(prod.Id); 
         List<Id> prolistExclusivity=New List<Id>();
         
           Product_List__c prl=new  Product_List__c();
        prl.Product__c=prod.Id;prl.Opportunity__c=opp.Id;
insert prl;
           Product_List__c prl1=new  Product_List__c();
        prl1.Product__c=prod.Id;prl1.Opportunity__c=opp.Id;
  insert prl1;
         List<Product_List__c> prolist1=New List<Product_List__c>();
      Product_List__c prl3=new  Product_List__c();
        prl3.Product__c=prod.Id;prl3.Opportunity__c=opp.Id;
         prolist1.add(prl3);
         
         List<String> insertedList=new List<String>();
         
     
         AddProductsController.getProducts(opp.Id);
         AddProductsController.getProductsByString('test',prolist,prolistExclusivity);
         AddProductsController.getProductListItem(prod.Id);
         AddProductsController.addProductLine(opp.Id,prolist1);
         AddProductsController.getNewOrder1('BiomatiQ_Lead__c',opp.id,prolist,insertedList);
         AddProductsController.updateProducts(prolist1);
     	AddProductsController.deleteSelectedAccount(prl.Id);
         AddProductsController.oppDetails(opp.Id);
         AddProductsController.getBrands(opp.Id);
         AddProductsController.getBrandsByString('AGME',pcList,insertedList);
         AddProductsController.saveProdListWithBrand(opp.id,pcList);
        AddProductsController.getPriceBooks();
         AddProductsController.getAllPriceBookEntries(opp.Id);
        System.Test.stopTest();
         
     }

}