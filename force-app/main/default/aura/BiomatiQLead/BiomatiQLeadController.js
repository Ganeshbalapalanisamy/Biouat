({
   doinit : function(component, event, helper) {
     var flow = component.find("Quick Lead");
     flow.startFlow("Bio_lead_record");
   }
})