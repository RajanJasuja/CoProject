/*
*This class provides test coverage for EditTestCaseExtension code
*/
@isTest
private class  EditTestCaseStepExtensionTest {
    //------------------------------Test Methods -------------------------------------------------------------------------
    static testMethod void EditTestCaseStepExtensionTestMethod(){
        
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
        workPackage.Priority__c = 'High';
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
        
        Requirement__c oReq = new Requirement__c();
        oReq.Work_Package__c = workPackage.id;
        oReq.Status__c = 'In Progress';
        oReq.Priority__c = 'High';
        oReq.Work_Stream_Type__c = 'Integration';
        oReq.Summary__c = 'test Demo';
        insert oReq;
        
        Work_Task__c oWT = new Work_Task__c();
        oWT.Task_Summary__c = 'Test';
        oWT.Status__c = '5.2 Sprint Team - With BPC';
        oWT.Assigned_To__c = UserInfo.getUserId();
        oWT.Requirement__c = oReq.id;
        oWT.Complexity__c = '3 - Low Complexity Development with Config';
        insert oWT;

        //Prepare Test case step object
        Test_Case__c testCase = new Test_Case__c();
        testCase.Test_Case_Name__c = 'Test Case Test';
        testCase.Summary__c = 'New test Summary';
        testCase.Type__c = 'Unit Test';
        //testCase.Status__c = 'In Progress';
        testCase.Sprint__c = workPackage.Id;
        testCase.Work_Task__c = oWT.id;
        insert testCase;
        
        //Prepare Test case step object
        
        Test_Case_Step__c testCaseStep1 = new Test_Case_Step__c();
        testCaseStep1.Step_Number__c = 1;
        testCaseStep1.Test_Case__c = testCase.Id;
        insert testCaseStep1;
        
        Test_Case_Step__c testCaseStep2 = new Test_Case_Step__c();
        testCaseStep2.Step_Number__c = 2;
        testCaseStep2.Test_Case__c = testCase.Id;
        insert testCaseStep2;
        
        
        //Class Object Creation
        
        Test_Case_Step__c testCaseStep = new Test_Case_Step__c();
        testCaseStep.Test_Case__c  = testCase.Id;
        
        ApexPages.StandardController sController = new ApexPages.StandardController(testCase);
        EditTestCaseStepExtension editTCSExtensionController = new EditTestCaseStepExtension(sController);
        
        //Method Call 
        editTCSExtensionController.newTestCaseStep = testCaseStep;
        editTCSExtensionController.addTestCaseStep();
        editTCSExtensionController.getTestCaseSteps();
        editTCSExtensionController.updateTestCaseStep();    
        editTCSExtensionController.removeTestCaseStep();
        editTCSExtensionController.getSelected();       
     }
     
     static testMethod void EditTestCaseStepExtensionTestMethod1(){
        
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
        workPackage.Priority__c = 'High';
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
        
        Requirement__c oReq = new Requirement__c();
        oReq.Work_Package__c = workPackage.id;
        oReq.Status__c = 'In Progress';
        oReq.Priority__c = 'High';
        oReq.Work_Stream_Type__c = 'Integration';
        oReq.Summary__c = 'test Demo';
        insert oReq;
        
        Work_Task__c oWT = new Work_Task__c();
        oWT.Task_Summary__c = 'Test';
        oWT.Status__c = '5.2 Sprint Team - With BPC';
        oWT.Assigned_To__c = UserInfo.getUserId();
        oWT.Requirement__c = oReq.id;
        oWT.Complexity__c = '3 - Low Complexity Development with Config';
        insert oWT;

        
        //Prepare Test case step object
        Test_Case__c testCase = new Test_Case__c();
        testCase.Test_Case_Name__c = 'Test Case Test';
        testCase.Summary__c = 'New test Summary';
        testCase.Type__c = 'Unit Test';
        testCase.Sprint__c = workPackage.Id;
        testCase.Work_Task__c = oWT.id;
        insert testCase;
        
        //Prepare Test case step object
        
        Test_Case_Step__c testCaseStep1 = new Test_Case_Step__c();
        testCaseStep1.Step_Number__c = 0;
        testCaseStep1.Test_Case__c = testCase.Id;
        insert testCaseStep1;
        
        //Test_Case_Step__c testCaseStep2 = new Test_Case_Step__c();
        //testCaseStep2.Step_Number__c = 2;
        //testCaseStep2.Test_Case__c = testCase.Id;
        //insert testCaseStep2;
        
        
        //Class Object Creation
        
        Test_Case_Step__c testCaseStep = new Test_Case_Step__c();
        testCaseStep.Test_Case__c  = testCase.Id;
        
        ApexPages.StandardController sController = new ApexPages.StandardController(testCase);
        EditTestCaseStepExtension editTCSExtensionController = new EditTestCaseStepExtension(sController);
        
        //Method Call 
        editTCSExtensionController.newTestCaseStep = testCaseStep;
        editTCSExtensionController.addTestCaseStep();
        editTCSExtensionController.getTestCaseSteps();
        editTCSExtensionController.updateTestCaseStep();    
        editTCSExtensionController.removeTestCaseStep();
        editTCSExtensionController.getSelected();       
     }      

}