public class worktimetriggercontroller {
   public static void setuserinfo(List<Daily_Activity_Report__c> daList)
   {
    List <Daily_Activity_Report__c> workList = [SELECT Id,Name FROM Daily_Activity_Report__c WHERE createddate= TODAY AND createdById=:userinfo.getUserId()];
        if(workList.size() > 0) 
          {
              for(Daily_Activity_Report__c dc:daList)
              {
                dc.addError('Create no more than one record per day');  
              }
          }   
  }
   }