global class batprog implements database.Batchable<sobject>{
    global iterable<sobject> start(database.BatchableContext sc){
    
        return database.getQueryLocator([select name, id, phone, billingcity from account where billingcity = 'hyderabad']);
        
    }
    global void execute(database.BatchableContext sc, list<account> la){
    
        for(account a : la)
            a.name = 'harsh' +a.name;
        
            
    }
    
    global void finish(database.BatchableContext sc){
        system.debug('Program is Done');
    }
}