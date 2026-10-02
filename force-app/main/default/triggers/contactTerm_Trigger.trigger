trigger contactTerm_Trigger on Account (after update) {

Opportunity opp=[Select Id,Test__c from Opportunity where AccountId=:Trigger.New[0].Id limit 1];
System.Debug('Rajan Test'+opp); 

}