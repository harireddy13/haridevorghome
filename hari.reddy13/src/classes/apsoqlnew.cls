public class apsoqlnew {

    public PageReference m4() {
    list<account> la = [select name, id from account where name =: an];
    if(la.size()>0){
    delete la;
    apexpages.addMessage(new apexpages.Message(apexpages.Severity.INFO, an + 'Record Deleted Succesfully'));
    }
    else{
    apexpages.addMessage(new apexpages.Message(apexpages.Severity.ERROR, an + 'Record does not exist'));
    }
    
        return null;
    }


    public PageReference m3() {
    list<account> lups = [select name, id from account where name =: an];
            if(lups.size()>0){
            upsert lups;
            apexpages.addmessage(new apexpages.Message(apexpages.Severity.INFO, an + 'Record Updated Successfully'));
            }
        return null;
    }


    public PageReference m2() {
    list<Account> aupd = [select id, name from account where name =: an];
    if(aupd.size()>0) {
    update aupd;
   apexpages.addMessage(new apexpages.Message(apexpages.Severity.INFO, an +'updated succesfully'));
    }
    else{
    apexpages.addMessage(new apexpages.Message(apexpages.Severity.Error, an + 'Record doesnot exist'));
    }
        return null;
    }


    public PageReference m1() {
    account a = new account();
    a.name = an;
    a.phone = ap;
    a.billingcity = abc;
    
    integer n= [select count() from account where name =: a.name];
    if (n>0){
    apexpages.addMessage(new apexpages.Message(apexpages.Severity.ERROR, an + 'Record already exists'));
    }
    else{
    insert a;
    apexpages.addMessage(new apexpages.Message(apexpages.Severity.INFO, an + ' Inserted Successfully'));
    }
        return null;
    }


    public String abc { get; set; }

    public String ap { get; set; }

    public String an { get; set; }
}