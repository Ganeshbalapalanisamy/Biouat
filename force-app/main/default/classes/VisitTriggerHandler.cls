public class VisitTriggerHandler {
         
    public static void visitReport(List<Visit_Management__c> visitList){
        
     /* Map<Id,List<Boolean>> companyMap=new Map<Id,List<Boolean>>();
      List<Visit_Management__c> visitListValue=new  List<Visit_Management__c>();
        for(Visit_Management__c vm:[SELECT Id, Name, CreatedById, Checkbox__c, Company__c FROM Visit_Management__c where CreatedById=:UserInfo.getUserId() And CheckAppointmentDate__c = TODAY AND Checkbox__c=true])
        {
            if(companyMap.containsKey(vm.Company__c)){
                List<Boolean> checkbox=companyMap.get(vm.Company__c);
                checkbox.add(vm.Checkbox__c);
                companyMap.put(vm.Company__c,checkbox);
                visitListValue.add(vm);
            }else{
              companyMap.put(vm.Company__c,new List<Boolean>{vm.Checkbox__c});
              visitListValue.add(vm);
 
            }
           System.debug('value'+companyMap);
        }

         
        integer count=0;
for(Id i:companyMap.keySet()){
    List<Boolean> valueList=companyMap.get(i);
   if(valueList.contains(true)){
        count++;
    }
   
}*/
//System.debug('count'+count);
     List<Visit_Management__c>   vmList=new List<Visit_Management__c>();
    system.debug('visitList==>'+visitList);
        Visit_Management__c vm=visitList[0];
        Id companyId=vm.Company__c;
        Id vmId=vm.Id;
        vm.Visited_Companies__c=1;
        List<Visit_Management__c> v=[select Id, Name, CreatedById, Checkbox__c, Company__c,Visited_Companies__c FROM Visit_Management__c where Company__c=:companyId AND Id !=:vmId AND Appointment_Visit_Scheduled_on__c = TODAY AND Checkbox__c=true];
       
           
            if(v.size()>0){
                vm.Visited_Companies__c=0;
            }
                
        
    }
}