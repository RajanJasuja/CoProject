public class LeadViewController {
    
    private List<SelectOption> leadFields = new List<SelectOption>();
    private List<SelectOption> operatorValues = new List<SelectOption>();
        
    public String selectedField1{set; get;}
    public String selectedOperator1{set; get;}
    public String filterValue1{set; get;}
    
    public String selectedField2{set; get;}
    public String selectedOperator2{set; get;}
    public String filterValue2{set; get;}
    
    public String selectedField3{set; get;}
    public String selectedOperator3{set; get;}
    public String filterValue3{set; get;}
    
    public String selectedField4{set; get;}
    public String selectedOperator4{set; get;}
    public String filterValue4{set; get;}
    
    public String selectedField5{set; get;}
    public String selectedOperator5{set; get;}
    public String filterValue5{set; get;}
    
    public LeadViewController(){
        Map<String, Schema.SObjectField> leadFieldMap = Schema.getGlobalDescribe().get( 'Lead' ).getDescribe().fields.getMap();
        leadFields.add(new SelectOption('None', '--None--'));
        for(String fieldName : leadFieldMap.keySet()){
            Schema.DescribeFieldResult field = leadFieldMap.get(fieldName).getDescribe();
            leadFields.add(new SelectOption((field.getLocalName() + '_' + field.getType()), field.getLabel()));
        }
        initializeOpertaorValues();
    }
    
    public List<SelectOption> getLeadFields(){
        return leadFields;
    }
    
    public List<SelectOption> getOperatorValues(){
        return operatorValues;
    }
    
    private void initializeOpertaorValues(){
                operatorValues.add(new SelectOption('', '--None--'));
                operatorValues.add(new SelectOption('e', 'equals'));
                operatorValues.add(new SelectOption('n', 'not equal to'));
                operatorValues.add(new SelectOption('s', 'starts with'));
                operatorValues.add(new SelectOption('c', 'contains'));
                operatorValues.add(new SelectOption('k', 'does not contain'));
                operatorValues.add(new SelectOption('l', 'less than'));
                operatorValues.add(new SelectOption('g', 'greater than'));
                operatorValues.add(new SelectOption('m', 'less or equal'));
                operatorValues.add(new SelectOption('h', 'greater or equal'));
                operatorValues.add(new SelectOption('u', 'includes'));
                operatorValues.add(new SelectOption('x', 'excludes'));          
    }
    
}