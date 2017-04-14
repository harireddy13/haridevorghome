public class accountPagination_ctrl{

public List<Account> accLst {get; set;}
public List<Account> accLst_size {get; set;}
public integer counter = 0;
public integer recNum = 0;
public integer limits = 5;
public set<id> AccountID {get; set;}

// Create Pull request for feature
// Test Changes in First Child
// Test Changes in Second Child
// Test Changes in Second Child
//Second change
//third change
//Nochange
//This is the change
//there is change

public accountPagination_ctrl(){
    accLst = new List<Account> ();
    accLst_size = new List<Account> ();
    AccountID = new set<id>();
    Result();
}

public void Result(){
    accLst_size = [SELECT Name, Id FROM Account WHERE name != null];
    recNum = accLst_size.size();

}
public void searchresult(){


    //getResult();
    SYSTEM.DEBUG('Number of records ' + recNum ); 
    accLst = [SELECT Name, Id FROM Account ORDER BY Name LIMIT :limits OFFSET: counter ];//WHERE id in: AccountID and name != null LIMIT :limits OFFSET: counter ];

}

public void nextbtn(){
    counter += limits ;
    searchresult();
}

public void prvbtn(){
    counter -= limits ;
    searchresult();
}

public void fstbtn(){
    counter = 0;
    searchresult();
}

public void endbtn(){
    counter = recNum - math.mod(recNum,limits);
    searchresult();
}

public boolean getprv(){
    if(counter == 0)
        return true;
    else
        return false;
}

public boolean getnxt(){
    if((counter + limits) > recNum)
        return true;
    else
        return false;
}
}