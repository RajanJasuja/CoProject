trigger emialToCaseCreateContact on Case (Before insert) {

List<Account> a=new List<Account>();
Map<String,case> caseMap=new Map<String,Case>();
Map<String,Contact> ContactMap=new Map<String,Contact>();
List<Contact> newContactsList=new List<Contact>(); 

System.debug('Emial to case executed');

/*Try
{

for(case c:Trigger.new)
{
    System.debug('Rajan123 c.ContactID'+c.ContactID);
}
*/    



for(case c:Trigger.new)
{



    if(c.Origin=='Email' && c.ContactID==null)
    {
    System.debug('Rajan2');
    
        if(a!=null && a.size()<1)
        {
        System.debug('HiRajan3');
        
            a=[Select Id from account where name='Emial to case account' limit 1];
        
            if(a.size()<1)
            {
             Account  newEmialAccount=new Account(name='Emial to case account');
             insert newEmialAccount;
             a.add(newEmialAccount);
            }
        }
               
        Contact newContact=new Contact();
        newContact.AccountId=a[0].id;
        c.AccountId=a[0].id;
        System.debug('Rajan3');
        if(c.SuppliedName!=null)
        {
            System.debug('Rajan4');
            List<String> FLname=c.SuppliedName.split(' ');
            if(FLname.Size()>1)
            {
                newContact.FirstName=FLname[0];
                newContact.LastName=FLname[1];

            }
            If(FLname.Size()==1)
            {
                newContact.FirstName=FLname[0];
            }    
            
        }
        System.debug('Rajan5');
        if(c.SuppliedEmail!=null) newContact.Email=c.SuppliedEmail;
        if(c.SuppliedPhone!=null) newContact.Phone=c.SuppliedPhone;
        caseMap.put(c.SuppliedEmail,c);
        newContactsList.add(newContact);
        System.debug('Rajan6');
     }
}//For loop 

    System.debug('Rajan7 +newContactsList:'+newContactsList);
    if (newContactsList!=null)
    {
     insert newContactsList;
     
     for(Contact newCaseContact:newContactsList) 
     {
         if(caseMap.get(newCaseContact.Email)!=null) caseMap.get(newCaseContact.Email).ContactID=newCaseContact.id;
     }
     
    System.debug('Rajan8');

    } 
/*}

catch(Exception e)
{
    CustomLog__c CL=New CustomLog__c(CustomError__c=' '+e);
    insert CL;
}


*/

}