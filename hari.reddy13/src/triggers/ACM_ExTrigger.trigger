/**
* @author Steve Cox
* @description exception trigger
*/
trigger ACM_ExTrigger on Contact(before update) {

//ACM_TriggerFactory.createHandler(Contact.sObjectType);

//Contact excold = Trigger.oldMap.get(old.Id);
//Contact excnew = Trigger.newMap.get(new.Id);


if(Trigger.isUpdate && Trigger.isBefore) { 
for (Contact excpnew : Trigger.new) {

Contact excold = Trigger.oldMap.get(excpnew.Id); 

if(excold.Title == excold.Department )
{

}
else
{
excpnew.Department = excold.Title;
//excold1. = sev;
}
//update excpnew; 
}
}

}