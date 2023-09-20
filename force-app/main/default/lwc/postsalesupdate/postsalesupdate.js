import { LightningElement,api} from 'lwc';
import ID_FIELD from '@salesforce/schema/Visit_Management__c.Id';
import POSTSALES from '@salesforce/schema/Visit_Management__c.Post_Sales__c';
import FEEDPACK from '@salesforce/schema/Visit_Management__c.Feed_Back__c';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { updateRecord } from 'lightning/uiRecordApi';
export default class Postsalesupdate extends LightningElement {

    @api hidemodel2=false;
    @api getId;
    postsales;
    feedpack;
    closeModalAction(event){

        this.hidemodel2=true;

        const cuseve=new CustomEvent('postsalecanceled',{
            detail:false
        });
        this.dispatchEvent(cuseve);
    }
    handleChangespost(event) {
        this.postsales = event.target.value;
        console.log(this.postsales);
        console.log(this.getId);
    } 
    handleChangesfeedpack(event) {
        this.feedpack = event.target.value;
    } 
   
    handleClick(event) {
        
        const fields = {};
        fields[ID_FIELD.fieldApiName]  = this.getId;
        fields[POSTSALES.fieldApiName] =  this.postsales;
        fields[FEEDPACK.fieldApiName]  = this.feedpack;
       
        
        console.log(this.getId);
        console.log(this.postsales);
        console.log(this.feedpack);
        const recordInput = {
            fields: fields
          };

          updateRecord(recordInput).then((record) => {
            console.log(record);

           /* const cuseve=new CustomEvent('momupdated',{
            detail:this.mom
        });
        this.dispatchEvent(cuseve);*/

          });
          this.hidemodel2=true;
    } 
   

}