Public class Territoryshare{

public list<Territory2> terList {Set;get;}
public list<Group> grpList{Set;get;}
public list<Account> accList{Set;get;}



Public Territoryshare(){
    
    terList = [Select id,name from Territory2 where name ='Bangalore'];
    grpList = [Select id, RelatedID from Group Where RelatedID = :terList.get(0).ID];
    accList = [Select id,name from Account where name = 'Accenture'];
    
    AccountShare accShare= new AccountShare();
    
    

}
}