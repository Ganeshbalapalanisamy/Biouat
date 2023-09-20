/*
Trigger : NewOpportunityGenerated
Class : OppGenInVisits
Test Class : AmountInWordsTest
Last Modified : 04-07-2023
*/
public class OppGenInVisits {
    public static void newoppvisits(list<BiomatiQ_Lead__c>opplst){
        set<Id>visitIds=new set<Id>();
        list<Visit_Management__c>visitsupdate=new list<Visit_Management__c>();
        for(BiomatiQ_Lead__c opp:opplst)
        {
            if(opp.Source_Visit__c!=null)
            {
                visitIds.add(opp.Source_Visit__c);
            }
        }
        list<BiomatiQ_Lead__c> opplist=[select id,Name,Source_Visit__c from BiomatiQ_Lead__c where Source_Visit__c=:visitIds];
        list<Visit_Management__c> visits=[select id,New_Opportunity_Generated__c from Visit_Management__c where id=:visitIds];
        string newoppGen='';
         integer n=0;
                    for(BiomatiQ_Lead__c bl:opplist)
            {
                if(opplist.size()>1){
                    n=n+1;
                    if(opplist.size()==n){
                        newoppGen=newoppGen+bl.Name;
                    }
                    else{
                        newoppGen=newoppGen+bl.Name+',';
                    }
                }
                    else{
                        newoppGen=newoppGen+bl.Name;
                    }
            }
        for(Visit_Management__c vm:visits){
             vm.New_Opportunity_Generated__c=newoppGen;
                visitsupdate.add(vm);
            }
        update visitsupdate;
    }
}