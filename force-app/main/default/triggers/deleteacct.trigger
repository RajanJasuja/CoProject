trigger deleteacct on Account (before delete) {
        Account[] co=Trigger.old;
        for (Account ac : [Select Id,COE_Synchronised_Flag__c from Account where Id=:co[0].Id])
        {
        if (ac.COE_Synchronised_Flag__c==true)
        {
        //do nothing
        }
        else
        {
        Trigger.old[0].addError('can\'t delete this account.');
        }

        }//end main for

}