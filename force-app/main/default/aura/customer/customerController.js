({
    
     handleOnSubmit : function(component, event, helper) {
          alert("submitted successfully");
         
         var urlEvent = $A.get("e.force:navigateToURL");
    urlEvent.setParams({
      "url": "https://ris4--dev.lightning.force.com/lightning/o/Biomatiq_Lead__c/list?filterName=Recent"
    });
    urlEvent.fire();
            
      },
   /* handleOnSubmit : function(component, event, helper) {
    console.log("this is a test");
    //Display toast message
    var toastEvent = $A.get("e.force:showToast");
    toastEvent.setParams({
        "title": "Success!",
        "message": "record has been created.",
        "type": "success"
    });
    toastEvent.fire();

    // Close Quick Action Panel:
    var dismissActionPanel = $A.get("e.force:closeQuickAction");
    dismissActionPanel.fire();
    var homeEvent = $A.get("e.force:navigateToSObject");
    homeEvent.setParams({
        "recordId": component.get("v.recordId")
    });
    homeEvent.fire();

},*/
    init : function(component, event, helper) {
        $A.get("e.force:navigateToSObject").setParams({
            "recordId": component.get("v.recId"),
            "slideDevName": "related"
        }).fire();
    },
    
    
     handleUploadFinished: function (cmp, event) {
        // Get the list of uploaded files
        var uploadedFiles = event.getParam("files");
        alert("Files uploaded : " + uploadedFiles.length);

        // Get the file name
        uploadedFiles.forEach(file => console.log(file.name));
    }
    
    
   })