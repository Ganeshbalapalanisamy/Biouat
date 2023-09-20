public class IncentiveManagement {

 /*   Public List<Biomatiq_Opportunity__c> acc {get;set;}
    Public Map<Id,Objective__c> map1  {get;set;}
        Public Map<Id,List<Objective__c>> map2  {get;set;}
     Public Map<Id,List<Biomatiq_Opportunity__c>> map3  {get;set;}
     Map<Id,Double> map4 {get;set;}*/
//Get the current screen record in which the button clicked
//IncentiveProgram currentRecord = All Fields from currentRecord;

@AuraEnabled
    public static List<Incentive__c> getObjectiveRecord(Id incentiveId){
        	List<Incentive__c> incentivelist                                         =new List<Incentive__c>();
        IncentiveProgram__c currentrecord=[Select Id,Name__c,StartDate__c,EndDate__c,Opportunity_PO__c from IncentiveProgram__c where Id=:incentiveId];
        List<Objective__c> objlist=[SELECT Id,IncentiveProgram__c,User__c,User__r.Business_Role__c,Amount_Target__c,Achievement_Percentile__c,
					Policy__c,Policy__r.Name,Policy__r.Sailor__c,Policy__r.Lead_Generator__c,Policy__r.Referral__c,Policy__r.Technical_Team__c,
					Benefit__c,Benefit__r.Name,Benefit__r.Type__c,Benefit__r.Value__c,Benefit__r.Code_Number__c,Benefit__r.Ticket_Number__c
					FROM Objective__c
					WHERE IncentiveProgram__c =: incentiveId ORDER BY Achievement_Percentile__c DESC];
         System.debug('Record '+objlist);
//Get all Targets by Assigned user
//Objective__c obj=new Objective__C();
Set<Id> set1 =new Set<Id>();
         Map<Id,Objective__c> map1= new Map<Id,Objective__c> ();
 Map<Id,List<Objective__c>> map2= new Map<Id,List<Objective__c>> ();
          Map<Id,List<Biomatiq_Opportunity__c>> map3= new Map<Id,List<Biomatiq_Opportunity__c>> ();
        Map<Id,Double> map4= new Map<Id,Double> ();
       // Map<Id,Biomatiq_Opportunity__c> map5= new Map<Id,Biomatiq_Opportunity__c> ();
       
        for(Objective__c obj:objlist) {
   
    
	set1.add(obj.User__c);
    
	map1.put(obj.User__c,obj);
           // map2.put(obj.User__c,objlist);
            System.debug('Map1 '+map1);

	if(map1.containsKey(obj.User__c)) {
		List<Objective__c> lObj=new List<Objective__c>();
        //lobj=map2.get(obj.User__c);
		lObj.add(obj);
		map2.put(obj.User__c,lObj);
         System.debug('Map2 '+map2);
	}
	else {
		map2.put(obj.User__c,new List<Objective__c>{obj});
	}
   }
       
  //Get all Orders by Owner
if(!set1.isEmpty()) {	//Each 
  List<Biomatiq_Opportunity__c>  bioOrderList=  [SELECT Id,Name,OwnerId,Amount__c,Person1__c,Person1__r.Business_Role__c,Person2__c,Person2__r.Business_Role__c,Person3__c,Person3__r.Business_Role__c,Person4__c,Person4__r.Business_Role__c
         		FROM Biomatiq_Opportunity__c
					WHERE 	//Close_Date__c <= incentiveId.EndDate__c && Close_Date__c >= incentiveId.StartDate__c) AND 
                                     Stage__c='Closed Won' AND OwnerId IN:set1];
        system.debug('Bioorder'+bioOrderList);
	for(Biomatiq_Opportunity__c ord:bioOrderList) {
		if(map2.containsKey(ord.OwnerId)) {
			List<Biomatiq_Opportunity__c> lOr =new List<Biomatiq_Opportunity__c>(); 
          // lor=map3.get(ord.OwnerId);
          // system.debug(ord.Person1__c+'Business Role '+ord.Person1__r.Business_Role__C);
			lOr.add(ord);
			map3.put(ord.OwnerId,lOr);
            //map5.put(ord.OwnerId,ord);
            //System.debug('map3 '+map3);
		}
		else {
			map3.put(ord.OwnerId,new List<Biomatiq_Opportunity__c>{ord});
		}
	}
}
        //Calculate the total Order amount by Owner
if(!map3.isEmpty()) {
	for(Id owId:map3.keySet()) {
		Double totalAmount = 0;
		System.debug('Map3 Amount '+owId+' '+totalAmount);
		for(Biomatiq_Opportunity__c ord:map3.get(owId)) {
			totalAmount = totalAmount+ord.Amount__c;
            System.debug('total Amount '+totalAmount);
		}
        
		map4.put(owId,totalAmount);
	}
}
        

        
        //Check the Achievement Percentile
if(!map4.isEmpty()) {
	for(Id owId:map4.keySet()) {
		for(Objective__c obj:map2.get(owId)) {
			Double AchievementAmount = map4.get(owId);
			Double AchievementPercent = (AchievementAmount / (obj.Amount_Target__c)) * 100;
			
			if(AchievementPercent >= obj.Achievement_Percentile__c) { 
				map1.put(owId,obj);
				break; //TargetPercentile in Descending Order
			}
			else {
				continue;
			}
		}
	}
}
  
        
             //Apply the Policy to each Orders
if(!map1.isEmpty()) {
    
	for(Id owId:map1.keySet()) {
		for(Biomatiq_Opportunity__c ord:map3.get(owId)) {
				Incentive__c inct = new Incentive__c();	
          //System.debug('ord'+ord.Amount__c);
            if(ord.Person1__r.Business_Role__c != null){
			if(ord.Person1__r.Business_Role__c.equalsIgnoreCase('Sailor') ) {
				inct.Sailor_Percent__c = map1.get(owId).Policy__r.Sailor__c;
				inct.Sailor_Amount__c = ord.Amount__c * inct.Sailor_Percent__c;
                
 
			}
            }
            if(ord.Person2__r.Business_Role__c != null){
			if(ord.Person2__r.Business_Role__c.equalsIgnoreCase('Generator')) {
				inct.Generator_Percent__c = map1.get(owId).Policy__r.Lead_Generator__c;
				inct.Generator_Amount__c = ord.Amount__c * inct.Generator_Percent__c;
                
          
			}
        }
            if(ord.Person3__r.Business_Role__c != null){
			if(ord.Person3__r.Business_Role__c.equalsIgnoreCase('Follower')) {
				inct.Follwer_Percent__c = map1.get(owId).Policy__r.Referral__c;
				inct.Follower_Amount__c = ord.Amount__c * inct.Follwer_Percent__c;
              
			}
            }
            if(ord.Person4__r.Business_Role__c != null){
			if(ord.Person4__r.Business_Role__c.equalsIgnoreCase('Technical')) {
				inct.Technical_Percent__c = map1.get(owId).Policy__r.Technical_Team__c;
				inct.Technical_Amount__c = ord.Amount__c * inct.Technical_Percent__c;
               
			}
            }
			inct.Sailor_Percent__c = map1.get(owId).Policy__r.Sailor__c;
            inct.Sailor_Amount__c = map4.get(owId) * (inct.Sailor_Percent__c/100);
            inct.Generator_Percent__c = map1.get(owId).Policy__r.Lead_Generator__c;
            inct.Generator_Amount__c = map4.get(owId) * (inct.Generator_Percent__c/100);
            inct.Follwer_Percent__c = map1.get(owId).Policy__r.Referral__c;
				inct.Follower_Amount__c = map4.get(owId) * (inct.Follwer_Percent__c/100);
            inct.Technical_Percent__c = map1.get(owId).Policy__r.Technical_Team__c;
				inct.Technical_Amount__c = map4.get(owId) * (inct.Technical_Percent__c/100);
            inct.Objective__c=map1.get(owId).Id;
            inct.Total_Amount_Achieved__c=map4.get(owId);
			inct.Program__c = map1.get(owId).IncentiveProgram__c;
			inct.Policy__c = map1.get(owId).Policy__c;
			inct.Benefit__c = map1.get(owId).Benefit__c;
			inct.Order__c = ord.Id;
			incentivelist.add(inct);
		}
	}	
}

//Create Incentive record
if(!incentivelist.isEmpty()) {
	insert incentivelist;
    System.debug('Record Inserted'+incentivelist);
}

        
       return  incentivelist;
        
   
        
	}
}