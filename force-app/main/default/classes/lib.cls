public class lib
{

List<Account> a; 


    public void createList()
    {
        a=[select name from Account Limit 10];
        List<Account> aa=[select name from Account Limit 10];
         
            for(Account n:aa)
                a.add(n); 
                
               List<Account> deDuplicate=removeDuplicate(a);
               //List<Account> deDuplicate=a;
               if(!deDuplicate.isEmpty()) update deDuplicate;   
    }    
    
    public List<Account> removeDuplicate(List<Account> dubValues)
    {
        Map<Id,Account> checkMap=new Map<Id,Account>();
        List<Account> newList=new List<Account>();
        
        for(Account account:dubValues)
        {
            if(!checkMap.containsKey(account.Id))
            {
                checkMap.put(account.Id,account);
                newList.add(account);
            }
            
        }
                
        return newList; 
           
             
    } 

    
       
}