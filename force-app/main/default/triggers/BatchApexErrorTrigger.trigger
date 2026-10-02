trigger BatchApexErrorTrigger on BatchApexErrorEvent (after insert) {
    
    List<BatchLeadConvertErrors__c> errorDetial=new List<BatchLeadConvertErrors__c>();
    for(BatchApexErrorEvent sob:Trigger.new){
        
        BatchLeadConvertErrors__c objError=new BatchLeadConvertErrors__c();
        objError.AsyncApexJobId__c=sob.AsyncApexJobId;
        objError.Records__c=sob.JobScope;
        objError.StackTrace__c=sob.StackTrace;
        errorDetial.add(objError);
	}
     insert errorDetial;
    
}