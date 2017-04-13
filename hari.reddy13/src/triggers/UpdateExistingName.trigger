trigger UpdateExistingName on Account (before insert) {
    
    list<Account> lnew = trigger.new;
    list<Account> lold = [select id, name from account];
    
    for (account ln : lnew){
    
    for (Account lo:lold){
    
    if ('Mr/Mrs. '+ln.name == lo.name)
    
    ln.addError(ln.name + 'Record already exists');
    }
    }
}