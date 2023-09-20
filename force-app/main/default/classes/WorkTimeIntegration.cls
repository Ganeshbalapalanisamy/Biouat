@RestResource(urlMapping='/TravelUpdate/*')
global class WorkTimeIntegration {
    @HTTPPost
    global static Daily_Activity_Report__c createTravelRec(String Name,double Clock_in_LocationLatitude,double Clock_in_LocationLongitude){
       
        Daily_Activity_Report__c wt=new Daily_Activity_Report__c();
         
        wt.Name=Name;
        wt.Clock_in_Location__Latitude__s=Clock_in_LocationLatitude;
        wt.Clock_in_Location__Longitude__s=Clock_in_LocationLongitude;
        wt.Check_In_Time__c=System.now();
        
        insert wt;
        return wt;
       
    }
    
    @HTTPPatch
    global static Daily_Activity_Report__c updateTravelRec(Id recId,double Clock_out_LocationLatitude,double Clock_out_LocationLongitude,String travelKm){
        
        Daily_Activity_Report__c wt=new Daily_Activity_Report__c();
        
        if(recId !=null){
            wt.Id=recId;
            wt.Clock_out_Location__Latitude__s=Clock_out_LocationLatitude;
            wt.Clock_out_Location__Longitude__s=Clock_out_LocationLongitude;
            wt.CheckOut_Time__c=System.now();
            wt.Total_Visit_Distance_Travelled__c=travelKm;
            
            update wt;
            return wt;
            
            
        }
        
        return null;
        
    }

}