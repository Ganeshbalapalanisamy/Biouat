/*
 * Class Name : QuoteTriggerHandler
 * Test Class : QuoteTriggerHandlerTestClass
 * Trigger    : QuoteTrigger
 * Created Date : 13/4/2023
*/

public class QuoteTriggerHandler {
    public static void checkProductList(List<Quotes__c> quoteList){
      string qversion;
        String oppId;
        for(Quotes__c qc:quoteList){
            oppId=qc.Opportunity__c;
           
        }
        if(oppId!=null){
        BiomatiQ_Lead__c opp=[Select Id,Name,Lead_Status__c from BiomatiQ_Lead__c Where Id=:oppId];
              List<Quotes__c> qtList=[Select Id,Name From Quotes__c where Opportunity__c=:oppId];
                qversion=String.valueOf(qtList.size()+1);
             Integer highestNumber ;
            List<Integer> qNumber=New List<Integer>();
            for(Quotes__c q:qtList){
                if(qtList.size()>1){
               String verNum = q.Name.substring(q.Name.indexOf('V') + 1);
                     Integer resInt=Integer.valueOf(verNum);
                    qNumber.add(resInt);
                  }
            }
            if(qNumber.size()>0){
                 highestNumber = qNumber[0]; 
for (Integer num : qNumber) {
    highestNumber = Math.max(highestNumber, num);
}
            }
            
              for(Quotes__c qc:quoteList){
                   String oppname=opp.Name.substring(1, opp.Name.length());
            qc.Name='Q'+oppname+'-V'+qversion;
                  if(qtList.size()>1){
                      qversion=String.valueOf(highestNumber+1);
                       qc.Name='Q'+oppname+'-V'+qversion;   
                  }
         
        }
            
            
            System.debug('statue '+opp.Lead_Status__c);
            if(opp.Lead_Status__c!='Yet to Tap' && opp.Lead_Status__c!='Customer Engagement' &&  opp.Lead_Status__c!='None'  ){
        List<Product_List__c> prodList=[Select Id,Approval_status__c,Approvar__c,Name,Product__c,Opportunity__c From Product_List__c where 
                                       Opportunity__c=:oppId];
        Set<String> waitingProducts=New set<String>();
        for(Product_List__c pl:prodList){
            if(pl.Approval_status__c=='Inprogress'){
                waitingProducts.add(pl.Name);
            }
        }
                
        if(waitingProducts.size()>0){
            for(Quotes__c qc:quoteList){
            qc.addError('Few Products are waiting for discount approval.You cannot create quote until those products get approved or rejected' );
        }
        }
                
         for(Product_List__c pl:prodList){
             if(pl.Product__c == null){
                  for(Quotes__c qc:quoteList){
                       qc.addError('You cannot create a quote due to no more products available in opportunities. Please add products to the opportunities.');
                  }
             }
        }
        }
        
        else{
             for(Quotes__c qc:quoteList){
            qc.addError('From the Opportunity-stage Technical Qualification only you can create quotes.' );
        }
        }
        }
    }
    
    public static void createQuoteLineItem(List<Quotes__c> quoteList){
        List<Quote_Line_Item__c> qlListToInsert=New list<Quote_Line_Item__c>();
        List<Product_List__c> prodList=New List<Product_List__c>();
        String oppid;String QuoteId;
        for(Quotes__c q:quoteList){
            QuoteId=q.Id;
            oppid=q.Opportunity__c;  
        }
    prodList=[Select Id,Name,Quantity__c,Total_Discount_Amount__c,Total_IGST__c,Taxable_Amount__c,Total__c,SGST_Amount__c,
             SGST__c,Product__c,Product_Name_Text__c,IGST_Amount__c,IGST__c,Selling_Price__c,Discount__c,Discount_Amount__c,Cgst__c,CGST_Amount__c,Brand_Name_Text__c,
             Total_Price__c,Opportunity__c,Product_List__c.Sub_Category__c,Product_List__c.GST_Number__c From Product_List__c Where Opportunity__c=:oppid];
        
        for(Product_List__c pl:prodList){
            Quote_Line_Item__c ql=New Quote_Line_Item__c();
            ql.QuoteId__c=QuoteId;
            ql.Product__c=pl.Product__c;
            ql.Selling_Price__c=pl.Selling_Price__c;ql.Brand_Name__c=pl.Brand_Name_Text__c;ql.SubCategory__c=pl.Sub_Category__c;
            ql.Quantity__c=pl.Quantity__c;ql.CGST__c=pl.Cgst__c;ql.CGST_Amount__c=pl.CGST_Amount__c;
            ql.IGST__c=pl.IGST__c;ql.IGST_Amount__c=pl.IGST_Amount__c;ql.SGST__c=pl.SGST__c;ql.SGST_Amount__c=pl.SGST_Amount__c;
            ql.Taxable_Amount__c=pl.Taxable_Amount__c;ql.Total_Discount_Amount__c=pl.Total_Discount_Amount__c;ql.Total_Price__c=pl.Total_Price__c;
            ql.Discount__c=pl.Discount__c;ql.Discount_Amount__c=pl.Discount_Amount__c;ql.Taxable_Amount__c=pl.Taxable_Amount__c;ql.GST_Location__c=pl.GST_Number__c;
            if(pl.GST_Number__c=='Intra State'){
            ql.Total_Amount__c=pl.Total__c;
            }
            else if(pl.GST_Number__c=='Inter State'){
                ql.Total_Amount__c=pl.Total_IGST__c;
            }
            
            
            qlListToInsert.add(ql);
        }
        if(qlListToInsert.size()>0){
            try{
                Database.insert(qlListToInsert)	;
            }
            catch(Exception e){
                system.debug('Error '+e);
            }
        }        
    }
    
}