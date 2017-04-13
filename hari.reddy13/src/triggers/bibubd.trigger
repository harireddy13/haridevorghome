trigger bibubd on Account (before insert, before update, before delete,
                          after insert, after update, after delete) {
                              
 If (Trigger.isbefore)                             
          
     
     if (trigger.isdelete){
                              
         for (account a : trigger.old){
             if(a.name == 'ramesh'){
             a.addError(a.name + 'can\'t delete record');
             system.debug('I Am in before delete trigger');
             }
         }
     }    
                              else {
                              
                              }
                              
                              
else{
    
    system.debug('I Am in after delete Trigger');
                              
                              
                              }
}