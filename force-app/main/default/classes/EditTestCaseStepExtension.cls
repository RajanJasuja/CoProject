/*
Extension class for EditTestCaseStep page
*/
public with sharing class EditTestCaseStepExtension {
	//---------- For test case object ------------------------------
	Test_Case__c testCaseObj;
	//---------- For all test case steps ---------------------------
    list<testCaseWrapper> testCaseStepList = new list<testCaseWrapper>();   
    //---------- Store selected test cass steps ----------------------- 
    list<Test_Case_Step__c> selectedTestCaseSteps = new list<Test_Case_Step__c>();	
    //---------- Store test case steps to be removed---------------------
    list<Test_Case_Step__c> removeTestCaseStepList = new list<Test_Case_Step__c>();
    //---------- Store test case steps that to be updated-----------------------
	list<Test_Case_Step__c> updateTestCaseStepList = new list<Test_Case_Step__c> (); 
	
	   
    list<Test_Case_Step__c> tempList = new list<Test_Case_Step__c>();	
    
    //---------- flag to indicate duplicate or zero step number found-----------------
    boolean flag = false ;     
    
    //---------- For new test case step---------------------------------------
    public Test_Case_Step__c newTestCaseStep{ get; set; } 
    
    //----------Constructor -------------------------------------------
    public EditTestCaseStepExtension (ApexPages.StandardController controller) {
		testCaseObj=(Test_Case__c)controller.getRecord();
		newTestCaseStep = new Test_Case_Step__c();
    }

	//---------- Test Case Step Add/Remove -------------------------------------------
    public list<testCaseWrapper> getTestCaseSteps()
    {   
        testCaseStepList.clear();
        for(Test_Case_Step__c a : [select Id , Step_Number__c ,Step_Description__c ,Expected_Result__c ,Test_Case__c from Test_Case_Step__c where  
            Test_Case__c= :testCaseObj.Id order by Step_Number__c])
        testCaseStepList.add(new testCaseWrapper(a));
        return testCaseStepList;
    }
    
    //---------- Get Selected Test Case Steps-------------------------
    public PageReference getSelected()
    {
        selectedTestCaseSteps.clear();
        for(testCaseWrapper testCsWrTemp : testCaseStepList )
        	if(testCsWrTemp.selected == true)
        		selectedTestCaseSteps.add(testCsWrTemp.testCsWr);
        return null;
    }
    
    //---------- Class testCaseWrapper, wraps Test Case object and boolean selected------
    public class testCaseWrapper
    {
        public Test_Case_Step__c testCsWr{get; set;}
        public boolean selected {get; set;}
        public testCaseWrapper(Test_Case_Step__c testCaseStep)
        {
            testCsWr = testCaseStep;
            selected = false;
        }
    }
    
    //---------- Add new Test Case Step ----------------------------------------------------    
     public PageReference addTestCaseStep() {
		if(newTestCaseStep.Step_Number__c==0)
		{
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Step Number should not be zero.'));
			return null;
		}
		else if(duplicateStepNumber_AddClick()){
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Step Number already exists.'));
			return null;
        }
        else {
            Test_Case_Step__c newTCS = new Test_Case_Step__c();
            newTCS.Step_Number__c = newTestCaseStep.Step_Number__c;
            newTCS.Step_Description__c = newTestCaseStep.Step_Description__c;
            newTCS.Expected_Result__c = newTestCaseStep.Expected_Result__c;
            newTCS.Test_Case__c= testCaseObj.Id;
            insert newTCS;
            newTestCaseStep.Step_Number__c = newTestCaseStep.Step_Number__c!=null?newTestCaseStep.Step_Number__c+1:1;
            newTestCaseStep.Step_Description__c = null;
            newTestCaseStep.Expected_Result__c = null;
            return null;
        }
    }
  
    
    //--------------------------------- Remove Selected TestCaseStep Record ---------------------------------------
	public pagereference removeTestCaseStep() {
		//system.debug('--Remove Called.--');
       	for(testCaseWrapper testCsWrTemp : testCaseStepList){
        	if(testCsWrTemp.selected == true)
        		removeTestCaseStepList.add(testCsWrTemp.testCsWr);
       	}
		delete  removeTestCaseStepList;
		removeTestCaseStepList.clear();
		return null;

    }
        
        
//--------------------------------- Update Selected Test Case Step ---------------------------------------
    
	
	public PageReference updateTestCaseStep() {
		
		if(zeroStepNumber()){
     		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Step Value should not be zero.'));
     		return null;
     	}
     	else if (duplicateStepNumber()){
     		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Step Value should not be duplicate.'));
     		return null;
     	}
     	else { 
     		//system.debug('testCaseStepList-->>'+testCaseStepList);
    		for(testCaseWrapper testCsWrTemp : testCaseStepList)
        		if(testCsWrTemp.selected == true)
					updateTestCaseStepList.add(testCsWrTemp.testCsWr);
        	update updateTestCaseStepList;
        	//system.debug('updateTestCaseStepList-->>'+updateTestCaseStepList);
        	updateTestCaseStepList.clear();
        	return null;
     	}
	}


//--------------------------------- Supporting Methods --------------------------------    
    public boolean zeroStepNumber(){
    	tempList.clear(); 
    	flag = false;
     	for(testCaseWrapper testCsWrTemp : testCaseStepList){
    		if(testCsWrTemp.testCsWr.step_Number__c == 0){
    			flag = true;
    			break;
    		}
    	}
    	return flag;
    }
   
//------Check Duplicate Step Number-----------------------
	public boolean duplicateStepNumber() {
		tempList.clear();
		flag = false;
		for(testCaseWrapper testCsWrTemp : testCaseStepList)
        	tempList.add(testCsWrTemp.testCsWr);
     	
    	for(Integer i = 0 ; i< tempList.size();i++){
    		for(Integer j = i+1 ; j< tempList.size();j++){
         		if(tempList[i].step_number__c==tempList[j].step_number__c)
         			flag = true;
         			break;
     		}
    	}		
		return flag;
   }
   
   	//----------Check Duplicate Step Number-----------------------
    public boolean duplicateStepNumber_AddClick(){
    	tempList.clear();
		flag = false;
		for(testCaseWrapper testCsWrTemp : testCaseStepList)
		    tempList.add(testCsWrTemp.testCsWr);
		//system.debug('eeeeeeeeeeeeeeeeeeeee>' +tempList);
		for(Integer i = 0 ; i< tempList.size();i++)
		{
		    //system.debug('cccccccccccccccccc>' +tempList[i].step_number__c);
		    //system.debug('ddddddddddddddddddddddd>' +newTestCaseStep.step_number__c);
		    if(tempList[i].step_number__c==newTestCaseStep.step_number__c){
				flag = true;
				break;
		    }
		 }
		return flag;
    }
       
}