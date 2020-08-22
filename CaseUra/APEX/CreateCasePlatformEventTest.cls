@isTest
public class CreateCasePlatformEventTest {
    
    @isTest static void testValidEvent() {
        
        Account acc = testHelper.criaConta('accoutName');
        insert acc;
        
        Contact contato = testHelper.criaContato(acc, 'nome', 'sobrenome');
        insert contato;
        
        Case caso = testHelper.criaCaso(contato.id);
        insert caso;
                  
        String userId = UserInfo.getUserId();
        

        
        Test.startTest();
        
        // Create a test event instance
        CreateCasePlatformEvent platformEvent = new CreateCasePlatformEvent(caso.id,userId);   
        
        Test.stopTest();
                        
    }
    
}