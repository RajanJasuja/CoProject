public with sharing class AccountProfileCtrl {
    public class FieldMeta {
        @AuraEnabled public String apiName;
        @AuraEnabled public String label;
        @AuraEnabled public String iconName;
        @AuraEnabled public String section;
        @AuraEnabled public Integer order;
        @AuraEnabled public Boolean hideIfBlank;
        @AuraEnabled public Decimal maxValue;
        @AuraEnabled public String format;
        @AuraEnabled public Boolean active;
    }

    @AuraEnabled(cacheable=true)
    public static List<FieldMeta> getFieldMetadata() {
        List<FieldMeta> out = new List<FieldMeta>();
        for (Account_Field_Display__mdt m : [
            SELECT API_Name__c, MasterLabel, Icon_Name__c, Section__c, Order__c, Hide_If_Blank__c,
                   Max_Value__c, Format__c, Active__c
            FROM Account_Field_Display__mdt
            WHERE Active__c = TRUE
            ORDER BY Order__c NULLS LAST
        ]) {
            FieldMeta fm = new FieldMeta();
            fm.apiName    = m.API_Name__c;
            fm.label      = m.MasterLabel;
            fm.iconName   = m.Icon_Name__c;
            fm.section    = m.Section__c;
            fm.order      = (Integer)m.Order__c;
            fm.hideIfBlank= m.Hide_If_Blank__c;
            fm.maxValue   = m.Max_Value__c;
            fm.format     = m.Format__c;
            fm.active     = m.Active__c;
            out.add(fm);
        }
        return out;
    }
}