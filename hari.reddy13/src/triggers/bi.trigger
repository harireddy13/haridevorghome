trigger bi on Account (before insert) {
    system.debug('I am in before insert');
    trigger.new[0].name = 'sfdc' + trigger.new[0].name;

}