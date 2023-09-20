@isTest
public class TestDataFactory {
	
	public static Account createAccount() {
        
            Account acc=New Account();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';acc.ShippingState='Telangana';
        acc.BillingCountry='India';acc.BillingState='Telangana';
        acc.Class__c='D - New Customers';acc.GST_Treatment__c='Registred Business - Regular';acc.Country__c='India';acc.Territory__c='Telangana';
      	
        return acc;
	}
	
public static Cluster__c createCluster() {
        
        Cluster__c cl=new Cluster__c();
        cl.Name='Test';
        cl.Branch__c='Hyderabad';cl.Bio_Billing_State__c='Telangana';cl.Country__c='India';cl.States__c='Telangana';
          
        return cl;
	}

	
	public static Contact createContact(Id accountId) {
		Contact c = new Contact();
         c.LastName='test';
        c.MobilePhone='1234567890';
        c.Email='test@gmail.com';
        c.AccountId=accountId;
		
		return c;
	}
    
    public static BiomatiQ_Price_Book__c createPriceBook() {
        BiomatiQ_Price_Book__c pb=New BiomatiQ_Price_Book__c();
        pb.Name='Stanard';pb.Active__c=true;
        pb.Is_Standard_Price_Book__c=true;
        return pb;
    }
    
    public static BiomatiQ_Book_Entry__c createPriceBookEntry(String priceBookId,String productId) {
        BiomatiQ_Book_Entry__c pbe=New BiomatiQ_Book_Entry__c();
        pbe.Biomatiq_Price_Book__c=priceBookId;
        pbe.Product__c=productId;pbe.Active__c=true;
            
        return pbe;
    }
	public static BiomatiQ_Lead__c createOpportunity(Id accountId,Id contactId) {
	
			BiomatiQ_Lead__c opp = new BiomatiQ_Lead__c();
  opp.Lead_Source__c = 'Organic - Direct visit';       
        opp.Lead_Status__c='Customer Engagement';
        opp.Company_Name__c=accountId;
        opp.Contact__c=contactId;
        opp.Opportunity_Product_Category__c='Microbiology Solutions';
        //existopp.Instrument_Brands_Lead__c='Genaxy:Instruments';
        opp.Opportunity_Specific_Remarks__c='good only';
        opp.Product_Category_Model_Discussed__c='Test Model';
        opp.Actionables__c='Brand Manager Involvement Request';
        opp.Domain__c='Biomatiq';
        opp.Opportunity_Next_Follow_up__c=System.Date.today()+1;
        opp.Opportunity_Closing__c=System.Date.today()+30;

		return opp;
	}
    
    //Due to deployment error commented
    public static Product_Category__c createBrandProdCategory() {
      
		Product_Category__c pc = New Product_Category__c();
        pc.Principal__c='Airwell';pc.Brand_Name__c='Airwell';pc.Segment__c='Laboratory Consumables';pc.Category__c='Glassware';pc.Sub_Category__c='General Glassware';
        pc.Agreement__c='No';pc.Brand_Contact_Person__c='Test Contact person';pc.Brand_Contact_Person_Email__c='TestContactperson@gmail.com';
        pc.Sales_Executive_Discount__c=10;pc.Area_Sales_Manager_Discount__c=15;pc.Regional_Sales_Manager_Discount__c=20;pc.Outside_Sales_Director_Discount__c=25;
        pc.Managing_Director_Discount__c=35;
		return pc;
        
       
	}
    
    public static Visit_Management__c createVisitManagement(Id accountId,Id OppId) {
	
        Visit_Management__c vm=new Visit_Management__c();
        vm.Company__c=accountId;
        vm.BiomatiQ_Lead__c=OppId;
        vm.Appointment_Visit_Scheduled_on__c=System.Datetime.now().addhours(2);
        return vm;
    }
    
      public static Product__c createProduct() {
        
         Product__c prod=new Product__c();
         prod.Brand_Picklist__c='Airwell';prod.Cat_No__c='test catg';prod.SKU__c='Test';
         prod.Tax_Preference__c='Taxable';prod.Product_Type__c='Accessory';prod.Tax_GST__c='12%';
        prod.Name='test';prod.Selling_Price__c=500;prod.Inventory_Account__c='Work In Progress';
        prod.Unit__c='g';prod.Pack_Size_Quantity__c=5;prod.Account_Type__c='Purchase Account';prod.Type__c='Goods';prod.HSN_Code__c='123344';
      
          return prod;
      }
    
    public static Product_List__c createProductList(String ProdId,String OppId) {
        Product_List__c pl=New Product_List__c();
        pl.Opportunity__c=OppId;
        pl.Product__c=ProdId;
        return pl;
    }
    
    
    public static User createUser(String roleName) {
     UserRole usRole=[SELECT Id, Name FROM UserRole where Name=:roleName Limit 1];
         User Salesusr=[SELECT Id, Name, Email, ManagerId FROM User WHERE UserRoleId=:usRole.Id Limit 1];
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
        return testUser;
    }
     public static Quotes__c createQuote(String oppId) {
         Quotes__c q=New Quotes__c();
         q.Opportunity__c=oppId;
         insert q;
         return q;
     }
    
}