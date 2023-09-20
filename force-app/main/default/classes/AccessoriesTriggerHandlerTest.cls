@isTest
public class AccessoriesTriggerHandlerTest {
    
    @isTest
    static void beforeInsert(){
       
        User ur=[SELECT Id, Name, UserRole.Name FROM User where UserRole.Name='Portfolio Manager'];
        Product_Category__c pc1=TestDataFactory.createBrandProdCategory();
        pc1.Portfolio_Manager__c=ur.Id;
        insert pc1;
        
        Product__c pro=TestDataFactory.createProduct();
        pro.Sub_Category__c=pc1.id;
        pro.Product_Type__c='Equipment';
        insert pro;
         
        
        Product_List_Items__c proListItem=new Product_List_Items__c();
        proListItem.Product_Name__c=pro.Id;
        proListItem.Accessory__c=pro.Id;
      
        
         try {
              insert proListItem;
        } catch (DmlException e) {
            system.assertEquals('Insert failed. First exception on row 0; first error: FIELD_CUSTOM_VALIDATION_EXCEPTION, Accessories should be add only for the Accessory product type: []', e.getMessage());
        }
    }

}