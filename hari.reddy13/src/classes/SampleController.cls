public with sharing class SampleController {

    public SampleController(ApexPages.StandardController controller) {
/*




public without sharing class AP111_CaseTriggerUtility {
    
    public Map<Id,User> fetchUserDetails(List<Id> UserId){
        Map<Id,User> temp_UserManagerMap = new Map<Id,User>();
        for(User usr : [select Id, Name, ManagerId, TimeZoneSidKey from User where id IN: userId]){
            temp_UserManagerMap.put(usr.Id, usr);
        }
        return temp_UserManagerMap;
    }
    
    public List<Task> createTaskList(List<Case> caseActivityList){
        List<task> taskToCreate = new List<Task>();
        Map<String,Dispatch_Category__c> dispatchCategoryMap = new Map<String,Dispatch_Category__c>();
        List<String> allCaseNumber = new List<String>();
        Set<String> dispatchCategory = new Set<String>();
        Set<Id> salesRouteList = new Set<Id>();
        Map<String, String> stringCriteriaMap = new Map<String, String>();
        Map<String, String> numberCriteriaMap = new Map<String, String>();
        Map<Id, Map<String, String>> caseStringCriteriaMap = new Map<Id, Map<String, String>>();
        Map<Id, Map<String, String>> caseNumberCriteriaMap = new Map<Id, Map<String, String>>();
        
        for(Case temp_cse: caseActivityList){                      
            salesRouteList.add(temp_cse.Account.SalesRoute__c);
            dispatchCategory.add(temp_cse.activityTypeProblemReported__r.DispatchCategoryCode__c);
            stringCriteriaMap.put(Label.CL00040_KAMAccountKey, temp_cse.Account.KAM__c);
            stringCriteriaMap.put(Label.CL00041_OPAMAccountKey, temp_cse.Account.CX_MDM_ADM_Number__c);
            stringCriteriaMap.put(Label.CL00042_TradeNameAccountKey, temp_cse.Account.Trade_Name__c);
            stringCriteriaMap.put(Label.CL00043_DispatchStringAccountKey, temp_cse.Account.Dispatch_String__c);
            stringCriteriaMap.put(Label.CL00044_SalesTypeAccountKey, temp_cse.Account.Sales_Type_Code__c);
            stringCriteriaMap.put(Label.CL00045_ZipAccountKey, temp_cse.Account.Outlet_Zip__c);
            stringCriteriaMap.put(Label.CL00046_ChannelAccountkey, temp_cse.Account.Subtrade_Channel__c);
            numberCriteriaMap.put(Label.CL00047_SalesRouteAccountKey, temp_cse.Account.Sales_Route__c);
            caseStringCriteriaMap.put(temp_cse.id, stringCriteriaMap);
            caseNumberCriteriaMap.put(temp_cse.id, numberCriteriaMap);
        }
        
        
        for(Case cs : caseActivityList){
            //caseInsertedIds.add(cs.Id);
            //caseAccIdList.add(cs.AccountId);
            if(String.isNotBlank(cs.PreviousCase__c) && String.isNotBlank(cs.RepeatCall__c))
            {
                allCaseNumber.add(cs.PreviousCase__c);
            }
        }
        //List<Case> caseToUpdate = new List<Case>();
        
        for(Case cseActList : caseActivityList){
            Task tsk = assignTaskRecordData(null,cseActList);
            System.debug('Current Case***'+cseActList);
            
            // Assign Task for Escalated Case
            if(cseActList.PreviousCase__c != '' && cseActList.RepeatCall__c != null) {
                tsk.OwnerId = assignEscalatedTask(cseActList,allCaseNumber);
                if(tsk.OwnerId == null){
                    cseActList.addError(Label.CL00048_NoManagerErrorMessage);
                    return null;
                }
            }
            // Dispatch Category assignment
            else if(!cseActList.activityTypeProblemReported__r.SFAUser__c){
                tsk.OwnerId = assignTaskToNonSFAUser(cseActList, dispatchCategory, caseStringCriteriaMap, caseNumberCriteriaMap);
            }// end dispatch Category assignment
            
            // SFA User assignment
            else{
                tsk.AssignedToApp__c = Label.CL00151_AssignedToSFA;
                tsk.ownerId = assignTaskToSFAUser(cseActList, salesRouteList);
            }
            taskToCreate.add(tsk);
        }
        return taskToCreate;
    }
    
    public Task assignTaskRecordData(Id taskId, Case cse){
        Task tsk;
        Map<String,CS101_SLAPriorityMapping__c> slaPriorityMap = CS101_SLAPriorityMapping__c.getAll();
        if(taskId == null){
            tsk = new Task();
        }
        else{
            tsk = new Task(id = taskId);
        }
        
        tsk.WhatId = cse.Id;
        tsk.WhoId = cse.ContactId;
        if(slaPriorityMap.containsKey(cse.activityTypeProblemReported__r.SLA__c)){
            tsk.Priority  = slaPriorityMap.get(cse.activityTypeProblemReported__r.SLA__c).Priority__c;                   
        }
        tsk.RecordTypeId = AP107_CasePageUtility.findRecordTypeId(Label.CL00038_CCTaskRecordType);
        tsk.LocalActivity__c = cse.activityTypeProblemReported__r.LocalActivity__c;
        tsk.NewOutletInfo__c = cse.activityTypeProblemReported__r.NewOutletInfo__c;
        tsk.EnableResolutionCycle__c = cse.activityTypeProblemReported__r.EnableResolutionCycle__c;
        tsk.Subject = cse.CaseNumber+ Label.CL00052_CCHyphenSymbol +cse.activityType__c;
        tsk.TECHRepeatCall__c = cse.RepeatCall__c;
        tsk.SLA__c = cse.activityTypeProblemReported__r.SLA__c;
        tsk.TECHPreviousCase__c = cse.PreviousCase__c;
        if(String.isNotBlank(tsk.TECHPreviousCase__c)){
            tsk.Status = Label.Cl108_CaseStatusEscalate;
        }
        tsk.Dispatcher__c = Label.CL00039_TaskDispatcherValue;
        tsk.Dispatched__c = System.now();
        tsk.ActivityType__c = cse.activityTypeProblemReported__r.Name;
        tsk.Tech_Auto_Dispatch__c = cse.activityTypeProblemReported__r.AutoDispatch__c;
        
        return tsk;
    }
    
    public Id assignTaskToNonSFAUser(Case cse, Set<String> dispCategory, Map<Id, Map<String, String>> cseStrCriteriaMap, Map<Id, Map<String, String>> cseNumCriteriaMap){
        Id nonSFAOwnerId;
        Id assignedToUserId;
        List<Dispatch_Category__c> dispCatList = new List<Dispatch_Category__c>();
        List<String> stringCriteria = new List<String>();
        List<String> numberCriteria = new List<String>();
                      
        stringCriteria.add(Label.CL00040_KAMAccountKey);  
        stringCriteria.add(Label.CL00041_OPAMAccountKey);
        stringCriteria.add(Label.CL00042_TradeNameAccountKey);
        stringCriteria.add(Label.CL00043_DispatchStringAccountKey);
        stringCriteria.add(Label.CL00044_SalesTypeAccountKey);
        stringCriteria.add(Label.CL00045_ZipAccountKey);
        stringCriteria.add(Label.CL00046_ChannelAccountkey);
        numberCriteria.add(Label.CL00047_SalesRouteAccountKey);
        
        
        
        dispCatList = [select id, name, AssignedUser__c, Criteria1__c, Criteria2__c, Criteria1From__c, Criteria2From__c, Criteria1To__c, Criteria2To__c,
                      MarketUnitCode__c, BusinessUnitCode__c, SaleLocationCode__c from Dispatch_Category__c where name in: dispCategory];
        
        for(Dispatch_Category__c dc : dispCatList){                 
            if((cse.Account.Name).contains(Label.CL00049_DummyAccountValue)){
                if (cse.Account.MarketingUnitCode__c == dc.MarketUnitCode__c && cse.Account.Business_Unit_Code__c == dc.BusinessUnitCode__c 
                    && cse.Account.Sales_Location_And_Number__c == dc.SaleLocationCode__c && dc.Criteria1__c == Label.CL00049_DummyAccountValue){
                    assignedToUserId = dc.AssignedUser__c;
                    break;
                }                        
            }
                     
            else if(cse.Account.MarketingUnitCode__c == dc.MarketUnitCode__c 
                    && cse.Account.Business_Unit_Code__c == dc.BusinessUnitCode__c 
                    && cse.Account.Sales_Location_And_Number__c == dc.SaleLocationCode__c){
                
                for(String s: stringCriteria){
                    if(dc.Criteria1__c == s && dc.Criteria1From__c == (cseStrCriteriaMap.get(cse.id)).get(s)){
                        if(String.IsEmpty(dc.Criteria2__c)){
                            assignedToUserId = dc.AssignedUser__c;
                            break;
                        }
                        else{        
                            for(String s1: stringCriteria){
                                if(dc.Criteria2__c == s1 && dc.Criteria2From__c == (cseStrCriteriaMap.get(cse.id)).get(s1)){
                                  assignedToUserId = dc.AssignedUser__c;
                                  break;
                                }
                                for(String n: numberCriteria){
                                    if(String.isEmpty(dc.Criteria2To__c)){
                                        if(dc.Criteria2__c == n && dc.Criteria2From__c == (cseNumCriteriaMap.get(cse.id)).get(n)){
                                            assignedToUserId = dc.AssignedUser__c;
                                            break;
                                        }
                                    }
                                    else{ 
                                        for(String n1: numberCriteria){
                                            if(dc.Criteria2__c == n1 && 
                                                Integer.valueOf(dc.Criteria2From__c) <= Integer.valueOf((cseNumCriteriaMap.get(cse.id)).get(n1))
                                                && Integer.valueOf((cseNumCriteriaMap.get(cse.id)).get(n1)) <= Integer.valueOf(dc.Criteria2To__c)){
                                                assignedToUserId = dc.AssignedUser__c;
                                                break;
                                            }
                                        } 
                                    }   
                                }   
                            }
                        } 
                    }
                }// end for(String s: stringCriteria)
              
                for(String n2: numberCriteria){
                    if(dc.Criteria1__c == n2 && dc.Criteria1From__c == (cseNumCriteriaMap.get(cse.id)).get(n2)
                        && String.isEmpty(dc.Criteria1To__c)){
                        if(String.IsEmpty(dc.Criteria2__c)){
                            assignedToUserId = dc.AssignedUser__c;
                            break;
                        }
                        else{ 
                            for(String s2: stringCriteria){
                                if(dc.Criteria2__c == s2 && dc.Criteria2From__c == (cseStrCriteriaMap.get(cse.id)).get(s2)){
                                  assignedToUserId = dc.AssignedUser__c;
                                  break;
                                }
                                for(String n3: numberCriteria){
                                    if(String.isEmpty(dc.Criteria2To__c)){
                                      if(dc.Criteria2__c == n3 && dc.Criteria2From__c == (cseNumCriteriaMap.get(cse.id)).get(n3)){
                                            assignedToUserId = dc.AssignedUser__c;
                                            break;
                                        }
                                    }
                                    else{ 
                                        if(dc.Criteria2__c == n3 && 
                                            Integer.valueOf(dc.Criteria2From__c) <= Integer.valueOf((cseNumCriteriaMap.get(cse.id)).get(n3))
                                            && Integer.valueOf((cseNumCriteriaMap.get(cse.id)).get(n3)) <= Integer.valueOf(dc.Criteria2To__c)){
                                            assignedToUserId = dc.AssignedUser__c;
                                            break;
                                        }
                                    }   
                                }   
                            }
                        } 
                    }// end if(dc.Criteria1__c == n && dc.Criteria1From__c == (cseStrCriteriaMap.get(c.id)).get(n) && String.isEmpty(dc.Criteria1To__c))
                      
                    else if(dc.Criteria1__c == n2 && String.isNotEmpty(dc.Criteria1To__c) 
                                && Integer.valueOf(dc.Criteria1From__c) <= Integer.valueOf((cseNumCriteriaMap.get(cse.id)).get(n2))
                                && Integer.valueOf((cseNumCriteriaMap.get(cse.id)).get(n2)) <= Integer.valueOf(dc.Criteria1To__c)){
                        if(String.IsEmpty(dc.Criteria2__c)){
                            assignedToUserId = dc.AssignedUser__c;
                            break;
                        }
                        else{ 
                            for(String s3: stringCriteria){
                                if(dc.Criteria2__c == s3 && dc.Criteria2From__c == (cseStrCriteriaMap.get(cse.id)).get(s3)){
                                    assignedToUserId = dc.AssignedUser__c;
                                    break;
                                }
                                for(String n4: numberCriteria){
                                    if(String.isEmpty(dc.Criteria2To__c)){
                                        if(dc.Criteria2__c == n4 && dc.Criteria2From__c == (cseNumCriteriaMap.get(cse.id)).get(n4)){
                                            assignedToUserId = dc.AssignedUser__c;
                                            break;
                                        }
                                    }
                                    else{ 
                                        if(dc.Criteria2__c == n4 
                                            && Integer.valueOf(dc.Criteria2From__c) <= Integer.valueOf((cseNumCriteriaMap.get(cse.id)).get(n4))
                                            && Integer.valueOf((cseNumCriteriaMap.get(cse.id)).get(n4)) <= Integer.valueOf(dc.Criteria2To__c)){
                                            assignedToUserId = dc.AssignedUser__c;
                                            break;
                                        }
                                    }   
                                }   
                            }
                        } 
                    }
                      
                }// end for(String s: numberCriteria)                              
            } 
            if(String.isNotEmpty(assignedToUserId)){
                nonSFAOwnerId = assignedToUserId;
                break;
            }
            else
                nonSFAOwnerId = cse.createdById;
        }
        return nonSFAOwnerId;
    }
    
    public Id assignEscalatedTask(Case cse, List<String> caseNumberList){
            Id taskOwnerId;
            Map<String,Id> caseOwnermap = new Map<String,Id>();
            Map<Id,User> userManagerMap = new Map<Id,User>();
            if(!caseNumberList.isEmpty()){
                for(Case cs1 : [select id, caseNumber, recordTypeId, ownerId from Case where caseNumber IN: caseNumberList]){
                   caseOwnerMap.put(cs1.caseNumber,cs1.OwnerId);
                }
            }
            if(!caseOwnerMap.values().isEmpty()){
                userManagerMap = fetchUserDetails(caseOwnerMap.Values());
            }
            if(caseOwnermap.containsKey(cse.PreviousCase__c)){
                if(userManagerMap.get(caseOwnerMap.get(cse.PreviousCase__c)).ManagerId != null){
                    taskOwnerId = userManagerMap.get(caseOwnerMap.get(cse.PreviousCase__c)).ManagerId;
                }
            }
            return taskOwnerId;
        }
    
    public Id assignTaskToSFAUser(Case cse, Set<Id> routeList){
        Id sfaOwnerId;
        Map<Id,Route_User__c> routeUserMappingMDM = new Map<Id,Route_User__c>();
        Map<Id,Route_User__c> routeUserMappingAM = new Map<Id,Route_User__c>();
        for(Route_User__c ruc : [select Route__c, User__c, User_Profile__c from Route_User__c
                                where Route__c IN: routeList order by lastModifiedDate desc limit 50000]){
            if(ruc.User_Profile__c != null){
                if(!routeUserMappingMDM.containskey(ruc.Route__c) && (String.valueOf(ruc.User_Profile__c).contains('MDM'))){
                    routeUserMappingMDM.put(ruc.Route__c, ruc);
                }
                if(!routeUserMappingAM.containskey(ruc.Route__c) && (String.valueOf(ruc.User_Profile__c).contains('AM'))){
                    routeUserMappingAM.put(ruc.Route__c, ruc);
                }
            }
        }
        if(routeUserMappingMDM.containsKey(cse.Account.SalesRoute__c)){
            sfaOwnerId = routeUserMappingMDM.get(cse.Account.SalesRoute__c).User__c;
        }
        else if(routeUserMappingAM.containsKey(cse.Account.SalesRoute__c)){
            sfaOwnerId = routeUserMappingAM.get(cse.Account.SalesRoute__c).User__c;
        }
        else 
            sfaOwnerId = cse.createdById;
        
        return sfaOwnerId;
    }
    
    public static void completeMilestone(List<Id> caseIds, String milestoneName, DateTime complDate) {
        List<CaseMilestone> cmsToUpdate = [select Id, completionDate
                           from CaseMilestone cm where caseId IN:caseIds
                           and cm.MilestoneType.Name=: milestoneName
                           and completionDate = null limit 1];
        if (!cmsToUpdate.isEmpty()){
            for (CaseMilestone cm: cmsToUpdate){
                cm.completionDate = complDate;
            }
            update cmsToUpdate;
        } // end if
    }
    
    public void updateCaseStatus(List<Task> taskList){
        Map<id,Task> caseMap = new Map<id,Task>();
        Map<Id,User> userMap = new Map<Id,User>();
        List<case> caseList = new List<case>();
        List<Id> caseOwnerId = new List<Id>();
        for(Task tsk : taskList){
            caseMap.put(tsk.whatid,tsk);    
        }
        for(Case cs : [select ownerId from Case where id IN: caseMap.keyset() limit 50000]){
            String ownerIdValue = String.valueOf(cs.OwnerId);
            if(ownerIdValue.StartsWith(User.sObjectType.getDescribe().getkeyPrefix())){
                caseOwnerId.add(cs.OwnerId);
            }
        }
        if(!caseOwnerId.isEmpty()){
            userMap = fetchUserDetails(caseOwnerId);
        }
        
        for(case cs:[select id, Status,caseNumber, recordType.DeveloperName, ownerId, TECHIsCustomerContacted__c from case
                     where id in:caseMap.keyset() limit 50000]){  
                if(caseMap.get(cs.Id).subject.contains(cs.caseNumber)){
                    case tempcs = new case(id=cs.id);
                    if(caseMap.get(cs.Id).status == Label.Cl108_CaseStatusEscalate){
                        tempcs.Status = Label.Cl108_CaseStatusEscalate;
                    }
                    if(caseMap.get(cs.Id).Status == Label.CL109_CaseStatusWorkDispatched){
                        tempcs.Status = Label.CL109_CaseStatusWorkDispatched;
                    }
                    if(caseMap.get(cs.id).Status == Label.CL00025_TaskStatusCompleted){
                         tempcs.status = Label.CL00026_CaseStatusClosed;    
                    }
                    if(caseMap.get(cs.id).PlannedResolutionDate__c != null){
                        tempcs.TECHPlannedResolutionDate__c = caseMap.get(cs.id).PlannedResolutionDate__c;//DateTime.newInstanceGMT(caseMap.get(cs.id).PlannedResolutionDate__c.Date(), caseMap.get(cs.id).PlannedResolutionDate__c.time());
                    }
                    tempcs.TECHIsCustomerContacted__c = caseMap.get(cs.id).IsCustomerContacted__c;
                    caseList.add(tempcs);    
                }
        }
        Database.Update(caseList, false);
        
    }

    public static Map<Id, DateTime> queryCaseMilestone(Set<Id> caseIdList){
        Map<Id, DateTime> caseDueDateMap = new Map<Id, DateTime>();
        for(CaseMilestone  cms: [select Id, caseId, targetDate from CaseMilestone where caseId in :caseIdList]){
            caseDueDateMap.put(cms.caseId, cms.targetDate);
        }
        return caseDueDateMap;
    }
    
    public static Map<Id,Case> queryCaseData(Set<Id> caseIdList){
        Map<Id,Case> caseMap = new Map<Id,Case>([select id, dueDate__c, contactId, CaseNumber, EntitlementId,
                                                activityTypeProblemReported__r.SLA__c,
                                                activityTypeProblemReported__r.LocalActivity__c, 
                                                activityTypeProblemReported__r.NewOutletInfo__c,
                                                activityTypeProblemReported__r.EnableResolutionCycle__c,
                                                activityType__c, RepeatCall__c, PreviousCase__c,
                                                activityTypeProblemReported__r.SFAUser__c, Account.Sales_Location_And_Number__c,
                                                Account.SalesRoute__c, Account.Name, 
                                                activityTypeProblemReported__r.DispatchCategoryCode__c,
                                                ownerId, activityTypeProblemReported__r.Name,
                                                activityTypeProblemReported__r.AutoDispatch__c,
                                                Account.MarketingUnitCode__c, Account.Business_Unit_Code__c, 
                                                Account.KAM__c, Account.CX_MDM_ADM_Number__c, Account.Sales_Route__c,
                                                Account.Sales_Type_Code__c, Account.Trade_Name__c,
                                                Account.Outlet_Zip__c, Account.Dispatch_String__c, Account.Subtrade_Channel__c,
                                                Account.Transition_To__c, createdById from Case where Id IN: caseIdList]);
        return caseMap;
    }
    
}


*/





/*

@isTest
public class AP111_CaseTriggerUtility_Test 
{
  Public static testMethod void AP111_CaseTriggerUtility_Method()
     {  
        Test.startTest();
        
        User u = new User(Alias = 'standt', 
                          Email='coke@accenture.com', 
                        EmailEncodingKey='UTF-8', 
                          LastName='Testing', 
                          LanguageLocaleKey='en_US', 
                        LocaleSidKey='en_US', 
                          ProfileId = '00eG0000001CjwLIAS', 
                        TimeZoneSidKey='America/Los_Angeles', 
                          UserName='coke@accenture.com');
        insert u;
        
        system.assert(u.Id !=null);
                                                                list<id> uids=new List<Id>() ;
                                                                uids.add(u.id);
        Account acc = new Account();
        acc.Name = 'Coke Company';
        acc.Subtrade_Channel__c = '014';
        acc.Outlet_Type__c = 'FS';
        acc.Sales_Method__c = '1';
        acc.DSD_Country__c = 'US';
         acc.Transition_To__c='NI';
        insert acc;
        
       //Create the Contact test data
        Contact con = new Contact();
        con.LastName='Test';
        con.AccountId  = acc.id;
       // con.Phone = '1234567890';
        insert con;
        Entitlement ent=new Entitlement();
           ent.AccountId=acc.id;
           ent.name='Coke';
           insert ent;
        Case testCase = new Case();
            testCase.Status ='New';
            testCase.Origin='Phone';
            testCase.Subject='This is a test case'; 
            
            testCase.AccountId = acc.Id;
            testCase.ContactId = con.Id;
            //testCase.recordtypeid = '012J00000005JJM';
            testCase.EquipmentType__c = 'VE';
            testCase.WorkClass__c = '01';
            testCase.ServiceType__c = '8';
            testCase.ProblemReported__c = '001'; 
            testCase.PONumber__c = '123456';
            testCase.Phone__c = '123456789';
            testCase.CallerType__c = 'Contact';
            testCase.HoursAvailableStartTime__c = '01:00';
            testCase.HoursAvailableEndTime__c  ='02:00';
            testCase.DaysAvailable__c='Monday';
            testCase.ExtendedDesription__c ='Test Web Description';
            testCase.TECHPlannedResolutionDate__c= Date.newInstance(2015,9,10);
            testCase.TECHDispatchClassification__c='OP';
           testCase.SlaStartDate = System.now()-1;
           testcase.TECHIsCustomerContacted__c=true;
           testcase.EntitlementId=ent.Id;
           testcase.Status = 'Closed';
           testcase.ActivityType__c = 'New Activity';
           //testcase.ActivityTypeProblemReported =;
          insert testCase;
           List<Task> tasks = new List<Task>();
      tasks.add(new Task(
          ActivityDate = Date.today().addDays(7),
        Subject='Sample Task',
        WhatId = acc.Id,
        OwnerId = UserInfo.getUserId(),
        Status='In Progress'));
        
        
        AP111_CaseTriggerUtility CaseTrigger= new AP111_CaseTriggerUtility();
        CaseTrigger.fetchUserDetails(uids);
       // CaseTrigger.createTaskList(testCase);
        Test.stopTest();        
    }
}*/
   
 }

}