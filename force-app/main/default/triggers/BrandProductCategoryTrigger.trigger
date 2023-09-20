/*Trigger Name: BrandProductCategoryTrigger
     * Controller:BrandProductCategoryTriggerHandler
     * Test Class : BrandProductCategoryTriggerHandlerTest
    Created Date:05/05/2023*/
trigger BrandProductCategoryTrigger on Product_Category__c (before insert,before Update,after Insert,after Update) {
    Switch on Trigger.OperationType{
          when BEFORE_INSERT{
            BrandProductCategoryTriggerHandler.beforeInsert(Trigger.new);
        
        }
        when BEFORE_UPDATE{
          BrandProductCategoryTriggerHandler.beforeUpdate(Trigger.new,Trigger.OldMap);
        } 
        when BEFORE_DELETE{
         
        }
        when AFTER_INSERT{
        BrandProductCategoryTriggerHandler.afterInsert(Trigger.new);
        }
        when AFTER_UPDATE{
          
          BrandProductCategoryTriggerHandler.afterUpdate(Trigger.new,Trigger.OldMap);
        }
        when AFTER_DELETE{
         
        }
        when AFTER_UNDELETE{
          
        }
    }
   
    
    
      
}