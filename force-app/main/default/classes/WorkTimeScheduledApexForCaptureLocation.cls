//still it doesn't used anywhere
global class WorkTimeScheduledApexForCaptureLocation Implements Schedulable {

        global void execute(SchedulableContext sc)
        {
            setToMiko();
        }

        public void setToMiko()
        {
            Daily_Activity_Report__c listWorkTimes = new Daily_Activity_Report__c();
            listWorkTimes = [SELECT ID,CheckOut_Time__c,Remarks__c,Check_In_Time__c FROM Daily_Activity_Report__c WHERE CheckOut_Time__c = null];

           
            
                listWorkTimes.Remarks__c = 'Miko';
            
           /* navigator.geolocation.getCurrentPosition(GetLocation);
function GetLocation(location) {
    console.log(location);
}*/
            
            

            update listWorkTimes;
        }
    }