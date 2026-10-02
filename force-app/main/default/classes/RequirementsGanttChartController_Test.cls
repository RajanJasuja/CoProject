/**
 * This class contains unit tests for RequirementGanttChartController
 *
 */
@isTest
private class RequirementsGanttChartController_Test {
     static testMethod void myUnitTest() {
        //Prepare release
        Project__c release = new Project__c();
        release.Name = 'Release Test';
        release.Release_Type__c = 'Major';
        release.Status__c = 'Planned';
        insert release;
        
        //Prepare work package
        Work_Package__c workPackage = new Work_Package__c();
        workPackage.Work_Package_Name__c = 'work Package Test';
        workPackage.Status__c = 'In Progress';
        workPackage.Project__c = release.Id;
        workPackage.Priority__c = 'High';
        workPackage.Number_Of_Resources__c = 2;
        insert workPackage;
        
        //Prepare for requirement
        Requirement__c requirement = new Requirement__c();
        requirement.Summary__c  = 'Requirement Test';
        requirement.Source__c = 'Requirement Source';
        requirement.Status__c = 'New';
        requirement.Work_Package__c = workPackage.Id;
        insert requirement;
        
        
        RequirementsGanttChartController controller = new RequirementsGanttChartController();
        
        controller.mytarget = workPackage.Id;
        controller.getProjectGanttJson();
     }
}