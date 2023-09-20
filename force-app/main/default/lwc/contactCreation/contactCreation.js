import { LightningElement, api } from 'lwc';
//import NAME_FIELD from '@salesforce/schema/Contact.Name';
import Contact from '@salesforce/schema/Contact';
export default class ContactCreation extends LightningElement {

 name;
  email;
  mobile;
  department;
  designation;
  @api phone;
  @api accId;
  @api newContForm=false;
    // Flexipage provides recordId and objectApiName
    @api recordId;
    @api objectApi=Contact;
cancel=false;
    handleCancel(event){
      this.cancel=true;
      this.newContForm=false;
      const cancel = new CustomEvent('canceled', { detail:'false'  });

      // Dispatches the event.
      this.dispatchEvent(cancel);
    }
    save=false;
    handleSaveCont(event){
this.save=true;
        console.log('Contact Record Saved');
      //  event.preventDefault(); 
       this.fields = event.detail.fields;
       this.template.querySelector('lightning-record-edit-form').submit(this.fields);
      // alert('account id '+event.detail.id);
      // this.newContForm=false;
    
    }
    handleContactError(event){
      alert(JSON.stringify(event));
    }
    
    handleContSuccess(event){
      if(this.recordId !== null && this.save){
       // alert('Contact Created successfully '+event.detail.id);
         // event.preventDefault();
         this.newContForm=false;
     // Creates the event with the contact ID data.
     const contactCreated = new CustomEvent('created', { detail: event.detail.id });

     // Dispatches the event.
     this.dispatchEvent(contactCreated);
       }
  }
}