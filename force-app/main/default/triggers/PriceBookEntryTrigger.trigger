/* Trigger:PriceBookEntryTrigger
Class:PriceBookEntryTriggerHandler
TestClass:PriceBookEntryTriggerHandlerTest
Developer:Gowtham.K
Created Date : 26/06/2023*/



trigger PriceBookEntryTrigger on BiomatiQ_Book_Entry__c (before insert) {
    switch on Trigger.Operationtype{
        when BEFORE_INSERT{
PriceBookEntryTriggerHandler.beforeInsert(Trigger.New);
        }
        //when AFTER_INSERT{}
    }
}