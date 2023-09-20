public with sharing class ReusableLookupController {
    @AuraEnabled
    public static List<ResultWrapper> fetchRecords(SearchWrapper inputWrapper) {
        try {
            if(inputWrapper != null){
                String fieldsToQuery = 'SELECT Id, ';
                if(string.isNotBlank(inputWrapper.fieldApiName)){
                    fieldsToQuery = fieldsToQuery + inputWrapper.fieldApiName;
                }
                if(string.isNotBlank(inputWrapper.otherFieldApiName)){
                    fieldsToQuery = fieldsToQuery + ', ' + inputWrapper.otherFieldApiName;
                }
                String query = fieldsToQuery + ' FROM '+ inputWrapper.objectApiName;
                String filterCriteria = inputWrapper.fieldApiName + ' LIKE ' + '\'' + String.escapeSingleQuotes(inputWrapper.searchString.trim()) + '%\' LIMIT 5';
                String productType='Product_Type__c=\'Accessory\' AND ';
                query += ' WHERE '+productType+filterCriteria;
               
                /*if(String.isNotBlank(inputWrapper.selectedRecordId)) {
                    query += ' WHERE Id = \''+ inputWrapper.selectedRecordId + '\'';
                }
                else if(String.isNotBlank(inputWrapper.parentFieldApiName) && String.isNotBlank(inputWrapper.parentRecordId)){
                    query += ' WHERE '+ inputWrapper.parentFieldApiName+ ' = \''+ inputWrapper.parentRecordId + '\'';
                    query += ' AND ' + filterCriteria;
                }
                else {
                   
                }*/ 
                List<ResultWrapper> returnWrapperList = new List<ResultWrapper>();
                for(SObject s : Database.query(query)) {
                    ResultWrapper wrap = new ResultWrapper();
                    wrap.mainField = (String)s.get(inputWrapper.fieldApiName);
                    wrap.subField = (String)s.get(inputWrapper.otherFieldApiName);
                    wrap.id = (String)s.get('id');
                    returnWrapperList.add(wrap);
                }
                return returnWrapperList;
            }
            return null;
        } catch (Exception err) {
            throw new AuraHandledException(err.getMessage());
        }
    }

    public class ResultWrapper{
        @AuraEnabled public String mainField{get;set;}
        @AuraEnabled public String subField{get;set;}
        @AuraEnabled public String id{get;set;}
    }

    public class SearchWrapper {
        @AuraEnabled public String objectApiName{get;set;}
        @AuraEnabled public String fieldApiName{get;set;}
        @AuraEnabled public String otherFieldApiName{get;set;}
        @AuraEnabled public String searchString{get;set;}
       // @AuraEnabled public String selectedRecordId{get;set;}
       // @AuraEnabled public String parentRecordId{get;set;}
       // @AuraEnabled public String parentFieldApiName{get;set;}
    }
   
    @AuraEnabled
    public static String insertAccessory(String parentProductId,String childProductId){

        try{

            if(String.isNotBlank(parentProductId) && String.isNotBlank(childProductId)){
                	Product_List_Items__c pli=new 	Product_List_Items__c();
                    pli.Product_Name__c=parentProductId;
                    pli.Accessory__c=childProductId;

                    insert pli;
                    return pli.Id;

            }

        }catch (Exception err) {
            throw new AuraHandledException(err.getMessage());
           
        }
         return null;
    }


}