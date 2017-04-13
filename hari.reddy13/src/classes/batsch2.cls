global class batsch2 implements schedulable{
    
    global void execute (schedulablecontext cn){
        
        batprog3 an= new batprog3();
        database.executeBatch(an);
    
    
    }
}