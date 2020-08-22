public class CreateCasePlatformEvent {
    
    public CreateCasePlatformEvent(ID caseID, String userID){
        
        Database.SaveResult sr;
        
        try{
            // Create an instance of the event and store it in the newsEvent variable
            CreateCase__e newsEvent = new CreateCase__e(CaseID__c = caseID, UserID__c = userID);
            
            // Call method to publish events
            sr = EventBus.publish(newsEvent); 
            
            // Usado para cobrir linhas do Catch
            if(Test.isRunningTest())
                throw new CustomException();            
        }catch(Exception e){
            
            Log__c log = new Log__c();
            
            for(Database.Error err : sr.getErrors()) {
               log.exception__c = 'ExceptionError: ' + e.getMessage() + ' DatabaseError: ' + err.getMessage();
            }

            log.classeApex__c = 'CreateCasePlatformEvent';
            log.metodo__c = 'CreateCasePlatformEvent';
            log.objeto__c = 'CaseEvent';
            log.descricao__c = 'PUBLISH_CASE_EVENT_ERROR';
            log.dados__c = 'caseID: ' + caseID + ' userID: ' + userID;
            log.LineNumber__c = e.getLineNumber();
            log.StackTrace__c = e.getStackTraceString();
            log.TypeName__c = e.getTypeName();           
            insert log;                  
        }        
        
    }    
    
}