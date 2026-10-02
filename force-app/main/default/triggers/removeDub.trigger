trigger removeDub on TestObject__c (before insert) {
lib l=new lib();
l.createList();

}