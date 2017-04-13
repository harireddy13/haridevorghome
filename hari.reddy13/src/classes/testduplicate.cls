@isTest 
public class testduplicate {
  static testMethod void testDetectDupes() {
    Lead lead1 = new Lead();
    lead1.FirstName = 'Frodo';
    lead1.LastName  = 'Baggins';
    lead1.Company   = 'Shire';
    insert lead1;
    
    Contact ctc1 = new Contact();
    ctc1.FirstName = 'Frodo';
    ctc1.LastName  = 'Baggins';
    insert ctc1;
    
    Lead dupe = new Lead();
    dupe.FirstName = 'Frodo';
    dupe.LastName  = 'Baggins';
    dupe.Company   = 'Shire';
    insert dupe;
    
    dupe = [SELECT Id, Potential_Lead_Dupe__c, 
                   Potential_Contact_Dupe__c 
            FROM Lead 
            WHERE Id = :dupe.Id];
    System.assertEquals(lead1.Id, dupe.Potential_Lead_Dupe__c);
    System.assertEquals(ctc1.Id, dupe.Potential_Contact_Dupe__c);
    
    dupe.FirstName = 'Bilbo';
    dupe.LastName  = 'Baggins';
    update dupe;
    
    dupe = [SELECT Id, Potential_Lead_Dupe__c, 
                   Potential_Contact_Dupe__c 
            FROM Lead 
            WHERE Id = :dupe.Id];
    System.assertEquals(lead1.Id, dupe.Potential_Lead_Dupe__c);
    System.assertEquals(ctc1.Id, dupe.Potential_Contact_Dupe__c);
  }
}