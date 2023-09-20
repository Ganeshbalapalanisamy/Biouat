/* Trigger:PriceBookEntryTrigger
Class:PriceBookEntryTriggerHandler
TestClass:PriceBookEntryTriggerHandlerTest
Developer:Gowtham.K
Created Date : 26/06/2023*/

public class PriceBookEntryTriggerHandler {
    public static void beforeInsert(List<BiomatiQ_Book_Entry__c> priceBookEntry){
      BiomatiQ_Price_Book__c pb=[Select Id,Name,Is_Standard_Price_Book__c From BiomatiQ_Price_Book__c where Is_Standard_Price_Book__c=:true Limit 1];
        string prodId;
        String priceBookId;
        for(BiomatiQ_Book_Entry__c pbe:priceBookEntry){
            prodId=pbe.Product__c;
            priceBookId=pbe.Biomatiq_Price_Book__c;
        }
        try{
            BiomatiQ_Book_Entry__c productsPriceBookEntries=[Select Id,Name,Biomatiq_Price_Book__c,Product__c From BiomatiQ_Book_Entry__c where Product__c=:prodId AND Biomatiq_Price_Book__c=:pb.Id];
         System.debug('productsPriceBookEntries'+productsPriceBookEntries);
        }
        catch(Exception e){
           System.debug('er'+e);  
                   if(priceBookId!=pb.Id){
             for(BiomatiQ_Book_Entry__c pbe:priceBookEntry){
           pbe.addError('Please create the statndard price first');
        }
        } 
        }
        
           

        
    }
}