//Created Date : 31/3/2023
trigger ProductTrigger on Product__c (before insert,before Update) {
  String subcategory;
    if(Trigger.isInsert){
    for(Product__c p:Trigger.New){
       subcategory=p.Sub_Category__c;
    } 
        Product_Category__c pc=[Select Id,Name,Segment__c,Category__c,Sub_Category__c from Product_Category__c where Id=:subcategory];
        if(pc!=null){
             for(Product__c p:Trigger.New){
       p.Segment__c=pc.Segment__c;
                 p.Category__c	=pc.Category__c	;
    } 
        }
    }
    
      if(Trigger.isUpdate){
    for(Product__c pd:Trigger.New){
        if(pd.Sub_Category__c != Trigger.OldMap.get(pd.Id).Sub_Category__c){
            subcategory=pd.Sub_Category__c;
        }
    } 
                  if(subcategory !=null){
           Product_Category__c pc=[Select Id,Name,Segment__c,Category__c,Sub_Category__c from Product_Category__c where Id=:subcategory];

             for(Product__c p:Trigger.New){
       p.Segment__c=pc.Segment__c;
                 p.Category__c	=pc.Category__c	;
    } 
        }
    }
}