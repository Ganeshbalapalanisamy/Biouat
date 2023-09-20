/*Trigger Name: BrandProductCategoryTrigger
     * Controller:BrandProductCategoryTriggerHandler
     * Test Class : BrandProductCategoryTriggerHandlerTest
    Created Date:05/05/2023*/

public class BrandProductCategoryTriggerHandler {
    public static void beforeInsert(List<Product_Category__c> prodcatList){
         
    for(Product_Category__c pc:prodcatList){
        pc.Name=pc.Sub_Category__c;
    } 
    }
     public static void beforeUpdate(List<Product_Category__c> prodcatList,Map<Id,Product_Category__c> OldProdCatMap){
    for(Product_Category__c pc:prodcatList){
        if(pc.Sub_Category__c != OldProdCatMap.get(pc.Id).Sub_Category__c){
            pc.Name=pc.Sub_Category__c;
        }
    } 
     }
    
    
    
    public static void afterInsert(List<Product_Category__c> prodcatList){ }
  public static void afterUpdate(List<Product_Category__c> prodcatList,Map<Id,Product_Category__c> OldProdCatMap){
      updateProducts(prodcatList,OldProdCatMap);    
    }
    
    public static void updateProducts(List<Product_Category__c> prodcatList,Map<Id,Product_Category__c> OldProdCatMap){
   
        Set<Id> brandCategIds=New Set<Id>();
        for(Product_Category__c pc:prodcatList){
            if(pc.Activate__c	 != OldProdCatMap.get(pc.Id).Activate__c	){
            brandCategIds.add(pc.Id);
            }
        }
        if(brandCategIds.size()>0){
        List<Product__c> productasToupdate=New List<Product__c>();
        productasToupdate=[Select Id,Name,Activate__c,Sub_Category__c,Sub_Category__r.Activate__c	 From Product__c Where Sub_Category__c IN : brandCategIds];

            if(productasToupdate.size()>0){
        for(Product__c pd:productasToupdate){
            pd.Activate__c=pd.Sub_Category__r.Activate__c	;
        }
            try{
            Update productasToupdate;
            }
            catch(Exception e){
                for(Product_Category__c pd:prodcatList){
                pd.addError(e);
                }
            }
    }
        }
    }
}