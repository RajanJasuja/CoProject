trigger setUFlag on Account (after update) {
    System.debug('Rajan Jasujs11');
    Account[] acc1=Trigger.new;
    System.debug('Rajan Jasujs 22--'+acc1[0].Submitted_By_User_ID__c);
    System.debug('Rajan Jasujs 33--'+String.valueOf(UserInfo.getUserId()).substring(0, 15));
    
    if(acc1[0].Submitted_By_User_ID__c==String.valueOf(UserInfo.getUserId()).substring(0, 15) && acc1[0].Is_Approved__c==true )
    {
        acc1[0].addError('Invalid approval, you can not approve your own load.');

    }
    

    

}