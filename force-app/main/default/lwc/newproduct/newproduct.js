import { LightningElement,api } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
export default class Newproduct extends  NavigationMixin(LightningElement) {
    saveAndNew=false;
    closepage =true;
    @api recordId;
    handlesave()
    {
        console.log('handlesave');
        this.saveAndNew = false;
        this.handleRecordSave(); 
    }
    handleSaveAndNew(){
        this.saveAndNew = true;
        this.handleRecordSave();
        this.handleReset();   
    }

    handleReset(event) {
        const inputFields = this.template.querySelectorAll(
            'lightning-input-field'
        );
        if (inputFields) {
            inputFields.forEach(field => {
            field.reset();
            });
        }
    }
    handleSuccess(event) {
        if(this.saveAndNew){
            this.oppIdVal = event.detail.id; 
            this.handleReset();
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Product record has been created',
                    variant: 'success',
                }),
            );
         
            
        } else{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Product record has been created',
                    variant: 'success',
                }),
            );
        
            window.location.assign('/'+this.recordId);
      
        }  
        }
        handleRecordSave(event) {
            console.log('handleRecordSave');
              event.preventDefault(); 
              this.fields = event.detail.fields;
              this.template.querySelector('lightning-record-edit-form').submit(this.fields);
             getRecordNotifyChange([{recordId: this.recordId}]);
          }
     handleCancel()
     {
        this.closepage=false;
        window.location.assign('/'+this.recordId);
        
     }


}