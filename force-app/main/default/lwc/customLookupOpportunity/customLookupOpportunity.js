import { api, LightningElement, track, wire } from 'lwc';
import lookUp from '@salesforce/apex/Lookup.searchOpport';
export default class CustomLookup extends LightningElement {
@api visitId;
    @api fieldLabel = 'Select Opportunity';
    @api openmodal=false;
    
     showexistingopportunity=false;
     openexistingmodel=false;
  
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


    @api objName;
    @api iconName;
    @api filter = '';
    @api searchPlaceholder='Search Opportunity';
    @track selectedName;
    @track records;
    @track isValueSelected;
    @track blurTimeout;
    searchTerm;
    @api getValueId;
    companyId;
    //css
    @track boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
    @track inputClass = '';
    @wire(lookUp, {searchTerm : '$searchTerm', myObject : '$objName', filter : '$filter' ,companyId : '$getValueId' })
    wiredRecords({ error, data }) {
        if (data) {
  
            this.error = undefined;
            this.records = data;
        } else if (error) {
            this.error = error;
            this.records = undefined;
        }
    }
   
    handleClick(event) {
    this.searchTerm = '';
        this.inputClass = 'slds-has-focus';
        this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus slds-is-open';
        console.log('gettingvalues--------'+this.getValueId);


 
    }

    onBlur() {
        this.blurTimeout = setTimeout(() =>  {this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus'}, 300);
    }

    onSelect(event) {

        var opp=event.currentTarget.dataset.id;
        // alert(opp);
         this.showexistingopportunity=true; 
 
 const childComp=this.template.querySelector('c-existingopportunity');
 var sendParam={oppId:opp}
 childComp.childExistingOpportnity(sendParam);
        let selectedId = event.currentTarget.dataset.id;
        let selectedName = event.currentTarget.dataset.name;
        /*const valueSelectedEvent = new CustomEvent('lookupselected', {detail:  selectedId });
        this.dispatchEvent(valueSelectedEvent);*/
        this.isValueSelected = true;
        this.selectedName = selectedName;
        if(this.blurTimeout) {
            clearTimeout(this.blurTimeout);
        }
        this.boxClass = 'slds-combobox slds-dropdown-trigger slds-dropdown-trigger_click slds-has-focus';
    }

    handleRemovePill() {
        this.isValueSelected = false;
    }

    onChange(event) {
        this.searchTerm = event.target.value;
    }
}