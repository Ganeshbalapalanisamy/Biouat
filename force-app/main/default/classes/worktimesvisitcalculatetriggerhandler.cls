public class worktimesvisitcalculatetriggerhandler {
                public static void visitsmethod(list<Visit_Management__c> visitlist)
                {
                    Map<Id,Integer> setcountmap=new Map<Id,Integer>(); 
                    for(Visit_Management__c dc:visitlist)
                    {
                      setcountmap.put(dc.createdById,null); 
                        
                    }
                    system.debug('setcountmap'+setcountmap);
                    
                     List<Visit_Management__c> dlist=[SELECT Appointment_Visit_Scheduled_on__c,createdById,Check_In__c,Check_Out__c,Name FROM Visit_Management__c
                                                     WHERE Appointment_Visit_Scheduled_on__c=TODAY AND createdById IN:setcountmap.keySet()];
                    for(Visit_Management__c vlist:dlist)
                    {
                        Integer visitscount=0;
                      if(setcountmap.get(vlist.CreatedById)!=null)  
                      {
                          visitscount=setcountmap.get(vlist.CreatedById);
                      }
                        visitscount++;
                       setcountmap.put(vlist.CreatedById,visitscount);
                    }
                    
                    List<Daily_Activity_Report__c>  dalist=new  List<Daily_Activity_Report__c>();
                   
                    for(Daily_Activity_Report__c dclistmine:[SELECT Id,Name,createdById,Total_Number_Of_Visits_Completed__c FROM Daily_Activity_Report__c
                                                     WHERE createddate=TODAY AND createdById IN:setcountmap.keySet()])
                    { 
                        if(setcountmap.get(dclistmine.CreatedById)!=null)
                        {
                            dclistmine.Total_Number_Of_Visits_Completed__c=setcountmap.get(dclistmine.CreatedById);
                           dalist.add(dclistmine); 
                        }
                     
                    }
                    update dalist;
                   
                }
}