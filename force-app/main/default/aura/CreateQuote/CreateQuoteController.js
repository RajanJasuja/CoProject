({
	doInit : function(component, event, helper) {
		var itmtorepair = component.get("v.recordId");
        helper.cerateQuote(component,event,helper);
	}
})