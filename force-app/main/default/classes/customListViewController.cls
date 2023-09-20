public class customListViewController {
    public List<BiomatiQ_Lead__c> bioDomain {get;set;}
public customListViewController(ApexPages.StandardSetController controller) {
        controller.setPageSize(10);
    }
    //bioDomain=[SELECT Name,Lead_Status__c,Opportunity_Closing__c FROM BiomatiQ_Lead__c where ListView ='BiomatiQ'];
}