({
	doInit : function(component, event, helper) {
        
        var action = component.get("c.getObjectiveRecord");
action.setParams({
     incentiveId : component.get("v.recordId")
});
        action.setCallback(this, function(response) {
            var state = response.getState();
            if (state === "SUCCESS") {
                //alert("Success");
                //alert("From server: " + response.getReturnValue());
                 var u=[];
       u=response.getReturnValue();
               // alert(u.length);
               
       component.set("v.Incentive",u);
                
            }
            else if (state === "INCOMPLETE") {
        
            }
            else if (state === "ERROR") {
                var errors = response.getError();
                if (errors) {
                    if (errors[0] && errors[0].message) {
                        console.log("Error message: " + 
                                 errors[0].message);
                    }
                } else {
                    console.log("Unknown error");
                }
            }
        });

        $A.enqueueAction(action);
    	
	},
    	handleDone : function(component, event, helper) {
       
            $A.get("e.force:closeQuickAction").fire()
        
        }
})