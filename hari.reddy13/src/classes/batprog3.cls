global class batprog3 implements Database.Batchable<sobject>{
    
    global iterable<sobject> start(database.BatchableContext cn) {
    
    return Database.getQueryLocator([select name, id, phone, billingcity from account where billingcity = 'hyd']);
    
    }
    
    global void execute(database.BatchableContext cn, list<account> la){
    
    for (account a : la) {
    
    a.name = 'Mr/Mrs' + a.name;
    
        update a;
    }
    
    }
    global void finish (database.BatchableContext cn){
    
        system.debug('Job done');
    }
}