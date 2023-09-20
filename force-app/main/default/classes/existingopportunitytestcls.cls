@istest
public class existingopportunitytestcls {
   @TestSetup
    public static void testsetup(){
        TestDataFactory.createUser('Sales Executive');
    }
    static testmethod void setup()
    {
        System.Test.startTest();
       User usr=[Select Id,Name From User Where Username=:'testuser@examplebiomatiq.com' Limit 1];
        Cluster__c cl=TestDataFactory.createCluster();
        cl.Sales_Person__c=usr.id;
        insert cl;
         Account test1=TestDataFactory.createAccount();
    test1.Name='Accenture1';
    test1.Website='www.google.com';
    test1.Phone='9566524873';test1.Cluster__c=cl.id;
    insert test1; 
          
           Contact con1=new contact();
        con1.LastName='prakash';
        con1.AccountId=test1.Id;
        con1.Email='rajsaran1027@gmail.com';
        con1.MobilePhone= '8907654321';
        con1.Phone= '9566524873';
        insert con1;
        
      BiomatiQ_Price_Book__c priceBook=TestDataFactory.createPriceBook();
        
      insert priceBook;
        
      BiomatiQ_Lead__c existopp =TestDataFactory.createOpportunity(test1.Id,con1.id);
      
        insert existopp; 
        
        Visit_Management__c vm=TestDataFactory.createVisitManagement(test1.Id,existopp.Id);
        insert vm;
        
        BiomatiQ_Lead__c opp=TestDataFactory.createOpportunity(test1.Id,con1.id);
        insert opp;
        
        
     existingopportunity.opportunityinformation(existopp.Id); 
        existingopportunity.updateVisitRec(vm.Id,opp.Lead_Status__c,opp.Name);
        System.Test.stopTest();
    }

}