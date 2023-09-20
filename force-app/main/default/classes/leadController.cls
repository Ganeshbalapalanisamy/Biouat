public with sharing class leadController {
    
    @AuraEnabled
    public static Lead createLead(Lead Lead){
        upsert Lead;
        return Lead;
    }
}