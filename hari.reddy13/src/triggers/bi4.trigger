trigger bi4 on Account (before insert) {
   
    list<account> ln = trigger.new;
    list<account> lo = [select id,name from account];
    list<account> lup = new list<account>();
    list<account> lu = new list<account>();
    
        
    for(account o : lo){
        
        for( account n : ln){
                if( n.name == o.Name)
                        //n.addError( n.name + ' Record already Exist ');
                        lu.add(n);
                            
        }
    }
    
    integer i=1;
    for(account u : lu){
            u.name = u.name + i--;
            lup.add(u);
    }
    update lup;       
 

}