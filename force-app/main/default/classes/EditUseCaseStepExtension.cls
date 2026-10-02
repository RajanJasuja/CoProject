public with sharing class EditUseCaseStepExtension {
	
	//---------- For use case object ------------------------------	
	Use_Case__c useCaseObj;

	//---------- For all test case steps ---------------------------
    list<useCaseWrapper> useCaseStepList = new list<useCaseWrapper>();    
	//---------- Store selected use cass steps ----------------------- 
    list<Use_Case_Step__c> selectedUseCaseSteps = new list<Use_Case_Step__c>();
    //---------- Store use case steps to be removed---------------------	
    list<Use_Case_Step__c> removeUseCaseStepList = new list<Use_Case_Step__c>();
    //---------- Store use case steps that to be updated-----------------------
	list<Use_Case_Step__c> updateUseCaseStepList = new list<Use_Case_Step__c> ();    
    
    //---------- flag to indicate duplicate or zero step number found----------------- 
    boolean flag = false ;
    //---------- For new use case step---------------------------------------
    public Use_Case_Step__c newUseCaseStep { get; set; } 
       
    list<Use_Case_Step__c> tempList = new list<Use_Case_Step__c>();	
    
    //----------Constructor -------------------------------------------
    public EditUseCaseStepExtension (ApexPages.StandardController controller) {
		useCaseObj=(Use_Case__c)controller.getRecord();
		newUseCaseStep = new Use_Case_Step__c();
    }

	//---------- Use Case Step Add/Remove -------------------------------------------
    public list<useCaseWrapper> getUseCaseSteps()
    {   
        useCaseStepList.clear();
        //useCaseSteps.clear();
        for(Use_Case_Step__c a : [select Id , Step_Number__c ,Step_Description__c ,Expected_Result__c ,Use_Case__c from Use_Case_Step__c where  
            Use_Case__c= :useCaseObj.Id order by Step_Number__c]){
        	useCaseStepList.add(new useCaseWrapper(a));
        	//useCaseSteps.add(a);
        }
        return useCaseStepList;
    }
    
    //---------- Get Selected Use Case Steps-------------------------
    public PageReference getSelected()
    {
        selectedUseCaseSteps.clear();
        for(useCaseWrapper useCsWrTemp : useCaseStepList )
        	if(useCsWrTemp.selected == true)
        		selectedUseCaseSteps.add(useCsWrTemp.useCsWr);
        return null;
    }
    
    //---------- Class useCaseWrapper, wraps Use Case object and boolean selected------
    public class useCaseWrapper
    {
        public Use_Case_Step__c useCsWr{get; set;}
        public boolean selected {get; set;}
        public useCaseWrapper(Use_Case_Step__c useCaseStep)
        {
            useCsWr = useCaseStep;
            selected = false;
        }
    }
    
    //---------- Add new Use Case Step ----------------------------------------------------
     public PageReference addUseCaseStep() {
		if(newUseCaseStep.Step_Number__c==0)
		{
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Step Number should not be zero.'));
			return null;
		}
		else if(duplicateStepNumber_AddClick()){
			ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Step Number already exists.'));
			return null;
        }
        else {
            Use_Case_Step__c newUCS = new Use_Case_Step__c();
            newUCS.Step_Number__c = newUseCaseStep.Step_Number__c;
            newUCS.Step_Description__c = newUseCaseStep.Step_Description__c;
            newUCS.Expected_Result__c = newUseCaseStep.Expected_Result__c;
            newUCS.Use_Case__c= useCaseObj.Id;
            insert newUCS;
            newUseCaseStep.Step_Number__c = newUseCaseStep.Step_Number__c!=null?newUseCaseStep.Step_Number__c+1:1;
            newUseCaseStep.Step_Description__c = null;
            newUseCaseStep.Expected_Result__c = null;
            return null;
        }
    }
  
    
    //--------------------------------- Remove Selected UseCaseStep Record ---------------------------------------
	public pagereference removeUseCaseStep() {
		//system.debug('--Remove Called.--');
       	for(useCaseWrapper useCsWrTemp : useCaseStepList){
        	if(useCsWrTemp.selected == true)
        		removeUseCaseStepList.add(useCsWrTemp.useCsWr);
       	}
		delete  removeUseCaseStepList;
		removeUseCaseStepList.clear();
		return null;

    }
        
        
//--------------------------------- Update Selected Use Case Step ---------------------------------------
    
	
	public PageReference updateUseCaseStep() {
		
		if(zeroStepNumber()){
     		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Step Value should not be zero.'));
     		return null;
     	}
     	else if (duplicateStepNumber()){
     		ApexPages.addmessage(new ApexPages.message(ApexPages.severity.ERROR,'Step Value should not be duplicate.'));
     		return null;
     	}
     	else { 
     		system.debug('useCaseStepList-->>'+useCaseStepList);
    		for(useCaseWrapper useCsWrTemp : useCaseStepList)
        		if(useCsWrTemp.selected == true)
					updateUseCaseStepList.add(useCsWrTemp.useCsWr);
        	update updateUseCaseStepList;
        	system.debug('updateUseCaseStepList-->>'+updateUseCaseStepList);
        	updateUseCaseStepList.clear();
        	return null;
     	}
	}


//--------------------------------- Supporting Methods -------------------------------- 
//------Check if Step Number is zero-----------------------   
    public boolean zeroStepNumber(){
    	tempList.clear(); 
    	flag = false;
     	for(useCaseWrapper useCsWrTemp : useCaseStepList){
    		if(useCsWrTemp.useCsWr.step_Number__c == 0){
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
		for(useCaseWrapper useCsWrTemp : useCaseStepList)
        	tempList.add(useCsWrTemp.useCsWr);
     	
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
		for(useCaseWrapper useCsWrTemp : useCaseStepList)
		    tempList.add(useCsWrTemp.useCsWr);
		//system.debug('eeeeeeeeeeeeeeeeeeeee>' +tempList);
		for(Integer i = 0 ; i< tempList.size();i++)
		{
		    //system.debug('cccccccccccccccccc>' +tempList[i].step_number__c);
		    //system.debug('ddddddddddddddddddddddd>' +newUseCaseStep.step_number__c);
		    if(tempList[i].step_number__c==newUseCaseStep.step_number__c){
				flag = true;
				break;
		    }
		 }
		return flag;
    }
       
}