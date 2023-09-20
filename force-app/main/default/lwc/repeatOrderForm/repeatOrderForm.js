import { LightningElement,api} from 'lwc';
import RepeatOrderForm from '@salesforce/schema/Biomatiq_Opportunity__c';

export default class NewOpportunity extends NavigationMixin(LightningElement) {
    @api recordId;
    
}