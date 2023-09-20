trigger WorktimeDistanceCalcTrigger on Visit_Management__c (after insert ,after update) {
    
    string t;
    Datetime tt;
    Decimal checkoutlatt;
       Decimal checkoutlong;
    String recId;
    for(Visit_Management__c  s:Trigger.new)
    {
        t=string.valueOf(s.Appointment_Visit_Scheduled_on__c);
        recId=s.Id;
        tt= s.Appointment_Visit_Scheduled_on__c;
        checkoutlatt=s.Check_Out_Location__Latitude__s;
        checkoutlong=s.Check_Out_Location__Longitude__s;
    }
    system.debug('t '+t);
    /* if(checkoutlatt !=null && checkoutlong !=null){
           DistanceMatrixGoogle.getgeoLocation(recId);
                 }*/
    if((t!=null))
    {
        
        if((date.valueOf(t) == date.today()))
        {
            worktimetriggerhandler.Handlermethod(Trigger.new);
            
           
        }
    }
}