@isTest
private class myDataGenerationTests{
  
  @TestSetup
  static void loadTestDataFromStaticResource(){
    List<sObject> accounts = Test.loadData(Account.SObjectType,'Mock_Data');
  }
  @isTest static void testLoadAccountsFromStaticResource() {
    List<Account> accts = [SELECT ID FROM Account];
    system.assert(accts.size() == 15, 'expected 3 accounts');
  }
  
  
  
  
  
  
  
  
}