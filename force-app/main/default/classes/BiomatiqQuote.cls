/*
 VfPage:BiomatiqQuote
Controller:BiomatiqQuote
TestClass:BiomatiqQuoteTest
Developer:Gowtham
*/

public class BiomatiqQuote {
  public Quotes__c qte{get;set;}
   // public List<Product_List__c> products{get;set;}
    public List<Quote_Line_Item__c> products{get;set;}
    public BiomatiQ_Lead__c opps{get;set;}
    public Static String quoteNo{get;set;}
  
       public String gstLocation{get;set;}
    public String domain{get;set;}
     public User prod{get;set;}
    //public Contact cont{get;set;}
   public Account acct{get;set;}
    
    public String placeOfSupply{get;set;}
    public String CompanyName{get;set;}
    
    public Double TotalDiscountAmount{get;set;}
    public Double TotalCGSTAmount{get;set;}
    public Double TotalSGSTAmount{get;set;}
     public Double TotalIGSTAmount{get;set;}
    public Double TotalTaxableAmount{get;set;}
   
    public Decimal  TotalIGSTDiscount{get;set;}
    public Decimal  TotalCGSTDiscount{get;set;}
    public Decimal  TotalSGSTDiscount{get;set;}
    
        public Double GrandTotal{get;set;}
   public Double  grandIGSTAmount{get;set;}
    public Double AmountNonGST{get;set;}
    public String AmountTotalWords{get;set;}
    public Integer currentYear = System.Today().year();
    public Integer nextYear = system.today().year()+1;
public String baseURL{get;set;}
  public id qid{get;set;}
    public  BiomatiqQuote(ApexPages.StandardController controller) {
     qid = System.currentPageReference().getParameters().get('id');
  baseURL = URL.getSalesforceBaseUrl().toExternalForm();
        system.debug('qid'+qid);
        Double AmountToConvert=0.00;
       // Quotes = new list<Quotes__c>();
        qte = [select Id, Name,Opportunity__c,EstimateDate__c from Quotes__c Where Quotes__c.Id  =:qid];
        String oppty=qte.Opportunity__c;
        products=new list<Quote_Line_Item__c>();
        system.debug('*********'+qte);
      //  products=[SELECT Id,Name,Quantity__c,Unit_Price__c,Discount__c,Total_IGST__c,Discount_Amount__c,IGST_Amount__c,Selling_Price__c,Taxable_Amount__c,Total__c,SGST_Amount__c,CGST_Amount__c,Total_Price__c,Amt__c,Opportunity__c,Brand_Name_Text__c,Product__r.Pack_Size_Quantity__c,Product__r.HSN_Code__c,Product__c,Product__r.Name,Cgst__c,SGST__c,IGST__c,Amount_in_Rupees__c FROM Product_List__c Where Opportunity__c=:oppty];  
  products=[SELECT Id,Name,Quantity__c,Discount__c,Brand_Name__c,Discount_Amount__c,Total_Amount__c,IGST_Amount__c,Selling_Price__c,Taxable_Amount__c,SGST_Amount__c,CGST_Amount__c,Total_Price__c,Product__r.Pack_Size_Quantity__c,Product__r.HSN_Code__c,Product__c,Product__r.Name,Cgst__c,SGST__c,IGST__c,Product__r.Cat_No__c FROM Quote_Line_Item__c Where QuoteId__c=:qid];  
        system.debug('products'+products);
        
       TotalDiscountAmount=0.00;
       TotalCGSTAmount=0.00; TotalSGSTAmount=0.00; TotalIGSTAmount=0.00;
        TotalTaxableAmount=0.00;
        grandIGSTAmount=0.00;
        GrandTotal=0.00;AmountNonGST=0.00;
        TotalIGSTDiscount=0;
        TotalCGSTDiscount=0;
        TotalSGSTDiscount=0;
      /*  for(Product_List__c prods:products){
            TotalDiscountAmount=TotalDiscountAmount+prods.Discount_Amount__c;
            TotalCGSTAmount=TotalCGSTAmount+prods.CGST_Amount__c;
            TotalSGSTAmount=TotalSGSTAmount+prods.SGST_Amount__c;
            TotalIGSTAmount=TotalIGSTAmount+prods.IGST_Amount__c;
            grandIGSTAmount=grandIGSTAmount+prods.Total_IGST__c;
            AmountNonGST=AmountNonGST+prods.Total__c;
            TotalTaxableAmount=TotalTaxableAmount+prods.Taxable_Amount__c;
            GrandTotal=GrandTotal+prods.Total__c;
            TotalIGSTDiscount=TotalIGSTDiscount+prods.IGST__c;
            TotalCGSTDiscount=TotalCGSTDiscount+prods.Cgst__c;
            TotalSGSTDiscount=TotalSGSTDiscount+prods.SGST__c;
        }*/
        for(Quote_Line_Item__c prods:products){
            TotalDiscountAmount=TotalDiscountAmount+prods.Discount_Amount__c;
            TotalCGSTAmount=TotalCGSTAmount+prods.CGST_Amount__c;
            TotalSGSTAmount=TotalSGSTAmount+prods.SGST_Amount__c;
            TotalIGSTAmount=TotalIGSTAmount+prods.IGST_Amount__c;
            grandIGSTAmount=grandIGSTAmount+prods.Total_Amount__c;
            AmountNonGST=AmountNonGST+prods.Total_Price__c;
            TotalTaxableAmount=TotalTaxableAmount+prods.Taxable_Amount__c;
            GrandTotal=GrandTotal+prods.Total_Price__c;
            TotalIGSTDiscount=TotalIGSTDiscount+prods.IGST__c;
            TotalCGSTDiscount=TotalCGSTDiscount+prods.Cgst__c;
            TotalSGSTDiscount=TotalSGSTDiscount+prods.SGST__c;
        }
        
        opps=[SELECT Id,Name,TotalGst__c,Total_Gst_Amount__c,GST_Location__c,Company_Name__c,Mobile__c,Contact__c,OwnerId	,Subtotal__c,Grand_Total__c,Amount_In_Words__c,Total_Items__c,Domain__c,Opportunity_Product_Category__c FROM BiomatiQ_Lead__c Where Id=:oppty];  
     system.debug('opps'+opps);
        if(opps.GST_Location__c=='Intra State'){
           gstLocation='Intra State';
            AmountToConvert=GrandTotal;
        }else if(opps.GST_Location__c=='Inter State'){
            gstLocation='Inter State';
             AmountToConvert=grandIGSTAmount;
        }
        else if(opps.GST_Location__c=='No GST'){
            gstLocation='No GST';
            AmountToConvert=TotalTaxableAmount;
        }else{}
        
        if(opps.Domain__c=='Biomatiq'){
            domain='Biomatiq';
            
        }else if(opps.Domain__c=='E-Scientic'){
            domain='EScientic';
        }
        else{ }
                        //Domain Biomatiq        
            if(opps.Domain__c=='Biomatiq' && opps.Opportunity_Product_Category__c=='Laboratory Consumables'){
              quoteNo='EST/BQS/LC/'+currentYear+'-'+ nextYear+'/'+qte.Name;
            }else if(opps.Domain__c=='Biomatiq' && opps.Opportunity_Product_Category__c=='Laboratory Equipment'){
              quoteNo='EST/BQS/LE/'+currentYear+'-'+ nextYear+'/'+qte.Name;
            }else if(opps.Domain__c=='Biomatiq' && opps.Opportunity_Product_Category__c=='Microbiology Solutions'){
              quoteNo='EST/BQS/MS/'+currentYear+'-'+ nextYear+'/'+qte.Name; 
             }else if(opps.Domain__c=='Biomatiq' && opps.Opportunity_Product_Category__c=='Molecular Biology'){
              quoteNo='EST/BQS/MB/'+currentYear+'-'+ nextYear+'/'+qte.Name; 
             }else if(opps.Domain__c=='Biomatiq' && opps.Opportunity_Product_Category__c=='Process Solutions'){
              quoteNo='EST/BQS/PS/'+currentYear+'-'+ nextYear+'/'+qte.Name; 
             }
                      //Domain E-Scientic
             else if(opps.Domain__c=='E-Scientic' && opps.Opportunity_Product_Category__c=='Laboratory Consumables'){
              quoteNo='EST/ESLE/LC/'+currentYear+'-'+ nextYear+'/'+qte.Name;
            }else if(opps.Domain__c=='E-Scientic' && opps.Opportunity_Product_Category__c=='Laboratory Equipment'){
              quoteNo='EST/ESLE/LE/'+currentYear+'-'+ nextYear+'/'+qte.Name;  
            }else if(opps.Domain__c=='E-Scientic' && opps.Opportunity_Product_Category__c=='Microbiology Solutions'){
              quoteNo='EST/ESLE/MS/'+currentYear+'-'+ nextYear+'/'+qte.Name;  
            }else if(opps.Domain__c=='E-Scientic' && opps.Opportunity_Product_Category__c=='Molecular Biology'){
              quoteNo='EST/ESLE/MB/'+currentYear+'-'+ nextYear+'/'+qte.Name;  
            }else if(opps.Domain__c=='E-Scientic' && opps.Opportunity_Product_Category__c=='Process Solutions'){
              quoteNo='EST/ESLE/PS/'+currentYear+'-'+ nextYear+'/'+qte.Name;  
            }
            else{   }
       
         //cont=[SELECT Id,Name,MailingStreet,MailingCity,MailingCountry,MailingState,MailingPostalCode from Contact where Id=:opps.Contact__c];
       acct=[SELECT Id,Name,Country__c,ParentId,Territory__c,State__c,BillingStreet, BillingCity, BillingState, BillingPostalCode, BillingCountry, ShippingStreet, ShippingCity, ShippingState, ShippingPostalCode, ShippingCountry From Account where Id=:opps.Company_Name__c];
      
        Account acc=new Account();
        if(acct.Country__c == 'India')
        {
        placeOfSupply=acct.Territory__c;
            
        }
        
        else if(acct.Country__c == 'Out of India')
        {
            placeOfSupply=acct.State__c;
        }
        if(acct.ParentId!=null)
        {
              Account acc1=[select id,Name from Account where id=:acct.ParentId];
         CompanyName=acc1.Name;
        }
        else if(acct.ParentId==null) 
        {
          CompanyName=acct.Name;
 
        }
        
        prod=[SELECT Id,Name from User where id=:opps.OwnerId];
       
        
        //----------------     Amount in Words-------------------
        if(AmountToConvert != null && AmountToConvert >= 0){
         Decimal Num = AmountToConvert; // This is your Number
String strVal = String.ValueOf(Num); // Convert Number to string
List<String> lstNum = strVal.Split('\\.'); // Split number by dot, List size will be two.
String NumberToString = '';
String p=lstNum[0];
            String q=lstNum[1];
Decimal strToDec = decimal.valueOf(p);
          Decimal strToDec1 = decimal.valueOf(q);
            Long lm = strToDec.longValue();
              Long mn = strToDec1.longValue();
            String NumberToString1 =AmountInWords.english_number(lm);// Get Number to String of before decimal place.
                String NumberToString2 =AmountInWords.english_number(mn);// Get Number to String of after decimal place.
            if(mn!=0){
NumberToString = NumberToString1 +' and '+ NumberToString2 +' Paise Only'; // here you will get exact out put.
            }else{
            NumberToString = NumberToString1 +' Only' ;
            }
       String amo1 = NumberToString.remove(',');
             AmountTotalWords = amo1 ;
              System.debug('Grand Total String field '+AmountTotalWords);
                 
        } else {
            AmountTotalWords = null;
        }
        

    }
      
  /*public ApexPages.PageReference page2{get;set;}
    
    public PageReference Cancel()
    {
        PageReference Pdf = new PageReference('/'+qid);
        pdf.setredirect(True);
        return Pdf;
    }
    
   
    
    public PageReference pdfAction()
    {
        PageReference savepage ;
        savepage = Page.BiomatiqQuote;
        savepage.getParameters().put('id',qid);
savepage.setRedirect(true);
        
       List<Attachment> attch=[SELECT Id, ParentId, Name, ContentType, Body FROM Attachment where ParentId=:qid Order By Name Asc];
Attachment attach = new Attachment();
Blob b ;
b = savepage.getContent();
attach.Body = b;
        Integer attSize=attch.Size()+1;
attach.Name = quoteNo+String.valueOf(attSize);
attach.IsPrivate = false;
        
attach.ParentId = qid;
insert attach;
         
             PageReference pageRef = new PageReference( baseURL+'/lightning/r/Quotes__c/' + System.currentPageReference().getParameters().get('id')+'/view');
            pageRef.setRedirect(true);
            //system.debug('pageRef@@@ ' + pageRef);
            return pageRef;
            
        }
        
        */
     
        
        
        
    }