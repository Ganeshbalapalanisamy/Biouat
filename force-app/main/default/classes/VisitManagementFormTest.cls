@isTest
public class VisitManagementFormTest {
    
    @isTest
    static void setup(){
        
         Cluster__c clu=TestDataFactory.createCluster();
        clu.Sales_Person__c=UserInfo.getUserId();
         insert clu;
         
         Account acc=TestDataFactory.createAccount();
         acc.Cluster__c=clu.Id;
         insert acc;
        
         Contact con=TestDataFactory.createContact(acc.Id);
         insert con;

        BiomatiQ_Lead__c bio=TestDataFactory.createOpportunity(acc.Id, con.Id);

        insert bio;
        String searchKey='';
        String objectName='BiomatiQ_Lead__c';
        VisitManagementForm.oppInformation(bio.Id);
        VisitManagementForm.fetchLookupData(searchKey,objectName,acc.Id);
        VisitManagementForm.contactInformation(con.Id);
    }

}