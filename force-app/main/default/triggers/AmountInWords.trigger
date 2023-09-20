/*Class:AmountInWords
 Trigger:AmountInWords
TestClass:AmountInWordsTest
VfPage:BiomatiqQuote
Developer:Gowtham.K*/


trigger AmountInWords on BiomatiQ_Lead__c (before insert,before update) {
    
    if(trigger.isInsert || trigger.isUpdate){
                    BiomatiQ_Price_Book__c pb=[Select Id,Name,Is_Standard_Price_Book__c From BiomatiQ_Price_Book__c where Is_Standard_Price_Book__c=:true Limit 1];
        if(trigger.isInsert){
          for (BiomatiQ_Lead__c c : Trigger.new) { 
              c.Owner__c=c.OwnerId;
              c.Price_Book__c=pb.Id;
          }
        }
        
        if(trigger.isUpdate){
                     OpportunitiesHandler.contactBasedEmailPhone(Trigger.new,Trigger.oldMap);
          for (BiomatiQ_Lead__c c : Trigger.new) { 
              if(Trigger.oldmap.get(c.id).OwnerId != c.OwnerId){      
              c.Owner__c=c.OwnerId;
          }
              if(c.Price_Book__c == null){
                  c.Price_Book__c=pb.Id;
              }
          }
        }
 for (BiomatiQ_Lead__c c : Trigger.new) { 
     
     
        if (c.Grand_Total__c != null && c.Grand_Total__c >= 0) {
            Decimal Num = c.Grand_Total__c; // This is your Number
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
             c.Amount_In_Words__c = amo1 ;
              System.debug('Grand Total String field '+c.Amount_In_Words__c);
                 
        } else {
            c.Amount_In_Words__c = null;
        }
    }
    }
    
    
}