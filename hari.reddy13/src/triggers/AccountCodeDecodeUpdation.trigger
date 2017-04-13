Trigger AccountCodeDecodeUpdation on Account (before insert,before update)
  {
    
    List<Code_Decode__c> codeDecodelist=[SELECT FieldName__c,sObject__c,Value__c FROM Code_Decode__c WHERE sObject__c='Account'];
    for(sObject acc : trigger.new)
    {
    for(Code_Decode__c codeDecode : codeDecodelist)
           acc.put(codeDecode.FieldName__c,codeDecode.Value__c );
    }

    }