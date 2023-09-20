/*
     * Controller:newproductFormController
     * Test Class : newProdoctFormTest
     * LWC:newProductForm
    Created Date:
Last Modified date:27/06/2023*/

public class newproductFormController {
    
        @AuraEnabled(cacheable=true)
       public static list<sObject> fetchLookupData(string searchKey , string sObjectApiName) {    
         List < sObject > returnList = new List < sObject > ();
         string sWildCardText = '%' + searchKey + '%';
                Map<String,sObject> stringObjMap=New Map<String,sObject>();
         //string sQuery = 'Select Id,HSN_Code__c,Unit__c,SAC_Code__c From ' + sObjectApiName + ' Where HSN_Code__c Like : sWildCardText';
       List<Product__c> prodList=[Select Id,HSN_Code__c,Unit__c,SAC_Code__c From Product__c Where HSN_Code__c Like : sWildCardText]; 
         for (Product__c obj: prodList) {
            stringObjMap.put(obj.HSN_Code__c,obj);
             returnList.add(obj);
         }
           returnList=stringObjMap.values();
           
         System.debug(returnList);
         return returnList;
     }

     @AuraEnabled(cacheable=true)
     public static list<sObject> fetchLookupDataUnits(string searchKey , string sObjectApiName) {    
       List < sObject > returnList = new List < sObject > ();
          Map<String,sObject> stringObjMap=New Map<String,sObject>();
       string sWildCardText = '%' + searchKey + '%';
       //string sQuery = 'Select Id,Unit__c From ' + sObjectApiName + ' Where Unit__c Like : sWildCardText';
  List<Product__c> prodList=[Select Id,Unit__c From Product__c Where Unit__c Like : sWildCardText]; 
       for (Product__c obj: prodList) {
           stringObjMap.put(obj.Unit__c,obj);
           //returnList.add(obj);
       }
         returnList=stringObjMap.values();
       System.debug(returnList);
       return returnList;
   }

    
     @AuraEnabled(cacheable=true)
     public static list<sObject> fetchLookupDataProdFamily(string searchKey , string sObjectApiName) {    
       List < sObject > returnList = new List < sObject > ();
         Map<String,sObject> stringObjMap=New Map<String,sObject>();
       string sWildCardText = '%' + searchKey + '%';
       //string sQuery = 'Select Id,Product_Family_Name__c From ' + sObjectApiName + ' Where Product_Family_Name__c Like : sWildCardText';
       List<Product__c> prodList=[Select Id,Name,Cat_No__c,Product_Family_Name__c From Product__c Where Product_Family_Name__c Like : sWildCardText]; 
       for (Product__c obj: prodList) {
stringObjMap.put(obj.Product_Family_Name__c,obj);
          // returnList.add(obj);
       }
         returnList=stringObjMap.values();
       System.debug(returnList);
       return returnList;
   }
    
   @AuraEnabled(cacheable=true)
   public static list<sObject> fetchLookupDataSAC(string searchKey , string sObjectApiName) {    
     List < sObject > returnList = new List < sObject > ();
     string sWildCardText = '%' + searchKey + '%';
 Map<String,sObject> stringObjMap=New Map<String,sObject>();
     //string sQuery = 'Select Id,SAC_Code__c From ' + sObjectApiName + ' Where SAC_Code__c Like : sWildCardText';
     
    List<Product__c> prodList=[Select Id,SAC_Code__c  From Product__c Where SAC_Code__c Like : sWildCardText]; 
       for (Product__c obj: prodList) {
stringObjMap.put(obj.SAC_Code__c,obj);
          // returnList.add(obj);
       }
       returnList=stringObjMap.values();
     System.debug(returnList);
     return returnList;
 }
    
    //Author Gowtham.K
    //Modified on 29/3/2023
    //Description : For brand and product category LWC form
     @AuraEnabled(cacheable=true)
   public static list<Product_Category__c> fetchSubCategoryRecords(string brand) {  
 List<Product_Category__c> subCat=[Select Id,Name,Sub_Category__c,Segment__c,Category__c,Brand_Name__c From Product_Category__c where Brand_Name__c=:brand]; 
       return subCat;   
   }
    
     @AuraEnabled(cacheable=true)
   public static Product_Category__c fetchSubCategoryRecord(string subCategory) {  
 Product_Category__c subCat=[Select Id,Name,Sub_Category__c,Brand_Name__c,Segment__c,Category__c From Product_Category__c Where Id=:subCategory]; 
      system.debug('subcat'+subCat);
       return subCat;   
   }
    
    
@AuraEnabled(cacheable=true)
   public static Product__c fetchProductsByCatNo(string catNo) {  
Product__c prod=[Select Id,Name,Cat_No__c From Product__c Where Cat_No__c=:catNo]; 
      system.debug('prod'+prod);
       return prod;   
   }    
   }