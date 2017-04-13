public class MultilevelDependentPicklist {

public string conti{get; set;}
public string contr{get; set;}
public string stat{get; set;}
public string regi{get; set;}
public string city{get; set;}

public MultilevelDependentPicklist(ApexPages.StandardController controller) {
 
}

public list<selectoption> getcontinentobj(){list<selectoption> 
options= new list<selectoption>();list<Continent__c> 
conti= [select name from Continent__c order by name];

options.add(new selectoption('—-Select Anyone—-', '—-Select Anyone—-'));

for(Continent__c c:conti){

options.add(new selectoption(c.name,c.name));

}

return options;

}

public list<selectoption> getcontryobj(){

list<selectoption> options= new list<selectoption>();

list<Country__c> contr= [select name  from Country__c where Continent__r.name=:conti];

options.add(new selectoption('—-Select Continent—-', '—-Select Continent—-'));

for( Country__c c:contr){

options.add(new selectoption(c.name,c.name));

}

return options;

}

public list<selectoption> getstateobj(){

list<selectoption> options= new list<selectoption>();

list<State_Provice__c> stat= [select name from State_Provice__c where Country__r.name=:contr];

options.add(new selectoption('—-Select Country—-', '—-Select Country—-'));

for(State_Provice__c s:stat){

options.add(new selectoption(s.name,s.name));

}

return options;

}

public list<selectoption> getregionobj(){

list<selectoption> options= new list<selectoption>();

list<County_Region__c> regi= [select name from County_Region__c  where State_Provice__r.name=:stat];

options.add(new selectoption('—-Select State—-', '—-Select State—-'));

for(County_Region__c r:regi){

options.add(new selectoption(r.name,r.name));

}

return options;

}

public list<selectoption> getcityobj(){

list<selectoption> options= new list<selectoption>();

list<City__c> city= [select name from City__c where County_Region__r.name=:regi];

options.add(new selectoption('—-Select Region—-', '—-Select Region—-'));

for(City__c c:city){

options.add(new selectoption(c.name,c.name));

}

return options;

}

}