import { LightningElement,api } from 'lwc';

export default class CustomLookupRepeatOrder extends LightningElement {
    @api childObjectApiName = 'Contact'; //Contact is the default value
    @api targetFieldApiName = 'AccountId'; //AccountId is the default value
    @api fieldLabel = 'field label name';
    @api disabled = false;
    @api value;
    @api required = false;
    @api openmodal=false;
    handleChange(event) {
        // Creates the event
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
}