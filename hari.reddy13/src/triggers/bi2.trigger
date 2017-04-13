trigger bi2 on Account (before insert) {
    
    list<account> la = trigger.new;
    
    for (account a : la) {
    
    a.name = 'Mr/Mrs. ' +a.Name;
        a.Phone = '+91 ' +a.Phone;
    
    }

}