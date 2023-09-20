public class worktimetriggerhandler {
    
   
   //---------As per old requirement -------
   public static void Handlermethod(list<Visit_Management__c> VMlist)
    {
        list<Visit_Management__c> listvm =new list<Visit_Management__c>();
        Daily_Activity_Report__c workList =new Daily_Activity_Report__c();
        
        listvm=[SELECT Id, Name, CreatedDate, BiomatiQ_Lead__c,createdById, Check_In__c, Check_Out__c, Check_in_Location__Latitude__s,
                Check_in_Location__Longitude__s, Check_in_Location__c, Check_Out_Location__Latitude__s, 
                Check_Out_Location__Longitude__s, Check_Out_Location__c, Calculated_Distance__c,
                Total_Distance_Travelled__c, Checkbox__c, First_Check_in__c FROM Visit_Management__c
                WHERE Appointment_Visit_Scheduled_on__c= TODAY AND createdById=:userinfo.getUserId() ];
        
        		system.debug('listvm '+listvm);
        
        workList = [SELECT Id, Clock_in_Location__Latitude__s, Clock_in_Location__Longitude__s, Clock_in_Location__c, 
                    Clock_out_Location__Latitude__s, Clock_out_Location__Longitude__s, Clock_out_Location__c, CreatedById,
                    CreatedDate, Check_In_Time__c, CheckOut_Time__c FROM Daily_Activity_Report__c
                    WHERE createddate= TODAY AND createdById=:userinfo.getUserId()];
        		system.debug('workList '+workList);
        
        Double DistanceTravel=0;
        Double  ClockinDistance=0;
        Double  ClockOutDistance=0;
        Double  TClockinDistance=0;
        Double  TClockOutDistance=0;
        double s=0;
        
        For(Visit_Management__c c:listvm)
        {
            // system.debug('workList '+workList);
            
            if(c.First_Check_in__c==True  )
            {
                if(c.Check_in_Location__c != null && workList.Clock_in_Location__c != null )
                {
                    System.Location a=Location.newInstance(c.Check_in_Location__Latitude__s, c.Check_in_Location__Longitude__s);
                    System.Location b=Location.newInstance(workList.Clock_in_Location__Latitude__s, workList.Clock_in_Location__Longitude__s);
                    ClockinDistance=Location.getDistance(a,b ,'mi');
                    system.debug(a);
                    system.debug(b);
                    System.Location a3=(c.Check_in_Location__c);
                    System.Location b3=(workList.Clock_in_Location__c);
                    TClockinDistance=Location.getDistance(a3,b3 ,'mi');
                    system.debug(a3);
                    system.debug(b3);
                    s= c.Calculated_Distance__c;
                    system.debug('firsts :'+s);
                    DistanceTravel=s + DistanceTravel;
                }
            }
            
            /*else
if(c.Checkbox__c==True  ){
if(c.Check_Out_Location__c != null  ){
System.Location a1=Location.newInstance(c.Check_Out_Location__Latitude__s, c.Check_Out_Location__Longitude__s);
System.Location b1=Location.newInstance(workList.Clock_out_Location__Latitude__s, workList.Clock_out_Location__Longitude__s);
ClockOutDistance=Location.getDistance(a1,b1 ,'mi');

System.Location a2=(c.Check_Out_Location__c);
System.Location b2=(workList.Clock_out_Location__c);
TClockOutDistance=Location.getDistance(a2,b2 ,'mi');

}
}*/
            else
            {
                if(c.Check_Out_Location__c != null)
                {
                    system.debug('hint :'+c.Calculated_Distance__c);
                    s= c.Calculated_Distance__c;
                    system.debug('s :'+s);
                    DistanceTravel=s + DistanceTravel;
                    
                }
            }
        }  
        
        system.debug('ClockinDistance '+ ClockinDistance);
        system.debug('ClockOutDistance '+ ClockOutDistance); 
        
        system.debug('tClockinDistance '+ TClockinDistance);
        system.debug('tClockOutDistance '+ TClockOutDistance); 
        
        system.debug('DistanceTravel '+ DistanceTravel);
        double TotDistanceTravel=Double.valueOf(ClockinDistance+ClockOutDistance+DistanceTravel);
        system.debug('TotDistanceTravel '+ (ClockinDistance+ClockOutDistance+DistanceTravel));
        
        Daily_Activity_Report__c up =new Daily_Activity_Report__c();
        decimal q=Decimal.valueOf(TotDistanceTravel) ;
        decimal w=q.setScale(3);
        system.debug('listvm '+listvm);
        
        if(listvm!=null && workList!=null  )
        {
            up.id=workList.id;
            string e=String.valueOf(w) ;
            up.Total_Visit_Distance_Travelled__c=e ;
            update up;
        }
    } 
}

  /*public static void Handlermethod(list<Visit_Management__c> VMlist)
    {
        list<Visit_Management__c> listvm =new list<Visit_Management__c>();
        Daily_Activity_Report__c workList =new Daily_Activity_Report__c();
        
        listvm=[SELECT Id, Name, CreatedDate, BiomatiQ_Lead__c,createdById, Check_In__c, Check_Out__c, Check_in_Location__Latitude__s,
                Check_in_Location__Longitude__s, Check_in_Location__c, Check_Out_Location__Latitude__s, 
                Check_Out_Location__Longitude__s, Check_Out_Location__c, Calculated_Distance__c,
                Total_Distance_Travelled__c, Checkbox__c, First_Check_in__c,Work_Time__c FROM Visit_Management__c
                WHERE Appointment_Visit_Scheduled_on__c= TODAY AND createdById=:userinfo.getUserId() ];
        
        		system.debug('listvm '+listvm);
        
        workList = [SELECT Id, Clock_in_Location__Latitude__s, Clock_in_Location__Longitude__s, Clock_in_Location__c, 
                    Clock_out_Location__Latitude__s, Clock_out_Location__Longitude__s, Clock_out_Location__c, CreatedById,
                    CreatedDate, Check_In_Time__c, CheckOut_Time__c FROM Daily_Activity_Report__c
                    WHERE createddate= TODAY AND createdById=:userinfo.getUserId()];
        		system.debug('workList '+workList);
         for(Visit_Management__c c:listvm)
        {
                     
            if(c.Check_Out_Location__c!=null && workList!=null )
            {
               
                  c.Work_Time__c=workList.Id;
                }
        }
}
}*/