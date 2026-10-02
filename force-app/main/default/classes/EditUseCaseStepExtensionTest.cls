/*
*This class provides test coverage for EditUseCaseExtension code
*/
@isTest
private class  EditUseCaseStepExtensionTest {
    //------------------------------Test Methods -------------------------------------------------------------------------
    static testMethod void EditUseCaseStepExtensionTestMethod(){
        
        //Prepare test data
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
        workPackage.Number_Of_Resources__c = 2;
        insert workPackage;
        
        //Prepare Use Case
        Use_Case__c useCase = new Use_Case__c();
        useCase.Use_Case_Name__c = 'Use Case Test';
        useCase.Work_Package__c = workPackage.Id;
        useCase.Actor__c = 'Profile1';
        useCase.Trigger__c = 'Test Trigger';
        useCase.Description__c = 'Test Description';
        insert useCase;
        
        
        //Prepare use case step object
        
        Use_Case_Step__c useCaseStep1 = new Use_Case_Step__c();
        useCaseStep1.Step_Number__c = 1;
        useCaseStep1.Use_Case__c = useCase.Id;
        insert useCaseStep1;
        
        Use_Case_Step__c useCaseStep2 = new Use_Case_Step__c();
        useCaseStep2.Step_Number__c = 2;
        useCaseStep2.Use_Case__c = useCase.Id;
        insert useCaseStep2;
        
        //Class Object Creation
        
        Use_Case_Step__c useCaseStep = new Use_Case_Step__c();
        useCaseStep.Use_Case__c  = useCase.Id;
        
        ApexPages.StandardController sController = new ApexPages.StandardController(useCase);
        EditUseCaseStepExtension editUCSExtensionController = new EditUseCaseStepExtension(sController);
        
        //Method Call 
        editUCSExtensionController.newUseCaseStep=useCaseStep;
        editUCSExtensionController.addUseCaseStep();
        editUCSExtensionController.getUseCaseSteps();
        editUCSExtensionController.updateUseCaseStep();     
        editUCSExtensionController.removeUseCaseStep();     
     }      

}