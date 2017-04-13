public class apsosl{
    public list <account> arecs{get; set;}
    public list<lead> lrecs{get; set;}
    
    public apsosl(){
        list<list<sobject>> ls = [find '00000' in all fields returning account(id, name, phone, billingcity), 
                                  lead(id, name, phone) ];
         arecs = ls[0];
        lrecs = ls[1];
        apexpages.Message m1 = new apexpages.Message(apexpages.Severity.INFO,
                                                    arecs.size()+'Account Records Retrieved' +
                                                    lrecs.size()+'Lead Records Retrieved');
        apexpages.addmessage(m1);
        
            }

}