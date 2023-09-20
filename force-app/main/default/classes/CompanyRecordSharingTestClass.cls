/*
 * Class Name : CompanyRecordSharing,ClusterRecordSharing
 * Test Class : CompanyRecordSharingTestClass
 * Trigger    : AccountTrigger
 * Created Date : 27/1/2023
*/

@isTest
public class CompanyRecordSharingTestClass {
    @isTest
  static void testManualShareRead(){
  Profile prof = [select id from profile where name LIKE '%System Administrator%'];
       Id bioprof = [select id from profile where name LIKE '%Biomatiq Users%'].Id;
    List<User> users = [SELECT Id FROM User WHERE IsActive = true LIMIT 2];
      Id User1Id = [SELECT Id FROM User WHERE IsActive = true AND ProfileId =:prof.Id LIMIT 1].Id;
      Id User2Id = [SELECT Id FROM User WHERE IsActive = true AND ProfileId =:bioprof LIMIT 1].Id;
      System.Test.startTest();
      Cluster__c cl=new Cluster__c();
      cl.Name='Test';
      cl.States__c='Telangana';
      cl.Country__c='India';
      cl.Sales_Person__c=User2Id;
      cl.OwnerId=User1Id;
      insert cl;
   
      Account acc=New Account();
      acc.Name='Test Company';
      acc.Country__c='India';
      acc.Territory__c='Telangana';
      acc.Cluster__c=cl.Id;
      insert acc;
 

 Cluster__c cl1=new Cluster__c();
      cl1.Name='Test1';
      cl1.States__c='Telangana';
      cl1.Country__c='India';
      cl1.OwnerId=User1Id;
      insert cl1; 
 Cluster__c cl2=new Cluster__c();
      cl2.Id=cl1.Id;
      cl2.Sales_Person__c=User2Id;
      update cl2;      
      
      
       Account acc1=New Account();
      acc.Name='Test Company';
      acc.Country__c='India';
      acc.Territory__c='Telangana';
      acc.Cluster__c=cl1.Id;
      Update acc;
      System.Test.stopTest();
     /*  List<Cluster__Share> jShrs = [SELECT Id, UserOrGroupId, AccessLevel, 
  RowCause FROM Cluster__Share WHERE ParentId = :cl.Id AND UserOrGroupId= :user2Id];
       System.assertEquals(jShrs[0].AccessLevel, 'Edit');
      
      List<AccountShare> accShrs = [SELECT Id, UserOrGroupId, AccountAccessLevel, OpportunityAccessLevel,
  RowCause FROM AccountShare WHERE AccountId = :acc.Id AND UserOrGroupId= :user2Id];
       System.assertEquals(accShrs[0].AccountAccessLevel, 'All');
 System.assertEquals(accShrs[0].OpportunityAccessLevel, 'Edit');   */
       
  }
}