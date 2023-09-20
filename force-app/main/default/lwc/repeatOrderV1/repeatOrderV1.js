import { LightningElement,track,api } from 'lwc';
import opportunity from '@salesforce/schema/Biomatiq_Opportunity__c';
import Orderinformation from '@salesforce/apex/RepeatOrder.Orderinformation';
import { getRecordNotifyChange, RecordFieldDataType } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
export default class ModalDemoInLWC extends LightningElement {
    @api isShowModal = false;
    selectedId;
    objApi = opportunity;
    customername;
    div;
    Name;
    make;
    opp;
    man;
    accname;
    product;
    type;
    probability;
    ROI;
    amount;
    discom;
    delivery;
    closedate;
    budgetcon;
    priority;
    ponum;
    Total;
    sonum;
    sodate;
    quonum;
    purchasequery;
    vendornum;
    sailorrem;
    vendorpono;
    custpono;
    gen;
    LF;
    orgref;
    tech;
    planunplan;
    com;
    repeatnew;
    nextstep;
    sno;
    leadsrc;
    cluster;
    description;
    delsch;
    person1;
    person2;
    person3;
    person4;
    delsize;


//showModalBox() {  
        //this.isShowModal = true;
    //}

    @api childExistingOrder(parentParam){
        this.isShowModal = true;
        //this.Openexistingmodal=true;
        this.selectedId=parentParam.orderId;
       
       // 
       this.handleordervaluesPopulate();
       
    }
    handleordervaluesPopulate(){
      
        var selectedOrder= this.selectedId;
        
        if(selectedOrder){ 
            Orderinformation({ OrderId: selectedOrder })
            .then(result => {
                result.Customer_Name__c ? this.customername= result.Customer_Name__c : this.customername= null;
                result.Div__c ? this.div= result.Div__c : this.div= null;
                result.Name ? this.name= result.Name : this.name= null;
                result.Make__c ? this.make= result.Make__c : this.make= null;
                result.Opportunity__c ? this.opp= result.Opportunity__c : this.opp= null;
                result.Man__c ? this.man= result.Man__c : this.man= null;
                result.Account_Name__c ? this.accname= result.Account_Name__c : this.accname= null;
                result.Product__c ? this.product= result.Product__c : this.product= null;
                result.Type__c ? this.type= result.Type__c : this.type= null;
                result.New_Probability__c ? this.probability= result.New_Probability__c : this.probability= null;
                result.ROI_Analysis_Completed__c ? this.ROI= result.ROI_Analysis_Completed__c : this.ROI= null;
                result.Amount__c ? this.amount= result.Amount__c : this.amount= null;
                result.Discovery_Completed__c ? this.discom= result.Discovery_Completed__c : this.discom= null;
                result.Delivery__c ? this.delivery= result.Delivery__c : this.delivery= null;
                result.Close_Date__c ? this.closedate= result.Close_Date__c : this.closedate= null;
                result.Budget_Confirmed__c ? this.budgetcon= result.Budget_Confirmed__c : this.budgetcon= null;
                result.Priority__c ? this.priority= result.Priority__c : this.priority= null;
                result.PO_Number__c ? this.ponum= result.PO_Number__c : this.ponum= null;
                result.Total__c ? this.Total= result.Total__c : this.Total= null;
                result.SO_Number__c ? this.sonum= result.SO_Number__c : this.sonum= null;
                result.SO_Date__c ? this.sodate= result.SO_Date__c : this.sodate= null;
                result.Quotation_Number__c ? this.quonum= result.Quotation_Number__c : this.quonum= null;
                result.Purchase_Queries__c ? this.purchasequery= result.Purchase_Queries__c : this.purchasequery= null;
                result.Vendor_Number__c ? this.vendornum= result.Vendor_Number__c : this.vendornum= null;
                result.Sailor_Remarks__c ? this.sailorrem= result.Sailor_Remarks__c : this.sailorrem= null;
                result.Vendor_PO_No_Dt__c ? this.vendorpono= result.Vendor_PO_No_Dt__c : this.vendorpono= null;
                result.Customer_PO_No_Dt__c ? this.custpono= result.Customer_PO_No_Dt__c : this.custpono= null;
                result.Gen__c ? this.gen= result.Gen__c : this.gen= null;
                result.LF__c ? this.LF= result.LF__c : this.LF= null;
                result.Org_Ref__c ? this.orgref= result.Org_Ref__c : this.orgref= null;
                result.Tech__c ? this.tech= result.Tech__c : this.tech= null;
                result.Plan_Unplan__c ? this.planunplan= result.Plan_Unplan__c : this.planunplan= null;
                result.Com__c ? this.com= result.Com__c : this.com= null;
                result.Repeat_New__c ? this.repeatnew= result.Repeat_New__c : this.repeatnew= null;
                result.Next_Step__c ? this.nextstep= result.Next_Step__c : this.nextstep= null;
                result.S_No__c ? this.sno= result.S_No__c : this.sno= null;
                result.Lead_Source__c ? this.leadsrc= result.Lead_Source__c : this.leadsrc= null;
                result.Cluster__c ? this.cluster= result.Cluster__c : this.cluster= null;
                result.Description__c ? this.description= result.Description__c : this.description= null;
                result.Del_Sch__c ? this.delsch= result.Del_Sch__c : this.delsch= null;
                result.Person1__c ? this.person1= result.Person1__c : this.person1= null;
                result.Person2__c ? this.person2= result.Person2__c : this.person2= null;
                result.Person3__c ? this.person3= result.Person3__c : this.person3= null;
                result.Person4__c ? this.person4= result.Person4__c : this.person4= null;
                result.Del_Size__c ? this.delsize= result.Del_Size__c : this.delsize= null;


         })
        .catch(error => {
            this.error = error;
        })

    }
    else{
         this.customername=null;
         this.div= null
         this.Name= null;
         this.make= null;
         this.opp= null;
         this.man= null;
         this.accname= null;
         this.product= null;
         this.type= null;
         this.probability= null;
         this.ROI= null;
         this.amount= null;
         this.discom= null;
         this.delivery= null;
         this.closedate= null;
         this.budgetcon= null;
         this.priority= null;
         this.ponum= null;
         this.Total= null;
         this.sonum= null;
         this.sodate= null;
         this.quonum= null;
         this.purchasequery= null;
         this.vendornum= null;
         this.sailorrem= null;
         this.vendorpono= null;
         this.custpono= null;
         this.gen= null;
         this.LF= null;
         this.orgref= null;
         this.tech= null;
         this.planunplan= null;
         this.com= null;
         this.repeatnew= null;
         this.nextstep= null;
         this.sno= null;
         this.leadsrc= null;
         this.cluster= null;
         this.description= null;
         this.delsch= null;
         this.person1= null;
         this.person2= null;
         this.person3= null;
         this.person4= null;
         this.delsize= null;


    }
    }

