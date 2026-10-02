public class FormFieldController {
	
	public Form_Field__c field {get;set;}
	public List<SelectOption> picklistSelectOptions;
	
	//CONSTRUCTOR
	public FormFieldController() {

	}

	public List<SelectOption> getPicklistSelectOptions() {
		//if this is a picklist field, set up the selectoptions for the drop down that needs to be rendered
		if(field.Type__c == 'PICKLIST' && field.PicklistEntries__c != null) {
			picklistSelectOptions = new List<SelectOption>();
			String[] values = field.PicklistEntries__c.split(',' , 0);
			for(String s:values) {
				SelectOption so = new SelectOption(s,s);
				picklistSelectOptions.add(so);
			}
		}
		return picklistSelectOptions;
	}
	
	
	//** TEST METHODS **/
	public static testMethod void t1() {
		FormFieldController controller = new FormFieldController();
		Form_Field__c field = new Form_Field__c();
		field.PicklistEntries__c = 'a,b,c';
		field.Type__c = 'PICKLIST';
		controller.field = field;
		List<SelectOption> selectlist = controller.getPicklistSelectOptions();
		System.assertEquals(3, selectlist.size());
	}

}