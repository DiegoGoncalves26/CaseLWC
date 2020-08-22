public with sharing class CasoUraController {
    
    @AuraEnabled(cacheable=true)
    public static List<DataTableWrapper> getCaseByID(String caseID) {
        
    	List<DataTableWrapper> response = new List<DataTableWrapper>();
        List<Case> listCase = [select caseNumber from Case where id =: caseID];
        
        for(Case cases : listCase){
            DataTableWrapper obj = new DataTableWrapper();
            obj.id = cases.Id;
            obj.caseNumber = cases.caseNumber;
            obj.nameUrl = ''+cases.Id;
            response.add(obj);
        } 
        system.debug(response);
        return response;
    } 
    
    private class DataTableWrapper {
        @AuraEnabled
        public Id id {get;set;}
        @AuraEnabled
        public String nameUrl {get;set;}
        @AuraEnabled
        public String caseNumber {get;set;}
    }    

}