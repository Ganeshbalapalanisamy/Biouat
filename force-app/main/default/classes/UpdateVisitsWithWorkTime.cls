/*Apex Controller:UpdateVisitsWithWorkTime
 * Trigger:AttendanceOutBoundRestTrigger
 * TestClass:EmployeeCheckinTestClass
*/

public class UpdateVisitsWithWorkTime {
  
    public static void updateVisits(Map<Id,Daily_Activity_Report__c> wtMap){
        List<Visit_Management__c> vmlist=[Select Id,Name,Work_Time__c,Appointment_Visit_Scheduled_on__c from Visit_Management__c where Appointment_Visit_Scheduled_on__c = Today AND createdById=:userinfo.getUserId()];
        String wtId;
        
        for(Daily_Activity_Report__c wt:wtMap.Values()){
            wtId=wt.Id;
        }
        if(vmlist!=null){
        for(Visit_Management__c vm:vmlist){
            vm.Work_Time__c=wtId;
        }
        update vmlist;
        }
    }
}