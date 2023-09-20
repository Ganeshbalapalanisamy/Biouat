public class ReportGeneration {
    public static void calculatevalues(String workTime){
        List<User> usr=New List<User>();
        Set<id> wtidset=new Set<id>();
        List<Daily_Activity_Report__c> wt=[Select Id, Name from Daily_Activity_Report__c where Id=:workTime];
        if(wt.size()>0){
        for(Daily_Activity_Report__c da:wt){
            wtidset.add(da.Id);
        }
            Set<Id> visitedCompanies=New Set<Id>();
        Integer completedVisits=0;
        Integer appiontments=0;
        List<Visit_Management__c> vm=[Select Id,Name,Appointment_Visit_Scheduled_on__c,Checkbox__c,Work_Time__c,Visited_Companies__c,Company__c from Visit_Management__c where Work_Time__c IN:wtidset ];
        for(Visit_Management__c vmg:vm){
            if(vmg.Checkbox__c == true){
                completedVisits++;
                visitedCompanies.add(vmg.Company__c);
            }
           
                appiontments++;
            
        }
        Double per ;
            String cmt;
         System.debug(completedVisits+'app'+appiontments);
       
       for(Visit_Management__c vmg:vm){
            vmg.Visited_Companies__c=visitedCompanies.size();
        }
        
        update  vm;
        }
    }
}