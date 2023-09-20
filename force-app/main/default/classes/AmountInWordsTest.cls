/*Class:AmountInWords
 Trigger:AmountInWords
TestClass:AmountInWordsTest
VfPage:BiomatiqQuote
Developer:Gowtham.K*/
@isTest
public class AmountInWordsTest {
    @testSetup static void setup() {
        User portusr=TestDataFactory.createUser('Portfolio Manager');
    }
    @isTest
    static void testSetup1() {
         
         User u=[SELECT Id, Name, Email,Username FROM User WHERE Username ='testuser@examplebiomatiq.com'];
         List<User> usrlist=[Select Id,Name From User where IsActive=:true Limit 2];
          String usr1=usrlist[0].Id;
          String usr2=usrlist[1].Id;
    Cluster__c cls=TestDataFactory.createCluster();
        cls.Sales_Person__c=usr2;
        insert cls;

        
         Account acc=TestDataFactory.createAccount();
        acc.Name='Test';acc.ShippingCity='test City';acc.ShippingCountry='India';acc.ShippingStreet='test';
        acc.Cluster__c=cls.Id;
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
        BiomatiQ_Lead__c req=new BiomatiQ_Lead__c();
        req.Contact__c=con.Id;
        req.Company_Name__c=acc.Id;req.Lead_Source__c='Organic - Direct visit';req.Domain__c='Biomatiq';
        req.Opportunity_Stage__c='Yet to Tap';req.Opportunity_Product_Category__c='Instrumentation';
        req.Actionables__c='Demo Required';req.Opportunity_Next_Follow_up__c=System.today().addDays(1);
        req.Opportunity_Closing__c=System.today().addDays(2);req.Opportunity_Specific_Remarks__c='test';
        insert req;
   Visit_Management__c vm=TestDataFactory.createVisitManagement(acc.Id,req.Id);
        insert vm;
         BiomatiQ_Lead__c req2=TestDataFactory.createOpportunity(acc.Id,con.Id);
        req2.Source_Visit__c=vm.Id;
       insert req2;
        
       Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=u.Id;
        insert pc;
       Product__c prod = TestDataFactory.createProduct();
        prod.Sub_Category__c=pc.Id;
        insert prod;
        Product_List__c prod1=new  Product_List__c(Opportunity__c=req.Id,Product__c=prod.Id,Quantity__c=10,SGST__c=9,Cgst__c=9);
        Product_List__c prod2=new  Product_List__c(Opportunity__c=req.Id,Product__c=prod.Id,Quantity__c=10,SGST__c=7,Cgst__c=7);
       
        
        insert prod1;
       insert prod2;
    
    }
	@isTest
    private static void testMethod1(){
   Id userId=UserInfo.getUserId();
        User usr = [Select Id,Name From User where Id = :userId];

        System.runAs(usr){
        AmountInWords.english_number(4567890);
      //   System.assertEquals('Zero Only',AmountInWords.english_number(456789));
        }
    }
    


}