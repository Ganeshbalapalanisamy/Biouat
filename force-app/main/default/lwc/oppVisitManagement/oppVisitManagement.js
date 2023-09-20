import { LightningElement,api,wire,track} from 'lwc';
import  oppInformation from '@salesforce/apex/VisitManagementForm.oppInformation';
export default class OppVisitManagement extends LightningElement {
   //Variable Declaration
   @api recordId;
   opportunity;
   oppId;
   companyName;
   contactId;
   @track reload=true;


//    @api errorMessage;

//   connectedCallback() {
//     // Handle the record error passed from VF page
//     const recordError = JSON.parse(this.errorMessage);
//     alert('Record Error:', recordError);
//   }

  

   @wire(oppInformation,{recId: '$recordId'})
   wiredVisit({data,error}){
    
    if(data){
        data.Id ? this.oppId=data.Id:this.oppId=null;
       
        data.Company_Name__c ? this.companyName=data.Company_Name__c:this.companyName=null;
        data.Contact__c ? this.contactId=data.Contact__c:this.contactId=null;
       
     
      
       
    }else if(error){
       
        alert('error'+error.body.message);
    }

   }
cancel=false;
    handleCancel(event){
        this.cancel=true;
        event.preventDefault();  
        window.history.back();
        const inputFields = this.template.querySelectorAll(
        'lightning-input-field'
            );
        if (inputFields) {
            inputFields.forEach(field => {
            field.reset();
            });
        }
        return false;
    }
    oppHandler(event){
      this.opportunity=event.detail.value;
     // alert('this.opportunity'+this.opportunity);
        
    }
  
    handleSave(event){
          if(!this.cancel){
                 //send data to server side
           // const fields = event.detail.fields;
           //  this.template.querySelector('lightning-record-edit-form').submit(fields);
             //alert('Visit Management Record is Created');
            // window.location.assign('/'+this.recordId);
           
              //alert('Please fill the Required fields');
         
          }
 }
    
    
  /*  handleSubmit(event){
        event.preventDefault();       // stop the form from submitting
       
        
     }
  
  
  handleSave(event){
        //event.preventDefault();
       this.fields = event.detail.fields;
       this.template.querySelector('lightning-record-edit-form').submit(this.fields);
       
        window.history.back();
        /
    }*/
    handleSaveAndNew(event){
       // this.fields = event.detail.fields;
       // this.template.querySelector('lightning-record-edit-form').reset();
        //this.fields.reset();
        if(!this.cancel){
            //send data to server side
         event.preventDefault();
        const fields = event.detail.fields;
       this.template.querySelector('lightning-record-edit-form').submit(fields);
       //alert('Visit Management Record is Created');
       //window.location.assign('/'+this.recordId);
       this.reload=false;
       const inputFields = this.template.querySelectorAll(
        'lightning-input-field'
        );
    if (inputFields) {
        inputFields.forEach(field => {
        field.reset();
        });
    }

      }else{
         alert('Please fill the Required fields');
      }

    }
handleSuccess(event) {
  // Handle successful record save
  alert('Record saved successfully', event.detail.id);
  if(this.reload){
         window.location.assign('/'+this.recordId);

  }
}

handleError(event) {
  // Handle record save error
  alert('Record save error', event.detail.message);
}

}