@RestResource(urlMapping='/getContactInfo/*')
global class webservicescontact {
    @HttpGet
    global static void getcontact()
    {
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        String urlId=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<Contact> ld=[select Id,Name from Contact LIMIT 10];
        List<Map<String,String>> maplist=new List<Map<String,String>>();
        for(Contact lfor:ld)
        {
            Map<String,String> mp = new Map<String,String>{
                'Name'=>lfor.Name,
                    'Id'=>lfor.Id
            };
           
             maplist.add(mp);   
            
        }
        
        Map<String,List<Map<String,String>>> restMap=new  Map<String,List<Map<String,String>>>{
            'Leads'=> maplist
        };
        
        RestContext.response.responsebody=Blob.valueOf(json.serialize(ld));
        }
}