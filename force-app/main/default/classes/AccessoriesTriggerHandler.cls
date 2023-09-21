public class AccessoriesTriggerHandler {
    
    
    public static void beforeInsert(List<Product_List_Items__c> accessList){
        productTypeError(accessList);
    }
   public static void beforeUpdate(){
       
    }/* 
    public static void beforeDelete(){
        
    }
   public static void afterInsert(){
        
    }
   public static void afterUpdate(){
        
    }
   public static void afterDelete(){
        
    }
   public static void afterUndelete(){
        
    }*/
    
    
   Public static void productTypeError(List<Product_List_Items__c> accessList){
        String productId;
       String parentProductId;
        for(Product_List_Items__c pro:accessList){
            
           parentProductId=pro.Product_Name__c;
          productId=pro.Accessory__c;
        }
        
        if(String.isNotBlank(productId)){
            
        String prod=[SELECT Id, Name, Product_Type__c FROM Product__c where Id=:productId].Product_Type__c;
            
            if(!String.isNotBlank(prod) || prod !='Accessory'){
                 for(Product_List_Items__c pro:accessList){
            
                  pro.addError('Accessories should be add only for the Accessory product type');
          
                  }
                
            }
    
       }
        
    }

}