/**
 * This class contains unit tests for vRequirementCalendarController
 *
 */
@isTest
private class RequirementCalendarController_Test {
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
        
        Work_Task__c workTask1 = new Work_Task__c();
        workTask1.Task_Summary__c = 'Work Task Test 1';
        workTask1.Estimate_Hours__c = 6;
        workTask1.Type__c = 'Requirement Analysis';
        workTask1.Status__c = 'New';
        workTask1.Requirement__c = requirement.Id;
        workTask1.Start_Date__c = datetime.newInstance(2008, 12, 1, 12,30, 2);
        workTask1.End_Date__c = datetime.newInstance(2008, 12, 2, 12,30, 2);
        insert workTask1;
        
        Work_Task__c workTask2 = new Work_Task__c();
        workTask2.Task_Summary__c = 'Work Task Test 2';
        workTask2.Estimate_Hours__c = 6;
        workTask2.Type__c = 'Biz Process Design';
        workTask2.Status__c = 'New';
        workTask2.Requirement__c = requirement.Id;
        workTask2.Start_Date__c = datetime.newInstance(2008, 12, 3, 12,30, 2);
        workTask2.End_Date__c = datetime.newInstance(2008, 12, 4, 12,30, 2);
        insert workTask2;
        
        Work_Task__c workTask3 = new Work_Task__c();
        workTask3.Task_Summary__c = 'Work Task Test 3';
        workTask3.Estimate_Hours__c = 6;
        workTask3.Type__c = 'Technical Design';
        workTask3.Status__c = 'New';
        workTask3.Requirement__c = requirement.Id;
        workTask3.Start_Date__c = datetime.newInstance(2008, 12, 5, 12,30, 2);
        workTask3.End_Date__c = datetime.newInstance(2008, 12, 6, 12,30, 2);
        insert workTask3;
        
        Work_Task__c workTask4 = new Work_Task__c();
        workTask4.Task_Summary__c = 'Work Task Test 4';
        workTask4.Estimate_Hours__c = 6;
        workTask4.Type__c = 'Configuration';
        workTask4.Status__c = 'New';
        workTask4.Requirement__c = requirement.Id;
        workTask4.Start_Date__c = datetime.newInstance(2008, 12, 7, 12,30, 2);
        workTask4.End_Date__c = datetime.newInstance(2008, 12, 8, 12,30, 2);
        insert workTask4;
        
        Work_Task__c workTask5 = new Work_Task__c();
        workTask5.Task_Summary__c = 'Work Task Test 5';
        workTask5.Estimate_Hours__c = 6;
        workTask5.Type__c = 'Development';
        workTask5.Status__c = 'New';
        workTask5.Requirement__c = requirement.Id;
        workTask5.Start_Date__c = datetime.newInstance(2008, 12, 11, 12,30, 2);
        workTask5.End_Date__c = datetime.newInstance(2008, 12, 12, 12,30, 2);
        insert workTask5;
        
        Work_Task__c workTask6 = new Work_Task__c();
        workTask6.Task_Summary__c = 'Work Task Test 6';
        workTask6.Estimate_Hours__c = 6;
        workTask6.Type__c = 'Other';
        workTask6.Status__c = 'New';
        workTask6.Requirement__c = requirement.Id;
        workTask6.Start_Date__c = datetime.newInstance(2008, 12, 13, 12,30, 2);
        workTask6.End_Date__c = datetime.newInstance(2008, 12, 14, 12,30, 2);
        insert workTask6;
        
        //Constructor
        RequirementCalendarController controller = new RequirementCalendarController();
        
        ApexPages.StandardController sController = new ApexPages.StandardController(requirement);
        RequirementCalendarController requirementController = new RequirementCalendarController(sController);
        RequirementCalendarController requirementController1 = new RequirementCalendarController();
        
        //Method
        requirementController.getworkTaskEventList();
        RequirementCalendarController.WorkTaskEvent event = new RequirementCalendarController.WorkTaskEvent();
        event.setallDay(false);
        event.setbackgroundColor('red');
        event.setborderColor('red');
        event.setclassName('red');
        event.setcolor('red');
        event.seteditable(false);
        event.setenddate('red');
        event.setestimateHours('1');
        event.setId('red');
        event.setrequirementId('red');
        event.setrequirementType('red');
        event.setstart('red');
        event.settextColor('red');
        event.setTitle('red');
        event.seturl('red');
        Boolean tempBool = event.getallDay();
        String tempString = event.getbackgroundColor();
        tempString = event.getborderColor();
        tempString =  event.getclassName();
        tempString = event.getcolor();
        tempBool = event.geteditable();
        tempString = event.getenddate();
        tempString = event.getestimateHours();
        tempString = event.getId();
        tempString = event.getrequirementId();
        tempString = event.getrequirementType();
        tempString = event.getstart();
        tempString = event.gettextColor();
        tempString = event.getTitle();
        tempString = event.geturl();
        
        requirementController1.geteventLsitString();
        requirementController1.seteventLsitString('red');
        requirementController1.getEventListFromRequirementJS();
        //Test.startTest();
        //Test.stopTest();   
     }
}