public with sharing class SampleViewController {
    
     public List<payment__c> pay {set; get;}
     
     public SampleViewController(){
         pay = [select id, name, Account__c, Date__c, Fee_Paid__c from Payment__c];
         
         
     }
     
     public Attachment attachment {
  get {
      if (attachment == null)
        attachment = new Attachment();
      return attachment;
    }
  set;
  }

   // public Attachment attachment{set;get;}
    
  public PageReference upload() {

    attachment.OwnerId = UserInfo.getUserId();
    attachment.ParentId = 'a009000000YOary'; // the record the file is attached to
    attachment.IsPrivate = true;

    try {
      insert attachment;
    } catch (DMLException e) {
      ApexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Error uploading attachment'));
      return null;
    } finally {
      attachment = new Attachment(); 
    }

    ApexPages.addMessage(new ApexPages.message(ApexPages.severity.INFO,'Attachment uploaded successfully'));
    return null;
  }   
    
}