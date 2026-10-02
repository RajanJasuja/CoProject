public class ExtensionAccount
{

public Account accObj{get; set;}
public ExtensionAccount(ApexPages.StandardController controller) {
accObj=(Account)controller.getRecord();
}



}