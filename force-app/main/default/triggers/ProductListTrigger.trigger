/*Trigger Name: ProductListTrigger
 * Controller:ProductListTriggerHandler
Created Date: 4/4/2023*/

trigger ProductListTrigger on Product_List__c (before insert,before update) {
   
     switch on Trigger.operationType{
        when BEFORE_INSERT{
            ProductListTriggerHandler.beforeInsert(Trigger.New);
             ProductListTriggerHandler.emptyProductDelete(Trigger.New);
        }
        when BEFORE_UPDATE{
           ProductListTriggerHandler.toExecuteApprovalProcess(Trigger.New,Trigger.OldMap);
        }
       /* when AFTER_UPDATE{
             
        }
        when BEFORE_DELETE{
             
        }
      
     when AFTER_UPDATE{
             
        }
        when AFTER_DELETE{
             
        }
        when AFTER_UNDELETE{
             
        }*/
}
    
}