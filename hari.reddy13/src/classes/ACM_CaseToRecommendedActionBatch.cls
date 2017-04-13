global class ACM_CaseToRecommendedActionBatch implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext BC) {
        return Database.getQueryLocator(
            'SELECT Title,UrlName,ValidationStatus,VersionNumber'+ 
            'FROM KnowledgeArticleVersion' +
            'WHERE PublishStatus = Online AND Language = en_US AND ValidationStatus = Not Validated');
             }
             
             
 global void execute(Database.BatchableContext BC, List<sObject> scope) {
 List<KnowledgeArticleVersion> knowledgearticles = (List<KnowledgeArticleVersion>) scope;
 List<KnowledgeArticleVersion> craeateDraftArticles = new List<KnowledgeArticleVersion>();

    for(KnowledgeArticleVersion c : knowledgearticles){
    }
    

     }
  
    global void finish(Database.BatchableContext BC) {
    }           
 }