trigger TestLeadInsert on Lead (before insert) {

Property__c p=[Select Street_Address__c from Property__c];

 for (Lead ld: Trigger.New)     
    {    
    
        ld.company=p.Street_Address__c;
    
    }

}