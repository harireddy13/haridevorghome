trigger ai on Account (after insert) {
    
    system.debug('I am in after insert');
    
    account taobj = new account(Id = trigger.new[0].id);
    
    if( trigger.new[0].billingcity == 'hyd')
        taobj.BillingCity = 'Hyderabad';
    
    update taobj;

}