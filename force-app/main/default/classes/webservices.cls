@RestResource(urlMapping='/getLeadInfo/*')
global class webservices {
    @HttpGet
    global static void getlead()
    {
        RestRequest req=RestContext.request;
        RestResponse res=RestContext.response;
        String urlId=req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
        List<Lead> ld=[select Id,Name from Lead LIMIT 10];
        List<Map<String,String>> maplist=new List<Map<String,String>>();
        for(Lead lfor:ld)
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