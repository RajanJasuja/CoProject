({
	cerateQuote : function(component,event,helper) {
		var action = component.get("c.cerateQuote");
       	var itemId = component.get("v.recordId");
        alert(itemId);
        action.setParams({
            "itemId": itemId
        });
        action.setCallback(this, function(response) {
            var state = response.getState();
            alert(state);
            if (state == 'SUCCESS') {
                alert(state);
                component.set("v.Message",'Your Quote is Succesfully Created!');
            }  
       })
        $A.enqueueAction(action); 
    }
})