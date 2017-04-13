trigger Duplicate on Lead (before insert) {
    for(lead ls : trigger.new){
        if(ls.Firstname!= null && ls.Lastname != null){
        list<lead> ld = [select id, name from lead where Firstname =: ls.FirstName
                        AND Lastname =: ls.LastName
                        AND Id !=: ls.Id];
            if(ld.size()>0){
            ls.Potential_Lead_Dupe__c = ld[0].Id;
            }else{
            ls.Potential_Lead_Dupe__c = null;
            }
            list<contact> lc = [select id from contact where Firstname =: ls.FirstName 
                               and Lastname =: ls.LastName];
            if (lc.size()>0){
            ls.Potential_Contact_Dupe__c = lc[0].Id;
            }else{
            ls.Potential_Contact_Dupe__c = null;
            }
        }
    }
}