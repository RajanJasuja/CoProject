// CustomerProfileController.cls
public with sharing class CustomerProfileController {
    
    @AuraEnabled(cacheable=true)
    public static List<Account_Field_Display__mdt> getFieldDisplayMetadata() {
        try {
            // Query Custom Metadata Type records
            List<Account_Field_Display__mdt> fieldDisplaySettings = [
                SELECT API_Name__c, 
                       MasterLabel, 
                       Icon_Name__c, 
                       Section__c, 
                       Order__c, 
                       Hide_If_Blank__c,
                       Max_Value__c, 
                       Format__c, 
                       Active__c
                FROM Account_Field_Display__mdt
                WHERE Active__c = TRUE
                ORDER BY Order__c NULLS LAST
            ];
            
            return fieldDisplaySettings;
            
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching metadata configuration: ' + e.getMessage());
        }
    }
    
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> getAccountData(Id accountId, List<String> fieldApiNames) {
        try {
            // Validate input
            if (accountId == null) {
                throw new AuraHandledException('Account ID is required');
            }
            
            // Build dynamic query
            Set<String> fieldsToQuery = new Set<String>{'Id', 'Name'};
            
            // Add custom fields from metadata
            if (fieldApiNames != null && !fieldApiNames.isEmpty()) {
                fieldsToQuery.addAll(fieldApiNames);
            }
            
            // Always try to include common fields if they exist
            Schema.DescribeFieldResult fieldResult;
            Map<String, Schema.SObjectField> fieldMap = Schema.SObjectType.Account.fields.getMap();
            
            // Check if PhotoUrl field exists (might be custom)
            if (fieldMap.containsKey('PhotoUrl')) {
                fieldsToQuery.add('PhotoUrl');
            }
            
            // Check for common address fields
            if (fieldMap.containsKey('BillingStreet')) {
                fieldsToQuery.add('BillingStreet');
                fieldsToQuery.add('BillingCity');
                fieldsToQuery.add('BillingState');
                fieldsToQuery.add('BillingPostalCode');
                fieldsToQuery.add('BillingCountry');
            }
            
            String queryString = 'SELECT ' + String.join(new List<String>(fieldsToQuery), ', ') + 
                                ' FROM Account WHERE Id = :accountId LIMIT 1';
            
            List<Account> accounts = Database.query(queryString);
            
            if (accounts.isEmpty()) {
                throw new AuraHandledException('Account not found');
            }
            
            // Convert to map for easier consumption in LWC
            Map<String, Object> result = new Map<String, Object>();
            Account acc = accounts[0];
            
            for (String field : fieldsToQuery) {
                try {
                    result.put(field, acc.get(field));
                } catch (Exception e) {
                    // Field might not exist or be accessible
                    System.debug('Could not get field value for: ' + field);
                }
            }
            
            return result;
            
        } catch (Exception e) {
            throw new AuraHandledException('Error fetching account data: ' + e.getMessage());
        }
    }
}