public class pdf1 {
    
    list<account>acts = [select name,billingcity,phone from account limit 10];    
    public list<account> getaccounts(){
        return acts;
    }
    
    /*public pagereference normal(){
        return page.pdf2;
    }*/
    public pagereference pdf(){        
        return page.pdf3;        
}
}