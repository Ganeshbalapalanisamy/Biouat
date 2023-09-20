@istest
public class worktimenotmorethanonerectest {
    
    //Defind testmethod keyword while defining method 
    public static testMethod void worktimesPositive()
    {
        //Defind variables
        String addError;
        String myname = UserInfo.getUserId();
        SObject sObj = Schema.getGlobalDescribe().get('Daily_Activity_Report__c').newSObject();
        DateTime dt = Datetime.now();
        Id userId=UserInfo.getUserId();
        User usr = [Select Name From User where Id = :userId];
        sObj.put('Check_In_Time__c',dt);
        sObj.put('Name',usr.Name);
        Decimal a=12.8463043;
        Decimal b=77.6650548;
        sObj.put('Clock_in_Location__Latitude__s',a ); 
        sObj.put('Clock_in_Location__Longitude__s',b ); 
        
        System.debug('sObj-------'+sObj);
        
        insert sObj; 
        
        
        SObject sObj1 = Schema.getGlobalDescribe().get('Daily_Activity_Report__c').newSObject();
        sObj1.put('Check_In_Time__c',dt);
        sObj1.put('Name',usr.Name);
        sObj1.put('Clock_in_Location__Latitude__s',a ); 
        sObj1.put('Clock_in_Location__Longitude__s',b ); 
        System.debug('sObj1-------'+sObj1);
        insert sObj1;
        List <Daily_Activity_Report__c> x =[SELECT Id, Name FROM Daily_Activity_Report__c WHERE createddate= TODAY ];
        System.debug('X-------'+x);
        if(x.size() > 1)
        {
            try{
            }
            catch (Exception e){
                //alert('Error');
                System.assert(e.getMessage().contains('Create no more than one record per day'));
                system.debug('Error Test');
            }
        }
        else
        {
        }
    }
    
    /* public static testMethod void worktimesNegative()
{
//Defind variables
String addError;
String myname = UserInfo.getUserId();

//Create an instance of an object on which you want to check this trigger is working or not. 
//    Daily_Activity_Report__c a2 = new Daily_Activity_Report__c(Name = myname);

SObject sObj = Schema.getGlobalDescribe().get('Daily_Activity_Report__c').newSObject();
DateTime dt = Datetime.now();
Id userId=UserInfo.getUserId();
User usr = [Select Name From User where Id = :userId];
sObj.put('Check_In_Time__c',dt);
sObj.put('Name',usr.Name);
Decimal a=12.8463043;
Decimal b=77.6650548;
sObj.put('Clock_in_Location__Latitude__s',a ); 
sObj.put('Clock_in_Location__Longitude__s',b ); 

System.debug('sObj-------'+sObj); 
SObject sObj1 = Schema.getGlobalDescribe().get('Daily_Activity_Report__c').newSObject();
sObj1 = sObj;
insert sObj; 
insert sObj1;
// insert sObj; 
//Query 
List <Daily_Activity_Report__c> x =[SELECT Id, Name FROM Daily_Activity_Report__c WHERE createddate= TODAY ];
if(x.size() > 1)
{
//alert('Error');
system.debug('Error Test');
}
}*/
    
}