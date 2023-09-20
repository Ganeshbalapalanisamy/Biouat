public without sharing class Lookup {
 @AuraEnabled(cacheable=true)
    public static List<sObject> search(String searchTerm, string myObject, String filter,string companyId) {
        String myQuery = null;
        if(filter != null && filter != ''){
            myQuery = 'Select Id, Name from '+myObject+' Where Account_Name__r.Id= \'' + companyId+ '\'' ;
            //myQuery = 'Select Id, Name from '+myObject+' Where AccountId= \'' + companyId+ '\'' ;
            System.debug(myQuery);
        }
        else {
            if(searchTerm == null || searchTerm == ''){
                myQuery = 'Select Id, Name from '+myObject+' Where Account_Name__r.Id= \'' + companyId+ '\'';
            }
            else {
                myQuery = 'Select Id, Name from '+myObject+' Where Account_Name__r.Id= \'' + companyId+ '\'';
            }
        }
        List<sObject> lookUpList = database.query(myQuery);
        System.debug('order'+lookUpList);
        return lookUpList;
    }
    
    
    
     @AuraEnabled(cacheable=true)
    public static List<sObject> searchOpport(String searchTerm, string myObject, String filter,string companyId) {
        String myQuery = null;
        if(filter != null && filter != ''){
            myQuery = 'Select Id, Name from BiomatiQ_Lead__c Where Company_Name__c= \'' + companyId+ '\'' ;
            //myQuery = 'Select Id, Name from '+myObject+' Where AccountId= \'' + companyId+ '\'' ;
            System.debug(myQuery);
        }
        else {
            if(searchTerm == null || searchTerm == ''){
                myQuery = 'Select Id, Name from BiomatiQ_Lead__c Where Company_Name__c= \'' + companyId+ '\'';
            }
            
        }
        List<sObject> lookUpList = database.query(myQuery);
        System.debug('opport--'+lookUpList);
        return lookUpList;
    }
}