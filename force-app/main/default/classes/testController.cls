public class testController 
{
public List<Task> taskList;
Account account;
List<Contact> contact;

public String getName() {return 'testController';}

public Account getAccount() 
{
if(account == null)account = [select id, name from Account  where id = :System.currentPageReference().getParameters().get('id')];
return account;
}

public List<Contact> getContact() 
{
if(contact == null)contact = [select id, name from contact where accountid = :System.currentPageReference().getParameters().get('id')];
return contact;
}

public PageReference setTask()
{
System.debug('inside setTask :'+System.currentPageReference().getParameters().get('cid'));
taskList=null;
taskList = [select id, subject, status from Task where whoid = :System.currentPageReference().getParameters().get('cid')];
return null;
}

public void sayHello()
{
System.debug('Hello Dear, How r u?');
}
public List<Task> getTaskList() 
{
System.debug('inside getTaskList');
//taskList = null;
//taskList = [select id, subject, status from Task where whoid = :System.currentPageReference().getParameters().get('cid')];
return taskList;
}
 
}