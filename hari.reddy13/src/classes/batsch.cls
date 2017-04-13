global class batsch implements schedulable{
    
    global void execute (schedulablecontext cn){
    
    batprog an= new batprog();
        Database.executeBatch(an);
    }

}