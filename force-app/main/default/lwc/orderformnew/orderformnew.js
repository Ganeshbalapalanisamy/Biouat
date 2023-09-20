import { LightningElement,api} from 'lwc';
import NAME from  '@salesforce/schema/Biomatiq_Opportunity__c.Account_Name__c'
export default class Orderform extends LightningElement {
    @api recordId;
    @api objectApiName;
    showme=false;
   
    handlechange(event)
    {
        Console.log(NAME);
       this.showme=true;
    }
}