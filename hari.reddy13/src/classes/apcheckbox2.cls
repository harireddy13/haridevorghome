public class apcheckbox2{
    
    public class lwrap{
        public boolean selected{get; set;}
        public lead ld {get; set;}
        
        public lwrap (lead l){
            ld = l;
            selected = false;
        }
    }
    
    
    public list<lwrap> llist = new list<lwrap>();
    public list<lwrap> getlrecs(){
    for (lead l : [select id, name, phone from lead limit 10])
        llist.add(new lwrap(l));
        Return llist;
    }
    
    public list<lead> selectedleads = new list<lead>();
    
    public pagereference getselected(){
    
        selectedleads.clear();
        for (lwrap lobj : llist ){
        if(lobj.selected == true)
            selectedleads.add(lobj.ld);
        }
        Return null;
        
    }
    public list<lead> getselectedleads(){
        
        if(selectedleads.size()>0)
            Return selectedleads;
        else
            Return null;
    }

}