Public with sharing class myControllr {
 Public Boolean ShowpageBlockFlag{get;set;}
 Public Account accRec{get;set;}
 
  Public myControllr (){
   accRec = [select name,id,accountnumber from account limit 1];
   ShowpageBlockFlag = false;
  }
   Public void ShowBlockMethod(){
   ShowpageBlockFlag = true;
  }
}