public class idpass{
    
    public string id {get; set;}
    public string pd {get; set;}
    public string stat {get; set;}
    public list <IDS__c> luser;
    public list <IDS__c> getluser(){
    return luser;
    }
    public pagereference m1(){
        luser = [select name from IDS__c where name =: id];
        if (luser.size()>0){
        stat = 'login success';
        apexpages.addMessage(new ApexPages.Message(apexpages.severity.CONFIRM, id + 'Login success'));
        }
        else{ 
            stat = 'Login failed';
            apexpages.addMessage(new ApexPages.Message (apexpages.Severity.ERROR, id + 'Login failed'));
            }
        return null;
    }
}