public class ExclusivityTriggerHandler {
    
    
    Public static void restrictRegionWiseBeforeInsert(List<Exclusivity__c> excluList){
        
       
        
       Id brandProductId=excluList[0].Brand_Product_Category__c;
        
       List<Exclusivity__c> ecList=[Select Id,Brand_Product_Category__r.Name,Multi_Regionwise_Exclusivity__c,Dealing_Through__c from Exclusivity__c where Brand_Product_Category__c=:brandProductId];
      
        for(Exclusivity__c e:ecList){
            
            if(e.Multi_Regionwise_Exclusivity__c =='All'){
                excluList[0].addError('Already, the'+' '+e.Brand_Product_Category__r.Name+' '+'Subcategory has'+' '+e.Dealing_Through__c+' '+'Dealing Through with All State');

            }else if(e.Multi_Regionwise_Exclusivity__c !=null && excluList[0].Multi_Regionwise_Exclusivity__c =='All'){
               excluList[0].addError('Already, the'+' '+e.Brand_Product_Category__r.Name+' '+'Subcategory has'+' '+e.Dealing_Through__c+' '+'Dealing Through with'+' '+e.Multi_Regionwise_Exclusivity__c);

            }else if(e.Multi_Regionwise_Exclusivity__c==excluList[0].Multi_Regionwise_Exclusivity__c && e.Dealing_Through__c !=excluList[0].Dealing_Through__c && excluList[0].Multi_Regionwise_Exclusivity__c !=null){
               excluList[0].addError('Already, the'+' '+e.Brand_Product_Category__r.Name+' '+'Subcategory has'+' '+e.Dealing_Through__c+' '+'Dealing Through with'+' '+e.Multi_Regionwise_Exclusivity__c);
                
            }
            
        }
                
    }
    /*****Check the existing records information Before update the records**************/ 
     Public static void restrictRegionWiseBeforeUpdate(List<Exclusivity__c> excluList,List<Exclusivity__c> oldExcluList){
        
       
        
       Id brandProductId=excluList[0].Brand_Product_Category__c;
       Id excId=oldExcluList[0].Id;
       List<Exclusivity__c> ecList=[Select Id,Brand_Product_Category__r.Name,Multi_Regionwise_Exclusivity__c,Dealing_Through__c from Exclusivity__c where Brand_Product_Category__c=:brandProductId And Id !=:excId];
      
        for(Exclusivity__c e:ecList){
            
            if(e.Multi_Regionwise_Exclusivity__c =='All'){
                excluList[0].addError('Already, the'+' '+e.Brand_Product_Category__r.Name+' '+'Subcategory has'+' '+e.Dealing_Through__c+' '+'Dealing Through with All State');

            }else if(e.Multi_Regionwise_Exclusivity__c !=null && excluList[0].Multi_Regionwise_Exclusivity__c =='All'){
               excluList[0].addError('Already, the'+' '+e.Brand_Product_Category__r.Name+' '+'Subcategory has'+' '+e.Dealing_Through__c+' '+'Dealing Through with'+' '+e.Multi_Regionwise_Exclusivity__c);

            }else if(e.Multi_Regionwise_Exclusivity__c==excluList[0].Multi_Regionwise_Exclusivity__c && e.Dealing_Through__c !=excluList[0].Dealing_Through__c && excluList[0].Multi_Regionwise_Exclusivity__c !=null){
               excluList[0].addError('Already, the'+' '+e.Brand_Product_Category__r.Name+' '+'Subcategory has'+' '+e.Dealing_Through__c+' '+'Dealing Through with'+' '+e.Multi_Regionwise_Exclusivity__c);
                
            }
            
        }
                
    }



}