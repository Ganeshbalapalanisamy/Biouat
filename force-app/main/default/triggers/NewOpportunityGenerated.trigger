/*
Trigger : NewOpportunityGenerated
Class : OppGenInVisits
Test Class : AmountInWordsTest
Last Modified : 04-07-2023
*/
trigger NewOpportunityGenerated on BiomatiQ_Lead__c (after insert) {
   OppGenInVisits.newoppvisits(trigger.new);
}