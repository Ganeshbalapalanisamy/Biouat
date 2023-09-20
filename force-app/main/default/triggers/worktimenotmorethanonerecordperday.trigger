trigger worktimenotmorethanonerecordperday on Daily_Activity_Report__c (before insert) {
      
      worktimetriggercontroller.setuserinfo(Trigger.new);

}