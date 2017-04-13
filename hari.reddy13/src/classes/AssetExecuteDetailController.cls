global class AssetExecuteDetailController
{
  
        public static list<Alignment_Rule__c> arList{Set;get;}
        public static list<Account> accList{Set;get;}
        public static list<Alignment_Territory__c> altList{Set;get;}
        public static list<Territory2> terList {Set;get;}                
        set<ID> territoryId = new set<ID>();        
        Public static set<String> terrirotyname = new set<String>();        
        
        /*public AssetExecuteDetailController()
        {
         ID  = ApexPages.CurrentPage().getparameters().get('id');
         System.debug('**************'+ID);
        }*/
        
        webservice static string AssetExecuteDetail(id ID ){
        
       // currentRecordId  = ApexPages.CurrentPage().getparameters().get('id');
        
        arList = [select id,Name,Alignment_Rule_Set__c,Attribute_Name__c,Attribute_Type__c,Attribute_Value__c,Operator__c from Alignment_Rule__c where Alignment_Rule_Set__c =: ID];
        
        altList = [SELECT Alignment_Rule_Set__c,Id,Name,Territory_ID__c,Territory__c FROM Alignment_Territory__c where Alignment_Rule_Set__c =: ID]; 

        for(Alignment_Territory__c a : altList) 
            { 
                terrirotyname.add(a.Territory__c); 
            } 
    
         terList = [Select id,name from Territory2 where name in:terrirotyname ];
        for(Alignment_Rule__c ar:arList){
        
        String s = 'SELECT ID FROM Account WHERE ';

            for(Integer i=0;i<arList.size();i++){
                
                s = s + arList.get(i).Attribute_Name__c + ' ' + arList.get(i).Operator__c + ''+'\''+ arList.get(i).Attribute_Value__c +'\'';
                    if(i + 1 < arList.Size())
                    s = s + ' OR '; 
                }
        System.debug('**************'+s);
        accList = Database.Query(s);
        System.debug('**************'+accList.size());
        }
        
        
        List<ObjectTerritory2Association> shares = new List<ObjectTerritory2Association>();  
        
        if(accList!=null && accList.size()>0)
        {
        
          for(Account a : accList)
            {
                for(Territory2 ter: terList){
                
            ObjectTerritory2Association aShare = new ObjectTerritory2Association();
            aShare.ObjectId = a.Id;
            aShare.Territory2Id= ter.Id;
            aShare.AssociationCause='Territory2Manual';
            
            shares.add(aShare);
            System.debug('****************'+aShare);
                    }
             
             }
             
          }   
        System.debug('****************'+shares);

        database.insert (shares,false);
        
        return null;
        }

}