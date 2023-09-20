@isTest
public class ExclusivityTriggerHandlerTest {

    @isTest 
    static void exclusivityBeforeInsert(){
        User ur=[SELECT Id, Name, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
        Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=ur.Id;        
        insert pc;
       List<Exclusivity__c> excList=new  List<Exclusivity__c>();
        Exclusivity__c exc=new Exclusivity__c();
        exc.Brand_Product_Category__c=pc.Id;
        exc.Multi_Regionwise_Exclusivity__c='All';
        exc.Dealing_Through__c='Biomatiq';
        insert exc;
    
        Exclusivity__c exc1=new Exclusivity__c();
        exc1.Brand_Product_Category__c=pc.Id;
        exc1.Multi_Regionwise_Exclusivity__c='Bihar';
        exc1.Dealing_Through__c='Biomatiq';
        excList.add(exc1);
        
        System.Test.startTest();
            ExclusivityTriggerHandler.restrictRegionWiseBeforeInsert(excList);
            //insert excList;
        System.Test.stopTest();
         Database.Error error = exc1.getErrors()[0];
         System.assertEquals(error.getMessage(), 'Already, the General Glassware Subcategory has Biomatiq Dealing Through with All State');
        
    }
    
    @isTest
    static void exclusivityBeforeInsert1(){
        
          User ur=[SELECT Id, Name, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
        Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=ur.Id;        
        insert pc;
       List<Exclusivity__c> excList=new  List<Exclusivity__c>();
        Exclusivity__c exc=new Exclusivity__c();
        exc.Brand_Product_Category__c=pc.Id;
        exc.Multi_Regionwise_Exclusivity__c='Bihar';
        exc.Dealing_Through__c='Biomatiq';
        insert exc;
    
        Exclusivity__c exc1=new Exclusivity__c();
        exc1.Brand_Product_Category__c=pc.Id;
        exc1.Multi_Regionwise_Exclusivity__c='All';
        exc1.Dealing_Through__c='Biomatiq';
        excList.add(exc1);
        
        System.Test.startTest();
            ExclusivityTriggerHandler.restrictRegionWiseBeforeInsert(excList);
            //insert excList;
        System.Test.stopTest();
         Database.Error error = exc1.getErrors()[0];
         System.assertEquals(error.getMessage(), 'Already, the General Glassware Subcategory has Biomatiq Dealing Through with Bihar');
        
        
    }
    
     @isTest
    static void exclusivityBeforeInsert2(){
        
          User ur=[SELECT Id, Name, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
        Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=ur.Id;        
        insert pc;
       List<Exclusivity__c> excList=new  List<Exclusivity__c>();
        Exclusivity__c exc=new Exclusivity__c();
        exc.Brand_Product_Category__c=pc.Id;
        exc.Multi_Regionwise_Exclusivity__c='Goa';
        exc.Dealing_Through__c='Biomatiq';
        insert exc;
    
        Exclusivity__c exc1=new Exclusivity__c();
        exc1.Brand_Product_Category__c=pc.Id;
        exc1.Multi_Regionwise_Exclusivity__c='Goa';
        exc1.Dealing_Through__c='E-Scientic';
        excList.add(exc1);
        
        System.Test.startTest();
            ExclusivityTriggerHandler.restrictRegionWiseBeforeInsert(excList);
            //insert excList;
        System.Test.stopTest();
         Database.Error error = exc1.getErrors()[0];
         System.assertEquals(error.getMessage(), 'Already, the General Glassware Subcategory has Biomatiq Dealing Through with Goa');
        
        
    }
    
     @isTest 
    static void exclusivityBeforeUpdate(){
        User ur=[SELECT Id, Name, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
        Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=ur.Id;        
        insert pc;
       List<Exclusivity__c> excList=new  List<Exclusivity__c>();
        Exclusivity__c exc=new Exclusivity__c();
        exc.Brand_Product_Category__c=pc.Id;
        exc.Multi_Regionwise_Exclusivity__c='Bihar';
        exc.Dealing_Through__c='Biomatiq';
        insert exc;
        
        exc.Multi_Regionwise_Exclusivity__c='All';
        update exc;
       
        List<Exclusivity__c> oldExc=new List<Exclusivity__c>();
        Exclusivity__c exc1=new Exclusivity__c();
        exc1.Brand_Product_Category__c=pc.Id;
        exc1.Dealing_Through__c='Biomatiq';
        oldExc.add(exc1);
     
        List<Exclusivity__c> newExc=new List<Exclusivity__c>();

         Exclusivity__c exc2=new Exclusivity__c();
        exc2.Brand_Product_Category__c=pc.Id;
        exc2.Dealing_Through__c='Biomatiq';
         exc2.Multi_Regionwise_Exclusivity__c='All';
        newExc.add(exc2);
        
        System.Test.startTest();
            ExclusivityTriggerHandler.restrictRegionWiseBeforeUpdate(newExc,oldExc);
        System.Test.stopTest();
         Database.Error error = exc2.getErrors()[0];
         System.assertEquals(error.getMessage(), 'Already, the General Glassware Subcategory has Biomatiq Dealing Through with All State');
        
    }
    
    @isTest 
    static void exclusivityBeforeUpdate1(){
        User ur=[SELECT Id, Name, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
        Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=ur.Id;        
        insert pc;
          List<Exclusivity__c> oldExc=new List<Exclusivity__c>();
       List<Exclusivity__c> excList=new  List<Exclusivity__c>();
        Exclusivity__c exc=new Exclusivity__c();
        exc.Brand_Product_Category__c=pc.Id;
        exc.Multi_Regionwise_Exclusivity__c='Bihar';
        exc.Dealing_Through__c='Biomatiq';
         oldExc.add(exc);
        insert exc;
      
        Exclusivity__c exc1=new Exclusivity__c();
        exc1.Brand_Product_Category__c=pc.Id;
        exc1.Dealing_Through__c='Biomatiq';
        exc1.Multi_Regionwise_Exclusivity__c='Goa';
        insert exc1;
        List<Exclusivity__c> newExc=new List<Exclusivity__c>();

         Exclusivity__c exc2=new Exclusivity__c();
        exc2.Brand_Product_Category__c=pc.Id;
        exc2.Dealing_Through__c='Biomatiq';
         exc2.Multi_Regionwise_Exclusivity__c='All';
        newExc.add(exc2);
        
        System.Test.startTest();
            ExclusivityTriggerHandler.restrictRegionWiseBeforeUpdate(newExc,oldExc);
        System.Test.stopTest();
         Database.Error error = exc2.getErrors()[0];
         System.assertEquals(error.getMessage(), 'Already, the General Glassware Subcategory has Biomatiq Dealing Through with Goa');
        
    }
    
    @isTest 
    static void exclusivityBeforeUpdate2(){
        User ur=[SELECT Id, Name, UserRole.Name FROM User WHERE UserRole.Name ='Portfolio Manager'];
        Product_Category__c pc=TestDataFactory.createBrandProdCategory();
        pc.Portfolio_Manager__c=ur.Id;        
        insert pc;
          List<Exclusivity__c> oldExc=new List<Exclusivity__c>();
        Exclusivity__c exc=new Exclusivity__c();
        exc.Brand_Product_Category__c=pc.Id;
        exc.Multi_Regionwise_Exclusivity__c='Bihar';
        exc.Dealing_Through__c='Biomatiq';
         oldExc.add(exc);
       insert exc;
      
        Exclusivity__c exc1=new Exclusivity__c();
        exc1.Brand_Product_Category__c=pc.Id;
        exc1.Dealing_Through__c='Biomatiq';
        exc1.Multi_Regionwise_Exclusivity__c='Bihar';
        insert exc1;
        List<Exclusivity__c> newExc=new List<Exclusivity__c>();

         Exclusivity__c exc2=new Exclusivity__c();
        exc2.Brand_Product_Category__c=pc.Id;
        exc2.Dealing_Through__c='E-Scientic';
         exc2.Multi_Regionwise_Exclusivity__c='Bihar';
        newExc.add(exc2);
        
        System.Test.startTest();
           ExclusivityTriggerHandler.restrictRegionWiseBeforeUpdate(newExc,oldExc);
        System.Test.stopTest();
         Database.Error error =exc2.getErrors()[0];
        System.assertEquals(error.getMessage(),'Already, the General Glassware Subcategory has Biomatiq Dealing Through with Bihar');
        
    }

}