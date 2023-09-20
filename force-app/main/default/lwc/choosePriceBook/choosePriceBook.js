import { LightningElement,api,wire} from 'lwc';
import oppDetails from '@salesforce/apex/AddProductsController.oppDetails';
import getPriceBooks from '@salesforce/apex/AddProductsController.getPriceBooks';
import ID_FIELD from '@salesforce/schema/BiomatiQ_Lead__c.Id';
import PriceBookField from '@salesforce/schema/BiomatiQ_Lead__c.Price_Book__c';
import { updateRecord } from 'lightning/uiRecordApi';
export default class ChoosePriceBook extends LightningElement {

@api recordId;
pricebook;
priceBookOptions=[];


@wire(getPriceBooks)
priceBooks({ error, data }) {
    if (data) {
        for(const list of data){
            const option = {
                label: list.Name,
                value: list.Id
            };
            // this.selectOptions.push(option);
            this.priceBookOptions = [ ...this.priceBookOptions, option ];
        }
        oppDetails({oppId:this.recordId})
        .then((result)=>{
            result.Price_Book__c?this.pricebook=result.Price_Book__c:this.pricebook=null;
        }).catch((error)=>{
            console.error(error);
        })
    } else if (error) {
        console.error(error);
    }
}



handleCancel(){
    window.location.assign('/'+this.recordId);
}
handlePriceBookChange(e){
    this.pricebook=e.target.value;
   
}

handleSave(e){
    const fields = {};
    fields[ID_FIELD.fieldApiName]  = this.recordId;
    fields[PriceBookField.fieldApiName] =  this.pricebook;
   

    const recordInput = {
        fields: fields
      };

      updateRecord(recordInput).then((record) => {
        alert('PriceBook value updated successfully')
        window.location.assign('/'+this.recordId);
 }).catch((error=>{
    
   alert(JSON.stringify(error.body.output))
 }))
}
}