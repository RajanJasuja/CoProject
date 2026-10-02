public class AccountsController {
  @AuraEnabled
  public static List<Account> getAccounts() {
    return [SELECT Id, name, industry, Type, NumberOfEmployees, TickerSymbol, Phone
    FROM Account ORDER BY createdDate ASC Limit 50];
  }

  @AuraEnabled
  public static List<Account> getAccountDetailsByName(String accountName) {
    if (String.isBlank(accountName)) {
      return new List<Account>();
    }

    String trimmedName = accountName.trim();

    return [SELECT Id, Name, Industry, Type, NumberOfEmployees, TickerSymbol, Phone
            FROM Account
            WHERE Name = :trimmedName
            ORDER BY Name];
  }
}