public with sharing class actionfunctiontestcontroller {

    public string termId{get;set;}
    public PageReference CallHostList() {
        system.debug('Value of termId='+termId);
        return null;  
    }

}