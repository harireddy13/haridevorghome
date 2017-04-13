public class apcheckbox{
    public class awrap{
        public boolean selected {get;set;}
        public account an {get;set;}
        public awrap (account a){
         	an = a;
            selected = false;
               }
        }
    public list<awrap> alist = new list<awrap>();
    
    public list<awrap> getArecs (){
    for (account a : [select id, name, phone, billingcity from account where billingcity != null limit 5])
            alist.add(new awrap(a));
            return alist;
        } 
    public list<account> selectedaccounts = new list<account>();
    public pagereference getselected(){
        
        selectedaccounts.clear();
    
    for (awrap awobj : alist){
    if (awobj.selected == true)
        selectedaccounts.add(awobj.an);
    }
        Return null;
    }
    public list <account> getselectedaccounts(){
    
        if(selectedaccounts.size()>0)
            return selectedaccounts;
        else
            Return null;
    
    }
    
}