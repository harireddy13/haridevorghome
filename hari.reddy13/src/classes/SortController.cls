public class SortController
{
public boolean Column1Sort{get;set;}
public boolean Column2Sort{get;set;}
public boolean SortAscending{get;set;}
public boolean SortDescending{get;set;}
public string orderBy{get;set;}
public String orderByAscDesc {Set;get;}
 public List<Account> objectList {Set;get;}
 
public void doQuery()
{

}

private pageReference sortByValue(string value){
    SortAscending = false;
    SortDescending = false;
    if(orderBy == value){
        if(orderByAscDesc == 'Asc'){
            orderByAscDesc = 'Desc';
            SortDescending = true;
        }else{
            orderByAscDesc = 'Asc';
            SortAscending = true;
        }
    }else{
        orderByAscDesc = 'Asc';
        SortAscending = true;
    }
    orderBy = value;
    doQuery();  //Routine that does your query that loads your table.  It should use the orderBy string for the 'order by' clause
    return null;
}
 
public pageReference sortByColumn1(){  
    Column1Sort = true;
    Column2Sort = false;
    return sortByValue('Column1');
}
 
public pageReference sortByColumn2(){  
    Column1Sort = false;
    Column2Sort = true;
    return sortByValue('Column2');
}
}