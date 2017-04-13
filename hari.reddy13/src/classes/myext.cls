public class myext {
public List<Opportunity> Addrs {Set;get;}

    public myext(ApexPages.StandardController controller) {
             Addrs = [select Id,name from Opportunity limit 10];
             
    }

public myext()
{
   Addrs = [select Id,name from Opportunity limit 10];
}
}