import { LightningElement,api} from 'lwc';

export default class LookupCompany extends LightningElement {
    @api childObjectApiName = 'Visit_Management__c'; 
    @api targetFieldApiName = 'Account'; 
    @api fieldLabel = 'Your field label here';
    @api disabled = false;
    @api value;
    @api required = false;
    @api openmodal=false;
    
     showexistingaccount=false;
     openexistingmodel=false;
    handleChange(event) {
        // Creates the event
        var opp=event.target.value;
       // alert(opp);
        this.showexistingaccount=true; 

const childComp=this.template.querySelector('c-existingopportunity');
var sendParam={oppId:opp}
childComp.childExistingaccount(sendParam);

       /* const selectedEvent = new CustomEvent('valueselected', {
            detail: event.target.value
        });
        //dispatching the custom event
        this.dispatchEvent(selectedEvent);*/
        console.log(event.detail.id);  
        
    }
    handleclose(event)
    {
        this.openmodal=true;
    }
    handlenext(event)
    {
        this.showexistingaccount=true;
    }
    @api isValid() {
        if (this.required) {
            this.template.querySelector('lightning-input-field').reportValidity();
        }
    }
}