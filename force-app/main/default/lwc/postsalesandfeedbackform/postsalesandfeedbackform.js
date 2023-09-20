import { LightningElement, api } from 'lwc';

export default class CustomLookup extends LightningElement {
    @api childObjectApiName = 'Contact'; //Contact is the default value
    @api targetFieldApiName = 'AccountId'; //AccountId is the default value
    @api fieldLabel = 'Your field label here';
    @api disabled = false;
    @api value;
    @api required = false;
    @api openmodal=false;
     selectedRecordId;
     showexistingopportunity=false;
     openexistingmodel=false;
    handleChange(event) {
        // Creates the event
        console.log('1234')
       // const selectedRecordId = this.template.querySelector('[data-id="demo"]').id;
     //   this.selectedRecordId=this.template.querySelector('lightning-input-field[data-name="demo"]').id
    this.selectedRecordId=event.target.value;
        console.log(selectedRecordId);
        console.log(event.target.value);
        const selectedEvent = new CustomEvent('valueselected', {
            detail: event.detail.value


        });
        //dispatching the custom event
        this.dispatchEvent(selectedEvent);
        console.log(event.detail.id);    
    }
    handleclose(event)
    {
        this.openmodal=true;
    }
    handlenext(event)
    {
        this.showexistingopportunity=true;
    }
    @api isValid() {
        if (this.required) {
            this.template.querySelector('lightning-input-field').reportValidity();
        }
    }
    handleValueSelcted(event) {
        this.selectedRecordId = event.detail;
    }
}