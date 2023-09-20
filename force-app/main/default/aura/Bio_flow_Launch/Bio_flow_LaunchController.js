({
   doinit : function(component, event, helper) {
     var flow = component.find("New BiomatiQ Lead");
     flow.startFlow("Bio_lead_record");
   }
})