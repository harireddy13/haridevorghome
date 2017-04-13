public class apsoql{
    public string aname{get; set;}
    public string aphone{get; set;}
    public string acity{get; set;}
    
    
    public pagereference insertion(){
    account a= new account();
        a.Name= aname;
        a.Phone= aphone;
        a.BillingCity= acity;
        integer n = [select count() from account where name =: a.Name];
        if (n>0) {
            apexpages.addMessage(new apexpages.Message(apexpages.Severity.ERROR, aname + 'Record already exists'));
        }
        
        else {
        insert a;
        apexpages.Message m1 = new apexpages.Message(apexpages.Severity.INFO, aname + ' Record Inserted ');
            apexpages.addMessage(m1);       
        }
    
Return null;
    }
    public pagereference deletion(){
        
        list<account> d = [select id, name from account where name =: aname];
        if (d.size()>0){
        delete d;
            apexpages.addMessage(new apexpages.Message(apexpages.Severity.INFO, aname + 'Record deleted'));
        }
        else{
            apexpages.addMessage(new apexpages.Message(apexpages.Severity.ERROR, aname + 'Record does not exist'));
        }
        Return null;
    }
    
    public pagereference updation(){
    
        list<account> ud = [select id, name from account where name =: aname ];
            if (ud.size() > 0){
                update ud;
                apexpages.addMessage(new apexpages.Message(apexpages.Severity.INFO, aname +'updated succesfully'));
            }
        else{
            apexpages.addMessage(new apexpages.Message(apexpages.Severity.ERROR, aname +'Does not exist'));
        }
    Return null;
    }
    
    public pagereference upsertion(){
        list<account> us = [select name, id from account where name =: aname];
        if (us.size()>0){
        upsert us;
            apexpages.addMessage(new ApexPages.Message (apexpages.Severity.INFO, aname + 'Record updated succesfully'));
        }
    
        
    Return null;
    }
}