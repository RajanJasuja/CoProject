({
	myAction : function(component, event, helper) {
		
	},
    
init : function(component, event, helper) {
        // Force attribute values to trigger proper binding
        let principal = component.get("v.mortgagePrincipal");
        let rate = component.get("v.mortgageRate");
        let years = component.get("v.mortgageYears");

        component.set("v.mortgagePrincipal", principal);
        component.set("v.mortgageRate", rate);
        component.set("v.mortgageYears", years);

        helper.calculatePayment(component);
    },
    
    calculatePayment : function(component, event, helper) {
        helper.calculatePayment(component);
    },

})