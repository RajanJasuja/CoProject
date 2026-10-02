public class FormController {

	public Web_Form__c form {get;set;}
	public List<Form_Field__c> fields {get;set;}
	//Map that holds all the object names and tokens in your org
	Map<String, Schema.SObjectType> gd;
	//List with just these tokens
	public List<SObjectType> tokens = new List<SObjectType>();
	public SObject sobjectInstance {get;set;} //will hold the instance of the object that will be saved

	//CONSTRUCTOR
	public FormController() {
		//get the url parameter indication the web form Id
		String formId = System.currentPageReference().getParameters().get('id');
		if(formId == null) {
			ApexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, 'This page required a Web Form id url parameter.'));
			return;
		}
		//get the form and it's fields
		form = [select Id, Name, Object_Name__c, Return_URL__c,
				Background_Color__c, Text_Color__c, Save_Button_Text__c, Title__c from Web_Form__c where Id = :formId];
				
		fields = [Select f.Name, f.Id, f.Type__c, f.Label__c,
					f.Text_Value__c, f.Date_Value__c, f.Email_Value__c, f.DateTime_Value__c, f.Boolean_Value__c, 
					f.Currency_Value__c, f.Number_Value__c, f.Percent_Value__c, f.Phone_Value__c,f.Text_Area_Value__c,
					f.Text_Area_Long_Value__c, f.URL_Value__c, f.Picklist_Value__c, f.PicklistEntries__c, f.Width__c, f.Required__c
					From Form_Field__c f where f.Web_Form__c = :formId order by f.Order__c];
					
					
		//get a full list of all objecttokens in this org
        gd = Schema.getGlobalDescribe();
        //get a reference to the token related to the object referenced in the webform
        SObjectType sot = gd.get(form.Object_Name__c);
        //instantiate an object of this type
        sobjectInstance = sot.newSObject();
	}
	
	
	//fill the object with the correct field values and save it
	public PageReference saveObject() {
		try {
			//Boolean to keep validation status
			Boolean valid = true;
			//loop over all the displayed fields
			for(Form_Field__c ff:fields) {
				String fieldtype = ff.Type__c;
				String name = ff.Name;
				Object value = getValue(ff);
				//Check if required fields have values
				if((value == null) && ff.Required__c  ) {
					ApexPages.Message reqMsg = new ApexPages.Message(ApexPages.Severity.ERROR, ff.Label__c + ' is a required field.');
					ApexPages.addMessage(reqMsg);				
					valid = false;
				}			
				if(value != null) sobjectInstance.put(name, value);		
			}
			if(valid) {
				insert sobjectInstance;
				String retUrl = form.Return_URL__c;
				//accept url's with or without http://
				if(!form.Return_URL__c.startsWith('http://')) retUrl = 'http://'+form.Return_URL__c;				
				return new PageReference(retUrl);
			}
		} catch(Exception ex) {
			ApexPages.addMessages(ex);
		}
		return null;
	}
	
	
	//method that will return the value (date, string, url, etc ...) from the Form_Field__c
	private Object getValue(Form_field__c ff) {
		if(ff.Type__c == 'EMAIL') return ff.Email_Value__c;
		if(ff.Type__c == 'URL') return ff.URL_Value__c;
		if(ff.Type__c == 'BOOLEAN') return ff.Boolean_Value__c;
		if(ff.Type__c == 'DATE') return ff.Date_Value__c;
		if(ff.Type__c == 'DATETIME') return ff.DateTime_Value__c;
		if(ff.Type__c == 'CURRENCY') return ff.Currency_Value__c;
		if(ff.Type__c == 'STRING') return ff.Text_Value__c;
		if(ff.Type__c == 'DOUBLE') return ff.Number_Value__c;		
		if(ff.Type__c == 'PERCENT') return ff.Percent_Value__c;
		if(ff.Type__c == 'TEXTAREA') return ff.Text_Area_Value__c;
		if(ff.Type__c == 'PHONE') return ff.Phone_Value__c;
		if(ff.Type__c == 'PICKLIST') return ff.Picklist_Value__c;
		return null;
	}
	
	
	//** TEST METHODS **//
	
	public static testMethod void t1() {
		//set up a test web form
		Web_Form__c form = new Web_Form__c();
		form.Name = 'test webform';
		form.Object_Name__c = 'Test__c';
		form.Return_URL__c = 'www.x.com';
		
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
		Form_Field__c f13b = new Form_Field__c(Type__c = 'INTEGER', Name = 'Integer__c', Web_Form__c = form.Id, Label__c = 'lbl');
		
		
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
		insert f13b;

				
		//add a field with a missing required value
		Form_Field__c f14 = new Form_Field__c(Type__c = 'STRING', Name = 'Text__c', Web_Form__c = form.Id, Label__c = 'lbl', Required__c = true);
		insert f14;
		
		//set the current page for the test, put the web form id in parameters and instantiate the controller
		PageReference pageRef = Page.Form;
        Test.setCurrentPage(pageRef);
		// Add parameters to page URL
        ApexPages.currentPage().getParameters().put('id', form.Id);
		
		FormController controller = new FormController();
		System.assertEquals(15, controller.fields.size());
		//save with missing required fields
		PageReference ref = controller.saveObject();
		System.assertEquals(null,ref);
		
		//add the required values and save again
		f14.Text_Value__c ='something';
		upsert f14;
				
		//now do everything again but with no 'required field' validation errors
		FormController controller2 = new FormController();
		
		PageReference ref2 = controller2.saveObject();	
		System.assertEquals('http://www.x.com',ref2.getUrl());	
	}
	
	public static testMethod void t2() {
				
		//add an object with a required field in the db, just to throw an exception (Web_Form__c itself for example)
		//set up a test web form
		Web_Form__c form2 = new Web_Form__c();
		form2.Name = 'test webform';
		form2.Object_Name__c = 'Web_Form__c';//can't use account. Not accessible via Dynamix Apex in packaged class.
		form2.Object_Label__c = 'Test';
		form2.Return_URL__c = 'http://www.x.com';
		
		insert form2;
		//create test form fields for this web form
		Form_Field__c f20 = new Form_Field__c(Type__c = 'STRING', Name = 'Phone', Web_Form__c = form2.Id, Label__c = 'lbl');
		//add just one, we ommit the required 'Name' field.		
		insert f20;
		
		// Add parameters to page URL
		PageReference pr = Page.Form;
		Test.setCurrentPage(pr);
        ApexPages.currentPage().getParameters().put('id', form2.Id);
		
		FormController controller3 = new FormController();
		//the save needs to throw an exception because the object's required field is not in the formfields list		
		System.assert(controller3.saveObject() == null);
		
	}
	
	//no web form id url param
	public static testMethod void t3() {
		FormController controller = new FormController();		
	}
	
}