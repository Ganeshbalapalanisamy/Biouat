trigger AccessoriesTrigger on Product_List_Items__c (before insert) {
    
    switch on Trigger.operationType{
        when BEFORE_INSERT{
            AccessoriesTriggerHandler.beforeInsert(Trigger.new);
        
        }
        /*when BEFORE_UPDATE{
           //AccessoriesTriggerHandler.beforeUpdate();
        } 
        when BEFORE_DELETE{
          // AccessoriesTriggerHandler.beforeDelete();
        }
        when AFTER_INSERT{
           //AccessoriesTriggerHandler.afterInsert();  
        }
        when AFTER_UPDATE{
          // AccessoriesTriggerHandler.afterUpdate();  
        }
        when AFTER_DELETE{
         // AccessoriesTriggerHandler.afterDelete();    
        }
        when AFTER_UNDELETE{
         // AccessoriesTriggerHandler.afterUndelete();      
        }*/
}

}