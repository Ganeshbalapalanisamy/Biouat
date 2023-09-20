public  class AddProductsController {
    @AuraEnabled(cacheable=true)
    public static List<Product__c> getProducts(String opportunityId) {
        BiomatiQ_Lead__c opportunityRec=[Select Id,Name,Company_Name__c,Domain__c From BiomatiQ_Lead__c Where Id=:opportunityId];
        Account accountRec=[Select Id,Name,Industry,ShippingState From Account Where Id=:opportunityRec.Company_Name__c];
  
        List<Exclusivity__c> exclusivityList=[Select Id,Name,Account_Wise_Exclusivity__c,Brand_Product_Category__c,Industry_Wise_Exclusivity__c From Exclusivity__c 
                                              where (Account_Wise_Exclusivity__c=:accountRec.Id OR (Multi_Regionwise_Exclusivity__c Includes(:'All') AND Industry_Wise_Exclusivity__c Includes(:'All Industries',:accountRec.Industry,:'' ))
                                             OR (Multi_Regionwise_Exclusivity__c includes(:accountRec.ShippingState) AND Industry_Wise_Exclusivity__c Includes(:'All Industries',:accountRec.Industry,:'' ))  ) AND (Dealing_Through__c=:opportunityRec.Domain__c)];
      
        system.debug('exclusivityList==>'+exclusivityList.size());
        Set<Id> categoryIds=New Set<Id>();
        for(Exclusivity__c exc:exclusivityList ){
            categoryIds.add(exc.Brand_Product_Category__c);
        }
        
      return [SELECT Id, Name, Brand_Picklist__c,Activate__c,Sub_Category__c,Cat_No__c, Selling_Price__c,LineItem__c,(SELECT Name,Accessory__c,Accessory__r.Name FROM Product_Lists__r) FROM Product__c where Sub_Category__c IN:categoryIds AND Activate__c=true];
   }

    
     @AuraEnabled(cacheable=true)
    public static List<Product__c> getProductsByString(String searchValue,List<String> proList,List<Id> productsExclusivities) {
      String searchString = '%' + searchValue + '%';
      
      return [SELECT Id, Name,Brand_Picklist__c,Activate__c,Cat_No__c,Selling_Price__c,LineItem__c,(SELECT Name,Accessory__c,Accessory__r.Name FROM Product_Lists__r)  FROM Product__c where (Brand_Picklist__c LIKE :searchString OR Name LIKE :searchString) 
              AND ID NOT IN:proList AND ID IN:productsExclusivities AND Activate__c=true];
    }

    
    //get brands by using opportunity Id
     @AuraEnabled(cacheable=true)
    public static List<Product_Category__c> getBrands(String opportunityId) {
        BiomatiQ_Lead__c opportunityRec=[Select Id,Name,Company_Name__c,Domain__c From BiomatiQ_Lead__c Where Id=:opportunityId];
        Account accountRec=[Select Id,Name,Industry,ShippingState From Account Where Id=:opportunityRec.Company_Name__c];
  
        List<Exclusivity__c> exclusivityList=[Select Id,Name,Account_Wise_Exclusivity__c,Brand_Product_Category__c,Industry_Wise_Exclusivity__c From Exclusivity__c 
                                              where (Account_Wise_Exclusivity__c=:accountRec.Id OR (Multi_Regionwise_Exclusivity__c Includes(:'All') AND Industry_Wise_Exclusivity__c Includes(:'All Industries',:accountRec.Industry,:'' ))
                                             OR (Multi_Regionwise_Exclusivity__c Includes(:accountRec.ShippingState) AND Industry_Wise_Exclusivity__c Includes(:'All Industries',:accountRec.Industry,:'' ))  ) AND (Dealing_Through__c=:opportunityRec.Domain__c)];
        Set<Id> categoryIds=New Set<Id>();
        for(Exclusivity__c exc:exclusivityList ){
            categoryIds.add(exc.Brand_Product_Category__c);
        }
        
      return [SELECT Id, Name,Brand_Name__c FROM Product_Category__c where Id IN:categoryIds AND Activate__c=true];
   }
    
    //get brands by using search string
    
     @AuraEnabled(cacheable=true)
    public static List<Product_Category__c> getBrandsByString(String searchValue,List<Id> brandIds,List<Id> selectIds) {
      String searchString = '%' + searchValue + '%';
      
      return [SELECT Id, Name,Brand_Name__c FROM Product_Category__c where (Brand_Name__c LIKE :searchString)  AND Activate__c=true AND Id IN:brandIds AND ID NOT IN:selectIds	];
    }
    
     @AuraEnabled(cacheable=true)
    public static List<Product_List_Items__c> getProductListItem(string recordId) {
        System.debug(recordId);
      return [SELECT Id, Name, Product_Name__c FROM Product_List_Items__c WHERE Product_Name__c=:recordId];
    }
     
    
    @AuraEnabled
    public static List<Product_List__c>  addProductLine( String recId,List<Product_List__c> proList) {
        List<Product_List__c> listProduct=new  List<Product_List__c>();
        Product_List__c pro=new Product_List__c();
        for(Product_List__c lst:proList){
        pro.Opportunity__c=recId;
        //pro.Name=lst.name;
        pro.Product__c=lst.Product__c;
      //  pro.Quantity__c=lst.Quantity__c;
        //pro.Unit_Price__c=lst.listprice;
        listProduct.add(pro);
        }
        insert listProduct;
        
        return listProduct;
        
        //insert recId;
        //return recId;
       
    }
      /*@AuraEnabled(cacheable=true)
    public static BiomatiQ_Lead__c paymentTerm (string recId){
         BiomatiQ_Lead__c oppdetail=new BiomatiQ_Lead__c();
         oppdetail=[SELECT Id,Name,Company_Name__c,Company_Name__r.Payment_Term__c  From BiomatiQ_Lead__c Where Id=:recId];
        return oppdetail;
    }
       */
   @AuraEnabled
     public static  List<Product_List__c> getNewOrder1(String objectApiName,String recId,List<String> proid,List<String> insertedProducts){
         //sObject sObj = Schema.getGlobalDescribe().get(objectApiName).newSObject(); 
      
         system.debug('recId==>'+recId);
         system.debug('proid==>'+proid);
         system.debug('insertedProducts==>'+insertedProducts);
          BiomatiQ_Lead__c oppdetail=new BiomatiQ_Lead__c();
         oppdetail=[SELECT Id,Name,Company_Name__c,GST_Location__c,Company_Name__r.Deemed_Export__c,Company_Name__r.Payment_Term__c,Company_Name__r.GST_Treatment__c,Price_Book__c,Price_Book__r.Name  From BiomatiQ_Lead__c Where Id=:recId];
         List<Product__c> prolist=new List<Product__c>();
         
             prolist=[SELECT Id, Name,Sub_Category__c, Selling_Price__c,Tax_GST__c,Brand_Picklist__c,Pack_Size_Quantity__c FROM Product__c Where Id IN:proid AND ID NOT IN:insertedProducts];
    List<BiomatiQ_Book_Entry__c> priceBookEntries=[Select Id,Name,Biomatiq_Price_Book__c,Selling_Price__c,Product__c,Active__c From BiomatiQ_Book_Entry__c Where Biomatiq_Price_Book__c=:oppdetail.Price_Book__c];
         Map<Id,BiomatiQ_Book_Entry__c> productPricbookMap=New Map<Id,BiomatiQ_Book_Entry__c>();
         if(priceBookEntries.size()>0){
         for(BiomatiQ_Book_Entry__c pbe:priceBookEntries){
             if(!productPricbookMap.containsKey(pbe.Product__c)){
             productPricbookMap.put(pbe.Product__c,pbe);
             }
         }
         }
         string gstTreatment=oppdetail.Company_Name__r.GST_Treatment__c;
         String gstLocation=oppdetail.GST_Location__c;
         Decimal sellingPrice=0;
         system.debug('gstLocation'+gstLocation);
          system.debug('prolist'+prolist);
         List<Product_List__c> proLineItem=new List<Product_List__c>();
         for(Product__c pro:prolist){
          Product_List__c pr=new Product_List__c();
                pr.Opportunity__c=recId;
                //pr.Name=pro.Name;
               
                pr.Brand_Name_Text__c=pro.Brand_Picklist__c;
                pr.Product_Name_Text__c=pro.Name;
             if(productPricbookMap.get(pro.Id)!=null && productPricbookMap.get(pro.Id).Selling_Price__c!=null){
             sellingPrice=productPricbookMap.get(pro.Id).Selling_Price__c;
             }
                pr.Selling_Price__c=sellingPrice;
             pr.Sub_Category__c=pro.Sub_Category__c;
             //pr.Eligible_Discount__c=5;
                pr.Final_Selling_Price__c=sellingPrice;
             if(pro.Tax_GST__c!=null){
                System.debug('value111>>'+pro.Tax_GST__c.removeEnd('%'));
                Decimal taxVal=Decimal.valueOf(pro.Tax_GST__c.removeEnd('%'));
             System.debug('tax'+taxVal);
                pr.IGST__c=taxVal;
                pr.SGST__c=taxVal/2;
                 pr.Cgst__c=taxVal/2;
             
             System.debug('Cgst__c '+ pr.Cgst__c);
             
             //GST Treatment based gst calculation
if(gstTreatment=='Registred Business - Regular')  {  
if(gstLocation=='Intra State'){  //Regular GST (CGST & SGST) (Same State)
                pr.SGST__c=taxVal/2;
                 pr.Cgst__c=taxVal/2;
}

else if(gstLocation=='Inter State'){//Regular (IGST) (Other State)
 pr.IGST__c=taxVal;

}
}

else if(gstTreatment=='Special Economic Zone'){ //SEZ GST (Other state) || SEZ GST (Same State)
 pr.IGST__c=0;
  pr.SGST__c=0;
 pr.Cgst__c=0;
}

else if(gstTreatment=='Insititutes'){
if(gstLocation=='Intra State'){ //Insititutes (Same State)
pr.SGST__c=2.5;
pr.Cgst__c=2.5;
}
else if(gstLocation=='Inter State'){ //Insititutes (Other State)
 pr.IGST__c=5;
}
}

else if(gstTreatment=='SEZ Developer' || gstTreatment=='Tax Deductor'){//SEZ Developer  (Same State) || SEZ Developer  (Other state) || Tax Deductor
	pr.IGST__c=0;
  pr.SGST__c=0;
 pr.Cgst__c=0;
             
}

else if(gstTreatment=='Deemed Export'){ //Deemed Export
    if(oppdetail.Company_Name__r.Deemed_Export__c!=null){
	pr.IGST__c=Decimal.valueOf(oppdetail.Company_Name__r.Deemed_Export__c.removeEnd('%'));
    }    

}
	
else if(gstTreatment=='overseas'){//Export/Overseas GST
	pr.IGST__c=0	;

             
}
           
}
         
                pr.Product__c=pro.Id;
                proLineItem.add(pr);
                
         }
       
         List<Product_List__c> pro=new List<Product_List__c>();
         if(proLineItem.size()>0){
             insert proLineItem;
              system.debug('proLineItem'+proLineItem);
          
          
         Set<Id> prodListIdSet=new Set<Id>();
         for(Product_List__c c:proLineItem){
             prodListIdSet.add(c.Id);
            
         }       
          pro=[SELECT Id, Name,Selling_Price__c,Eligible_Discount__c,Brand_Name_Text__c,Product__c,GST_Number__c,Opportunity__c,Opportunity__r.GST_Location__c,Product_Name_Text__c,IGST__c, Discount__c,Quantity__c,SGST__c,Cgst__c  FROM Product_List__c WHERE Id IN:prodListIdSet OR (Product__c=:insertedProducts And Opportunity__c=:recId)];
             system.debug('ReturnproList'+pro);
         
          return pro;
      
         }else{
              pro=[SELECT Id, Name,Selling_Price__c,Eligible_Discount__c,Brand_Name_Text__c,Product__c,GST_Number__c,Opportunity__c,Opportunity__r.GST_Location__c,Product_Name_Text__c,IGST__c, Discount__c,Quantity__c,SGST__c,Cgst__c  FROM Product_List__c WHERE Product__c IN:proid And Opportunity__c=:recId];
             system.debug('ReturnproList'+pro);
         
          return pro;
             
         }
          
       
  }
      
    
     @AuraEnabled
     public static  void saveProdListWithBrand(String recId,List<String> brandIds){
         
         List<Product_List__c> prodList=new List<Product_List__c>();
          List<Product_Category__c> prodCatgory=[Select Id,Name,Brand_Name__c from Product_Category__c where id IN:brandIds];
         for(Product_Category__c pc:prodCatgory){
             Product_List__c pl=new Product_List__c();
             pl.Opportunity__c=recId;
             pl.Sub_Category__c=pc.Id;
             pl.Brand_Name_Text__c=pc.Brand_Name__c;
             prodList.add(pl);
         }
         if(prodList.size()>0){
             insert prodList;
         }
     }
    
    
    
    
   @AuraEnabled
  public static string updateProducts(Object data) {
      List<Product_List__c> contactsForUpdate = (List<Product_List__c>) JSON.deserialize(
           JSON.serialize(data),
           List<Product_List__c>.class
      );
      try {
          update contactsForUpdate;
          return 'Success: Products updated successfully';
      }
      catch (Exception e) {
          return 'The following exception has occurred: ' + e.getMessage();
      }
  }
      /* @AuraEnabled(Cacheable = true)
      public static List<ProductLineItem__c> getpro() {
   
          
   
          return pro;
      }*/ 
     @AuraEnabled
    public static Product_List__c deleteSelectedAccount(string recordIdToDelete) {
        System.debug(recordIdToDelete);
      Product_List__c proDelList=[SELECT Id,Name,Quantity__c,	Opportunity__c,Product__c,SGST__c,Cgst__c,IGST__c,Discount__c FROM Product_List__c WHERE Id=:recordIdToDelete];
      System.debug(proDelList);
      delete proDelList;
      return null;
    }

    @AuraEnabled(cacheable=true)
    public static BiomatiQ_Lead__c oppDetails(String oppId){
      return [SELECT Id,Name,Lead_Status__c,Price_Book__c,Price_Book__r.Name  From BiomatiQ_Lead__c Where Id=:oppId];

    }
       @AuraEnabled(cacheable=true)
    public static List<BiomatiQ_Price_Book__c> getPriceBooks(){

      return [SELECT Id,Name  From BiomatiQ_Price_Book__c ];

    }
       @AuraEnabled(cacheable=true)
    public static Map<Id,BiomatiQ_Book_Entry__c> getAllPriceBookEntries(String oppId){
        BiomatiQ_Lead__c oppdetail=[SELECT Id,Name,Company_Name__c,GST_Location__c,Company_Name__r.Deemed_Export__c,Company_Name__r.Payment_Term__c,Company_Name__r.GST_Treatment__c,Price_Book__c,Price_Book__r.Name  From BiomatiQ_Lead__c Where Id=:oppId];
    List<BiomatiQ_Book_Entry__c> priceBookEntries=[Select Id,Name,Biomatiq_Price_Book__c,Selling_Price__c,Product__c,Active__c From BiomatiQ_Book_Entry__c Where Biomatiq_Price_Book__c=:oppdetail.Price_Book__c];
      Map<Id,BiomatiQ_Book_Entry__c> productPricbookMap=New Map<Id,BiomatiQ_Book_Entry__c>();
         if(priceBookEntries.size()>0){
         for(BiomatiQ_Book_Entry__c pbe:priceBookEntries){
             if(!productPricbookMap.containsKey(pbe.Product__c)){
             productPricbookMap.put(pbe.Product__c,pbe);
             }
         }
         }
        

        return productPricbookMap;

    }
    

}