Public with sharing class ApexRerender {
  Public string OutPutString{get;set;}
   
  Public ApexRerender (){
    OutPutString = 'Test value set in Constructor';
  }
   
  Public void ShowBlockMethod(){
   OutPutString = 'value set in method called by button click' ;
  }
}