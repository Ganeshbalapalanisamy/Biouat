trigger visitmanagementTrigger on Visit_Management__c (after insert,after update,before insert,before update) {
 
      if(trigger.isUpdate && trigger.isBefore){
          
          for(Visit_Management__c  v:Trigger.new){
               System.debug('user+'+UserInfo.getUserId());
              System.debug('cec'+v.Checkbox__c+'>>date'+v.Appointment_Visit_Scheduled_on__c+'>>userid'+v.CreatedById);
              
              if(v.Checkbox__c == true && Date.valueOf(v.Appointment_Visit_Scheduled_on__c)==Date.today() && v.CreatedById==UserInfo.getUserId()){
                  VisitTriggerHandler.visitReport(Trigger.new);
              }
              
          }
          
   
        }
    
    
    if((Trigger.isInsert || Trigger.isUpdate) && Trigger.isAfter)
    {
      
        String oppId;
        for(Visit_Management__c vm:Trigger.new){
            oppId=vm.BiomatiQ_Lead__c;
                  }
        if(oppId!=null){
         List<Visit_Management__c> vmList=[Select id,Name,BiomatiQ_Lead__c from Visit_Management__c where BiomatiQ_Lead__c=:oppId];
            if(vmList!=null){
        BiomatiQ_Lead__c opp=new BiomatiQ_Lead__c();
        opp.Id=oppId; 
        opp.Total_Visits__c=vmList.size();
        Update opp;
            }
        }
       /* if(Trigger.Old !=null){
            System.debug('triggerafter');
      worktimesvisitcalculatetriggerhandler.visitsmethod(Trigger.old); 
             }
        
   string t;
    Datetime tt;
        boolean visitcompleted;
    decimal checkoutloclat;
        decimal checkoutloclong;
    String recId;
       for(Visit_Management__c  s:Trigger.new)
    {
       DateTime dT = s.Appointment_Visit_Scheduled_on__c;
        Date d = dT.date();
        system.debug('d'+d);
        DateTime dT1 = System.now();
        Date d1= Date.newInstance(dT1.year(), dT1.month(), dT1.day());
         system.debug('d1'+d1);
       /* t=string.valueOf(s.Appointment_Visit_Scheduled_on__c);
        recId=s.Id;
        tt= s.Appointment_Visit_Scheduled_on__c;
        checkoutloclat=s.Check_Out_Location__Latitude__s;
        checkoutloclong=s.Check_Out_Location__Longitude__s;
        visitcompleted=s.Checkbox__c;
     
     if(d==d1 && S.Check_in_Location__Latitude__s !=null && s.Check_in_Location__Longitude__s!=null && s.Check_Out_Location__Latitude__s!=null && s.Check_Out_Location__Longitude__s!=null)
     {
        DistanceMatrixGoogle.getgeoLocation(s.Id);  
     }
         
    }
      if(visitcompleted){
            System.debug('checkoutloc'+checkoutloclat+''+checkoutloclong);
            DistanceMatrixGoogle.getgeoLocation(recId);
        }*/
    }
  
    
}