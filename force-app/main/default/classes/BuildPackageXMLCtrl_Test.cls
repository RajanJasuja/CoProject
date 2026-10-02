/**
 * @Company     : PwC.
 * @Description : 
 * *****************************************************************************************************
 * Test class for BuildPackageXMLCtrl class.
 * *****************************************************************************************************
 * @History     : 
 * [22.Sept.2014] Sajana Thomas - Code Creation 
 */

@isTest
private class BuildPackageXMLCtrl_Test{

    String query;
    
    static testMethod void BuildPackageXMLTest() {
        
        List<Project__c> ListProject = UnitTestHelper.getProjectInstances(1);
        insert ListProject;
        
        List<Work_Package__c> ListWorkPackage = UnitTestHelper.getWorkPackageInstances(1, ListProject[0].id);
        insert ListWorkPackage;
        
        List<Requirement__c> listRequirement = UnitTestHelper.getRequirementInstances(1, ListWorkPackage[0].id);
        insert listRequirement; 
        
        List<Work_Task__c> ListWorkTask = UnitTestHelper.getWorkTaskInstances(1, listRequirement[0].id);
        insert ListWorkTask;
        
        
        Deployment_Component__c oDiploymentComponent = UnitTestHelper.getDeploymentComponent(ListWorkTask[0].id);
        insert oDiploymentComponent;
        
        ApexPages.StandardController sController = new ApexPages.StandardController(ListWorkPackage[0]);        
        BuildPackageXMLCtrl buildPackageXML = new BuildPackageXMLCtrl (sController);   
        buildPackageXML.init();
    }
    
}