public class MakegetCallout {
    
public static string getcontent()
{
    Http h=new Http();
    HttpRequest req=new HttpRequest();
    req.setEndpoint('https://dummy.restapiexample.com/api/v1/employees');
    req.setMethod('GET');
    
    HttpResponse res=h.send(req);
    System.debug('res======'+res.getBody());
    return res.getBody();
}
}