    handleCancel() {  
        this.isShowModal = false;
    }
    handleRecordSave(event) {
        event.preventDefault(); 
        this.fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(this.fields);
       getRecordNotifyChange([{recordId: this.recordId}]);
      
    }
    handlesave()
    {
        console.log('handlesave');
        this.saveAndNew = false;
        this.handleRecordSave(); 
    }
    handleSaveAndNew() {
        this.saveAndNew = true;
        this.handleRecordSave();
        this.handlePageReload();
    }
    handlePageReload(event) {
        event.preventDefault(); 
        this.fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(this.fields);
        getRecordNotifyChange([{recordId: this.recordId}]);
        setTimeout(
            function() {
                 window.location.reload();
            },
            10
        );
        
    }
    handleSuccess(event) {
        if(this.saveAndNew){
            this.oppIdVal = event.detail.id; 
            this.handleReset();
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Order record has been created',
                    variant: 'success',
                }),
            );
            this.isShowModal=false;
        } else{
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Order record has been created',
                    variant: 'success',
                }),
            );
            this.isShowModal=false;
          /*  setTimeout(
                function() {
                    const payload = event.detail;            
                    var objJSON = JSON.parse(JSON.stringify(payload));  
            
    
                    window.open('/'+objJSON["fields"]["BiomatiQ_Lead__c"]["value"],'_self');
                     window.location.reload();
                },
                10
            );*/
      
        }  
        }
}