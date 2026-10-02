({
	onInit : function(component, event, helper) {
        
        /*
        var action = component.get("c.getQueues");

        action.setCallback(this, function(response){
            if(response.getState()==="SUCCESS" && component.isValid()){
                component.set("v.queues",response.getReturnValue());
            }
        });
        $A.enqueueAction(action);
		*/
        
        
        const empApi = component.find('empApi');
        const channel = '/topic/CaseCreate';
        empApi.setDebugFlag(true);
        var handleError = function (error) {
            //alert('empApi error'+error);
            console.log('empApi error', error);
        };
        empApi.onError(handleError);

        empApi.subscribe(channel, -1, $A.getCallback(eventReceived => {
            console.log('Received event ', JSON.stringify(eventReceived));
            var s=''+eventReceived.data.sobject;
            alert(eventReceived.data.sobject); 
             component.set("v.case",s);
        }));
		
	}
})