/*
 * Class Name : QuoteTriggerHandler
 * Test Class : QuoteTriggerHandlerTestClass
 * Trigger    : QuoteTrigger
 * Created Date : 13/4/2023
*/

trigger QuoteTrigger on Quotes__c (before insert,before Update,after Insert,after Update) {
    switch on Trigger.OperationType{
        when BEFORE_INSERT{
            QuoteTriggerHandler.checkProductList(Trigger.new);
        }
       
        When AFTER_INSERT{
            QuoteTriggerHandler.createQuoteLineItem(Trigger.new);
            
        }
        /* When AFTER_UNDELETE{}
        When AFTER_DELETE{}
        When AFTER_UPDATE{}
        When BEFORE_DELETE{}
        When BEFORE_UPDATE{}*/
    }

}