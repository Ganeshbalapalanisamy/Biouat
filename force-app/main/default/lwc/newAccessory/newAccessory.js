import { LightningElement,api,track} from 'lwc';

import insertAccessory from '@salesforce/apex/ReusableLookupController.insertAccessory';

export default class NewAccessory extends LightningElement {
 @track isShowModal = true;
 @api recordId;
 searchString;
 @track childProductRecord;
 parentProductHandler(event){
     this.recordId=event.target.value;
 }

  
    handleValueSelectedOnAccount(event) {
        this.childProductRecord = event.detail.id;
        console.log('Accessories Id==>'+JSON.stringify(this.childProductRecord));
        console.log('Product Id==>'+ this.childProductRecord);
    }

    /* showModalBox() {  
        this.isShowModal = true;
    }*/

    hideModalBox() {  
        //this.isShowModal = false;
        window.history.back();
    }

    handleSave(){

          insertAccessory({
            parentProductId: this.recordId,childProductId:this.childProductRecord
        }).then(result => {
           if (result) {
              
                alert('Accessories Record is Created Successfully');
               window.location.assign('/'+this.recordId);
                 console.log('result Id==>'+result);
            } 
        }).catch(error => {
            //alert(Json.stringify(error));
            alert(JSON.stringify(error.body.message));
            console.log('error==>'+JSON.stringify(error));
        })

    }

    handleSaveAndNew(){

         insertAccessory({
            parentProductId: this.recordId,childProductId:this.childProductRecord
        }).then(result => {
           if (result) {
              
                alert('Accessories Record is Created Successfully');
                          let childCOmp=this.template.querySelector('c-reusable-lookup');
                          childCOmp.resetValue();

                console.log('result Id==>'+result);
            } 
        }).catch(error => {
            //alert(Json.stringify(error));
            alert(JSON.stringify(error.body.message));
            console.log('error==>'+JSON.stringify(error));
        })

    }
}