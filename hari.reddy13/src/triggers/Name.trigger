trigger Name on Account (before insert) {
    for(account acc : trigger.new){
        acc.name = 'Mr/Mrs. '+ acc.name;
    
    }
}