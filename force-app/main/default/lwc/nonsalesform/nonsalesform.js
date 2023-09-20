import { LightningElement,api } from 'lwc';
export default class Nonsalesform extends LightningElement {
    @api hidemodel1=false

    closeModalAction(event){
        this.hidemodel1=true;
    }

    handlesave()
    {
        console.log('handlesave');
        this.saveAndNew = false;
        this.handleRecordSave();
        this.hidemodel1=true;
        this.handlePageReload();
        
    }
    handleRecordSave(event) {
        event.preventDefault(); 
        this.fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(this.fields);
       getRecordNotifyChange([{recordId: this.recordId}]);
    }

}