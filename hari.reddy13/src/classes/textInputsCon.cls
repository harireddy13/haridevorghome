public with sharing class textInputsCon {

    
public String operator {get; set;}

public String xx {set;get;}
public String yy { get; set; }
public String Quo {set;get;}
public List<quote__c> quoList {Set;get;}
public textInputsCon()
{
quo = 'SELECT Id,from1__c FROM quote__c ';
quoList = new List<quote__c>();
}

Public void showlist()
{
if(xx =='B'){
    quo+= 'WHERE from1__c = ' +  + ' : B';
}
if(xx=='A'){
    quo += ' WHERE from1__c' + operator + ' : A';
}
quoList = Database.query(quo);
System.debug('***************'+quoList);
}

}