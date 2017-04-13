Public class Territoryshare1{

public list<Territory2> terList {Set;get;}
public list<Group> grpList{Set;get;}
public list<Account> accList{Set;get;}

Public Territoryshare1(){

}
 Public void terr()   {
    terList = [Select id,name from Territory2 where name ='Assam'];
    grpList = [Select id, RelatedID from Group Where RelatedID = :terList.get(0).ID];
    accList = [Select id,name from Account where name = 'Mr/Mrs. DLF Infra'];
    
List<AccountShare> shares = new List<AccountShare>();  
for (Account a : accList) 
{
AccountShare aShare           = new AccountShare();
          aShare.AccountId              = a.Id;
          aShare.UserOrGroupId          = grpList.get(0).id;
          aShare.AccountAccessLevel     = 'Edit';
          aShare.OpportunityAccessLevel = 'Edit';          
          shares.add(aShare);        
          }
      
    
  
  insert shares;

}
}