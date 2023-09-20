import { LightningElement,api } from 'lwc';

export default class AccountSearch extends LightningElement {
    @api openmodal2=false;
    openrepeatorderform=false;
    handleAccountSelection(event){
        console.log("the selected record id is"+event.detail);
        var order=event.detail;
        this.openrepeatorderform=true;
        const childComp=this.template.querySelector('c-repeat-order-v1');
         var sendParam={orderId:order}
       childComp.childExistingOrder(sendParam);
    }
}