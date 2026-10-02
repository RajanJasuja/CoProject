public class WebFormEditorController {


	//Web Form
	public Web_Form__c webform {get;set;}
	//Map that holds all the object names and tokens in your org
	Map<String, Schema.SObjectType> gd;
	//List with just these tokens
	public List<SObjectType> tokens = new List<SObjectType>();
	public List<String> objectlabels {get;set;}
	public List<SelectOption> objectSelectOptions {get;set;}
	public SObjectType sot {get;set;} //holds the selected object's token
	public String selectedObject {get;set;} //holds the name of the selected SObject, bound to the SelectList
	public String selectedObjectLabel {get;set;} //holds the label of the selected SObject

	//List to hold the selected object's field information, based on the Form_Field__c custom object
	public List<Form_Field__c> objectFields {get;set;}
	//List to hold the selected form fields information
	public List<Form_Field__c> formFields {get;set;}
	//Counter that keeps track of the number of CUSTOMTEXT fields.
	public Integer nrcustomtextfields = 0;


	//CONSTRUCTOR
	public WebFormEditorController(ApexPages.StandardController stdController) {
		//get a full list of all objecttokens
        gd = Schema.getGlobalDescribe();
        
        tokens = gd.values(); //get the tokens from this map
        objectlabels = new List<String>();
        objectSelectOptions = new List<SelectOption>();
        //get the tokens from the global describe map and drop their names and labels in the drop down list
        
        for(SObjectType s:gd.values()) {
        	//don't add all objects to the list (there's a lot of internal objects that user's don't need or can use)
        	//System.debug(' **************************** ' + s.getDescribe().getName() + ' ** ' + s.getDescribe().getLabel());
        	if(!acceptedObject(s)) continue;
        	
        	objectlabels.add(s.getDescribe().getLabel());
        	SelectOption so = new SelectOption(s.getDescribe().getName(), s.getDescribe().getLabel());
        	objectSelectOptions.add(so);
        }
        //initialize the formFields & objectFields lists
        formFields = new List<Form_Field__c>();
        objectFields = new List<Form_Field__c>();
        
        //get the existing webform if there's an id in the url, or create a new one if not
        String webformid = System.currentPageReference().getParameters().get('id');
        //we're editing an existing one
        if(webformid != null) {
			//get the web form
        	webform = [select Id, Name, Object_Name__c, Object_Label__c, Return_URL__c, Description__c, Title__c, Background_Color__c, Save_Button_Text__c, Text_Color__c from Web_Form__c where Id = :webformid];        	
        	//get the object fields
        	selectedObject = webform.Object_Name__c;
        	selectObject();
        	//get the form fields
        	formFields = [Select f.Web_Form__c, f.Type__c, f.Required__c, f.PicklistEntries__c, f.Order__c, f.Name, f.Label__c, f.Width__c, f.Id From Form_Field__c f where f.Web_Form__c = :webform.Id order by f.Order__c];
			//and remove the fields already in the form from the object fields. No use in putting them on the form twice
			for(Form_Field__c formfield:formFields) {
				//count the custom text fields. Gotta keep those names unique
				if(formfield.Type__c == 'CUSTOMTEXT') nrcustomtextfields++;
				for(Integer i = 0; i < objectFields.size();i ++) {
					Form_Field__c objectField = objectFields.get(i);
					if(formField.Name == objectField.Name) objectFields.remove(i);
				}
			}			       	
        }
        //create a new webform if no id is passed in the url
        else {
        	webform = new Web_Form__c();
        	webform.Background_Color__c = '#FFFFFF';
        	webform.Text_Color__c = '#000000';
        	webform.Save_Button_Text__c = 'Save';
        }
	}

	//let's make this an extension -> allows to use this as an extension on the standardcontroller
	//public WebFormEditorController(ApexPages.StandardController stdController) {
	//	this(); //call the original constructor.
	//}	
	
	//When an object is selected, get all the fields
	public PageReference selectObject() {
		//find out which object got selected    	
    	sot = gd.get(selectedObject);
    	//drop it's label in the selected object field, for display purposes
    	selectedObjectLabel = sot.getDescribe().getLabel();
    	webform.Object_Name__c = sot.getDescribe().getName();
    	webform.Object_Label__c = sot.getDescribe().getLabel();
    	
    	//if a new object gets selected clear all field lists
    	objectFields.clear();
    	formFields.clear();
    	
    	//get the field tokens map
    	Map<String, SObjectField> fields = sot.getDescribe().fields.getMap();
    	//and drop those tokens in a List
    	List<SObjectField> fieldtokens = fields.values();

    	objectfields = new List<Form_Field__c>();

    	for(SObjectField fieldtoken:fieldtokens) {
        	DescribeFieldResult dfr = fieldtoken.getDescribe();
        	
        	//skip fields we can't create anyway, or system fields
        	if(!dfr.isCreateable()) continue; // || dfr.isDefaultedOnCreate()
        	if((dfr.getName() == 'CreatedDate') || (dfr.getName() == 'LastModifiedDate')) continue;
        	//No REFERENCE FIELDS (for the time being)
        	if(dfr.getType().name() == 'REFERENCE') continue;
        	//Next 2 lines handle the 'required' flag in the web form editor. We just want to exclude this flag for booleans since they always show up as not nillable
        	Boolean required;
        	if(!(dfr.getType().name() == 'BOOLEAN')) required = !dfr.isNillable(); //Booleans are always 'isNillable = false' but it doesn't matter since any boolean will always have a value of true or false. Let's not show that to the user. It's confusing
        	//handle picklist fields -- moved this to the addfield method. If we do it here we hit the 'to many picklist describes' when more then 10 picklist fields
        	//String picklistvalues = '';
        	//if(dfr.getType().name() == 'PICKLIST') {
        	//	List<PicklistEntry> entries = dfr.getPicklistValues();
        		//loop over the found values and add them to the picklistvalues string, comma separated
        	//	for(Integer i=0; i < entries.size();i++) {
        	//		PicklistEntry pe = entries.get(i);
        	//		picklistvalues = picklistvalues + pe.getValue();
        			//add a comment, except after the last values
        	//		if(i < entries.size()-1) picklistvalues += ',';
        	//	}
        	//}
        	
        	//instantiate the form field with all the values
        	Form_Field__c field = new Form_Field__c(Name = dfr.getName(), Label__c = dfr.getLabel(),Type__c = dfr.getType().name(), Required__c = required,Width__c = 250); //PicklistEntries__c = picklistvalues,
        	objectFields.add(field);
    	}
    	return null;
	}
	
	
	//adds an object's field to this web form
	public PageReference addField() {
		String fieldname = System.currentPageReference().getParameters().get('fieldname');
		System.debug('Adding field : ' + fieldname + ' from ' + selectedObject);
		//get the Form_Field__c that was selected and move it to the selected form fields list
		for(Integer i = 0; i < objectFields.size();i++) {
			Form_Field__c ff = objectFields.get(i);
			if(ff.Name == fieldname) {
				//if it's a picklist, go find the values and put them in the Form_Field__c
				DescribeFieldResult dfr = sot.getDescribe().fields.getMap().get(fieldname).getDescribe();
				String picklistvalues = '';
	        	if(dfr.getType().name() == 'PICKLIST') {
	        		List<PicklistEntry> entries = dfr.getPicklistValues();
	        		//loop over the found values and add them to the picklistvalues string, comma separated
	        		for(Integer j=0; j < entries.size();j++) {
	        			PicklistEntry pe = entries.get(j);
	        			picklistvalues = picklistvalues + pe.getValue();
	        			//add a comma, except after the last values
	        			if(j < entries.size()-1) picklistvalues += ',';
	        		}
	        	}
	        	//add the found picklist values to the form field
	        	Form_Field__c field = objectFields.remove(i);
	        	field.PicklistEntries__c = picklistvalues;
				//move the field over to the form fields
				formFields.add(field);
				break;
			}
		}		
		reOrderFormFields();
		return null;
	}
	
	//add a CUSTOMTEXT field in the form
	public PageReference addCustomField() {
		nrcustomtextfields++; //for keeping the name unique, needed for move up/down. These rely on the fieldname
		Form_Field__c f = new Form_Field__c(Name = 'CUSTOM Text'+nrcustomtextfields, Label__c = '* CUSTOM Text *', Type__c = 'CUSTOMTEXT', Width__c = 250);				
		formFields.add(f);
		reOrderFormFields();
		return null;
	}
	
	//remove an object's field from this web form
	public PageReference removeField() {
		String fieldname = System.currentPageReference().getParameters().get('fieldname');
		//get the Form_Field__c that was selected and move it to the object fields list
		for(Integer i = 0; i < formFields.size();i++) {
			Form_Field__c ff = formFields.get(i);
			//special case : custom text
			if(ff.Type__c == 'CUSTOMTEXT') {
				formFields.remove(i); 
				break;
			}
			//normal case : move the field back	
			if(ff.Name == fieldname) {
				objectFields.add(formFields.remove(i));
				break;
			}
		}
		reOrderFormFields();	
		return null;
	}
	
	
	//moves the selected field one up in the List
	public PageReference moveUp() {
		String fieldname = System.currentPageReference().getParameters().get('fieldname');
		//get the Form_Field__c that was selected and move it to the selected form fields list
		for(Integer i = 0; i < formFields.size();i++) {
			Form_Field__c ff = formFields.get(i);
			//normal case : move the field back	
			if(ff.Name == fieldname) {
				if(i == 0) return null;
				formFields.remove(i);
				formFields.add(i-1, ff);
				break;
			}
		}
		reOrderFormFields();
		return null;
	}
	
	//moves the selected field one down in the List
	public PageReference moveDown() {
		String fieldname = System.currentPageReference().getParameters().get('fieldname');
		//get the Form_Field__c that was selected and move it to the selected form fields list
		for(Integer i = 0; i < formFields.size();i++) {
			Form_Field__c ff = formFields.get(i);
			//normal case : move the field back	
			if(ff.Name == fieldname) {								
				formFields.remove(i);
				try {
					formFields.add(i+1, ff);
				}
				catch(Exception ex) {
					formFields.add(ff);
				}				
				break;
			}
		}
		reOrderFormFields();
		return null;
	}
	
	//save the webform and it's fields
	public PageReference save() {
		//if this page doesn't have all the needed info, stop right here
		if(!validate()) return null;
		
		try {
			//Save the web form		
			upsert webform;
			
			System.debug('ENTERING FORM FIELDS LOOP');
			for(Integer i = 0; i < formFields.size();i++) {
				Form_Field__c ff = formFields.get(i);
				if(ff.Web_Form__c == null) ff.Web_Form__c = webform.Id;				
			}
			upsert formfields;
			
			//and delete the form fields that are no longer in the List
			List<ID> formFieldIds = new List<ID>();
			for(Form_Field__c field:formFields) {
				formFieldIds.add(field.Id);				
			}
			List<Form_Field__c> todelete = [select Id from Form_Field__c where Web_Form__c =:webform.Id and Id not in :formFieldIds];
			delete todelete;
		}
		catch(Exception ex) {
			ApexPages.addMessages(ex);
		}
		return new PageReference('/'+webform.Id);		
	}
	
	//cancel, and return to the Web_Form__c tab
	//public PageReference cancel() {
	//	//get the key prefix for the Web_Form__c custom object
	//	String prefix = webform.getSObjectType().getDescribe().getKeyPrefix();
	//	return new PageReference('/'+prefix+'/o');
	//}


	//method that will recalculate the order of the form fields when one has been removed or order changed
	private void reOrderFormFields() {
		if(formFields.size() == 0) return;
		for(Integer i=0; i < formFields.size();i++) {
			Form_Field__c ff = formFields.get(i);
			ff.Order__c = i + 1;			
		}
	}
	
	//method that is a pseudo variable to return the formfields' size to the page, usefull for the up / down links
	public Integer getFormFieldsSize() {
		return formFields.size();
	}
	
	//validate the page on save
	private Boolean validate() {
		Boolean valid = true;
		
		if(webform.Object_Name__c == null) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select an object this form needs to fill'));
			valid = false;
		}
		if(formFields.size() == 0) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select fields for this form'));
			valid = false;
		}
		if(webform.Return_URL__c == null) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please select a return url for this form.'));
			valid = false;
		}
		//check if the user didn't forget any required fields
		for(Form_Field__c field:objectFields) {
			if(field.Required__c == true) {
				ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'Please add the required field '+field.Label__c+' to your form.'));
				valid = false;
			}
		}		
		return valid;
	}
	
	//method used to clean out all the internal objects we don't want the users to create
	public Boolean acceptedObject(SObjectType s) {
		DescribeSObjectResult r = s.getDescribe();
		//skip the non createable ones, standard or custom
        if(!r.isCreateable()) return false;
        //do not accept the web form and form fields themselves
        if(r.getName() == 'Web_Form__c' || r.getName() == 'Form_Field__c') return false;
        //other then that, we'll accepted all custom objects
        if(r.isCustom() && r.getName() != 'Test__c') return true;
                
        //we're left with just the standard objects, just accept the common ones.
        String acceptedobjects = 'Account Case Contact Lead Opportunity';
        if(acceptedobjects.contains(r.getName())) return true;        
        
		//everything else is denied
        return false;
	}
	
	
	//*************
	// TEST METHODS
	//*************
	public static testMethod void t1() {
		//* Construct the standard controller for Web_Form__c. *//
        ApexPages.StandardController stdcon = new ApexPages.StandardController(new Web_Form__c());
		
		WebFormEditorController controller = new WebFormEditorController(stdcon);
		//simulate an object select
		controller.selectedObject = 'Test__c';
		controller.selectObject();
		System.assertEquals('Test', controller.selectedObjectLabel);
		//fill in the fields
		Web_Form__c form = controller.webform;
		form.Name = 'Test';
		form.Return_URL__c = 'http://www.salesforce.com';
		//add some fields from the object to the form
		ApexPages.currentPage().getParameters().put('fieldname', 'Checkbox__c');
		controller.addField();
		System.assertEquals(1, controller.formFields.size());
		ApexPages.currentPage().getParameters().put('fieldname', 'Text__c');
		controller.addField();
		System.assertEquals(2, controller.formFields.size());
		ApexPages.currentPage().getParameters().put('fieldname', 'Picklist__c');
		controller.addField();
		System.assertEquals(3, controller.formFields.size());
		//move a field up
		System.assertEquals('Text__c', controller.formFields.get(1).Name);
		ApexPages.currentPage().getParameters().put('fieldname', 'Text__c');
		controller.moveUp();
		System.assertEquals('Text__c', controller.formFields.get(0).Name);
		System.assert(controller.formFields.get(0).Name == 'Text__c');
		
		//once more, hit the '0' index
		controller.moveUp();
		System.assert(controller.formFields.get(0).Name == 'Text__c');
		//and move it down again
		ApexPages.currentPage().getParameters().put('fieldname', 'Text__c');
		controller.moveDown();
		System.assertEquals('Text__c', controller.formFields.get(1).Name);
		controller.moveDown();
		controller.moveDown(); //hit the end of the list
		//remove a field
		ApexPages.currentPage().getParameters().put('fieldname', 'Picklist__c');
		controller.removeField();
		System.assertEquals(2, controller.formFields.size());
		
		//save the webform
		PageReference ref = controller.save();
		System.assertNotEquals(null, ref);
		
		//create an empty webform that doesn't validate
		Web_Form__c form2 = new Web_Form__c();
		controller.webform = form2;
		PageReference ref2 = controller.save();
		System.assertEquals(null, ref2);
		
		//call some of the remaining methods
		controller.getFormFieldsSize();
		
		//empty the form fields list
		controller.formFields.clear();
		controller.reOrderFormFields();
		controller.save();
		
		//cancel the edit
		//controller.cancel();
	}
	
	
	//Test of an edit
	public static testMethod void t2() {
				
		//Create a webform, fields and save it
		Web_Form__c form = new Web_Form__c();
		form.Name = 'Test';
		form.Object_Name__c = 'Test__c';
		form.Object_Label__c = 'Test';		
		form.Return_URL__c = 'http://www.salesforce.com';
		insert form;
		
		//create test form fields for this web form
		Form_Field__c f1 = new Form_Field__c(Type__c = 'STRING', Name = 'Text__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f2 = new Form_Field__c(Type__c = 'EMAIL', Name = 'Email__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f3 = new Form_Field__c(Type__c = 'URL', Name = 'URL__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f4 = new Form_Field__c(Type__c = 'BOOLEAN', Name = 'Checkbox__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f5 = new Form_Field__c(Type__c = 'DATE', Name = 'Date__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f6 = new Form_Field__c(Type__c = 'DATETIME', Name = 'DateTime__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f7 = new Form_Field__c(Type__c = 'CURRENCY', Name = 'Currency__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f8 = new Form_Field__c(Type__c = 'DOUBLE', Name = 'Number__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f9 = new Form_Field__c(Type__c = 'PERCENT', Name = 'Percent__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f10 = new Form_Field__c(Type__c = 'TEXTAREA', Name = 'Text_Area__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f11 = new Form_Field__c(Type__c = 'PHONE', Name = 'Phone__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f12 = new Form_Field__c(Type__c = 'PICKLIST', Name = 'Picklist__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f13 = new Form_Field__c(Type__c = 'UNSUPPORTED', Name = 'Text__c', Web_Form__c = form.Id, Label__c = 'lbl');
		Form_Field__c f14 = new Form_Field__c(Name = 'CUSTOM Text1', Label__c = '* CUSTOM Text *', Type__c = 'CUSTOMTEXT', Width__c = 250, Web_Form__c = form.Id);
		insert f1;
		insert f2;
		insert f3;
		insert f4;
		insert f5;
		insert f6;
		insert f7;
		insert f8;
		insert f9;
		insert f10;
		insert f11;
		insert f12;
		insert f13;
		insert f14;
		
		//now go to the editor in edit mode (the id url param exists)
		PageReference pageRef = Page.WebFormEditor;
		Test.setCurrentPage(pageRef);
		ApexPages.currentPage().getParameters().put('id', form.Id);
		
		//* Construct the standard controller for Web_Form__c. *//
        ApexPages.StandardController stdcon = new ApexPages.StandardController(new Web_Form__c());
		WebFormEditorController controller = new WebFormEditorController(stdcon);
		System.assertEquals(14, controller.formFields.size());
		//add a custom field
		controller.addCustomField();
		System.assertEquals(15, controller.formFields.size());
		//remove a custom field
		ApexPages.currentPage().getParameters().put('fieldname', 'CUSTOM Text1');
		controller.removeField();
		System.assertEquals(14, controller.formFields.size());
		//now save with less field than when it was originally retrieved
		controller.save();
		//give the object a dummy required field
		Form_Field__c f15 = new Form_Field__c(Type__c = 'STRING', Name = 'Text__c', Web_Form__c = form.Id, Label__c = 'lbl', Required__c = true);
		controller.objectFields.add(f15);
		System.assertEquals(controller.validate(), false);
	}
}