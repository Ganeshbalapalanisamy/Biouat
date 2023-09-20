/*Apex Controller:AttendanceOutBoundRest
 * Trigger:AttendanceOutBoundRestTrigger
 * TestClass:EmployeeCheckinTestClass
*/

trigger AttendanceOutBoundRestTrigger on Daily_Activity_Report__c (after insert,after update) {
  String employee_id;
    Datetime dateTimeval;
    Decimal lattitude;Decimal longitude;String comments='salesforce';String recId;
    if(trigger.isInsert){
        for(Daily_Activity_Report__c da:trigger.new){
            recId=da.Id;
            employee_id=da.OwnerId;
            dateTimeval=da.Check_In_Time__c;
            lattitude=da.Clock_in_Location__Longitude__s;
            longitude=da.Clock_in_Location__Latitude__s;
             
        }
        AttendanceOutBoundRest.postPuchDetails(employee_id,dateTimeval,lattitude,longitude,comments,recId);
        UpdateVisitsWithWorkTime.updateVisits(trigger.NewMap);
    }
     else if(trigger.isUpdate){
         for(Daily_Activity_Report__c daOld:trigger.old){
             
        for(Daily_Activity_Report__c da:trigger.new){
            if(daOld.CheckOut_Time__c==Null && da.CheckOut_Time__c!=Null && da.Is_ClockOut__c==false){
                recId=da.Id;
            employee_id=da.OwnerId;
            dateTimeval=da.CheckOut_Time__c;
            lattitude=da.Clock_out_Location__Latitude__s;
            longitude=da.Clock_out_Location__Longitude__s;
           // DistanceMatrixGoogle.getgeoLocation(recId);
          AttendanceOutBoundRest.postPuchDetails(employee_id,dateTimeval,lattitude,longitude,comments,recId);
        }
         }
             }
         }
}