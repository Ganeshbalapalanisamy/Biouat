/*
* @File Name          : checkoutForm.js
* @Description        : Creation Of New Opportunity,Existing Opportunity,Repeat order,Non-sales,Post-sales and Feed-Back component JS.
* @Author             : Karthick Ravi
* @Parent Component   : checkOutForm.js
* @Child  Component   : newOpportunity.js
* @Child  Component   : customlookupopportunity.js
* @Child  Component   : searchopportunity.js
* @Child  Component   : postsalesupdate.js
* @Last Modified By   : karthick.ravi@rudhrainfosolutions.com
* @Last Modified On   : 6/10/2022
* @Modification Log   : 
*==============================================================================
* Ver         Date                     Author            Modification
*==============================================================================
* 1.0    6/10/2022                 Karthick Ravi          Initial Version
*/
import { LightningElement,api,wire } from 'lwc';
import ID_FIELD from '@salesforce/schema/Visit_Management__c.Id';
import NONSALES from '@salesforce/schema/Visit_Management__c.Non_Sales__c';
import MOM from '@salesforce/schema/Visit_Management__c.MOM__c';
import { updateRecord } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord, getFieldValue  } from 'lightning/uiRecordApi';
export default class CheckoutForm extends LightningElement {
 
  
   @api
   recordId;
    @api objectApiName;
    @api getIdFromParent;
    @api hidemodel=false;
    company;
    createOpportunity=false;
    showmodal=false;
    openmodal=false;
    openmodal1=false;
    existingopportunity=false;
    existingorder=false;
    showfeedback=false;
    postsales=false;
    hidemodel2=false;
    openmodal2=false;
    nonsales;
    getid;
    @api mom;
    @api getCompanyId;
    getcheckout;
 
    handleChange(event) {
        let i;
        let checkboxes = this.template.querySelectorAll('[data-id="checkbox"]')
        for(i=0; i<checkboxes.length; i++) {
            checkboxes[i].checked = event.target.checked;
        }
    }

    handleNewOpportunity(event)
    {
        if (!this.createOpportunity)
        {
            
        
            this.createOpportunity=true; 
        }
        else{
          
            this.createOpportunity=false;
          
        }
    } 

    handleCancel(event) 
    {
        this.hidemodel=true;
    }
    handleExistingOpportunitys(event)
    {
        if (!this.existingopportunity)
        {
          
            this.existingopportunity=true;
        }else{

            this.existingopportunity=false
        }
        
    }
    handleRepeatOrder(event)
    {
        if (!this.existingorder)
        {
           
            this.existingorder=true;
        }  else{
            this.existingorder=false;
        } 
    }
    handleNonSales(event)
    {
        if (!this.showfeedback)
        {
            this.showfeedback=true;
        } else{
            this.showfeedback=false;
        }
        console.log('companyvalues'+ this.getCompanyId); 
    }
    handlepostSales(event)
    {
        if (!this.postsales)
        {
            this.postsales=true;
        }  else{
            this.postsales=false;
        }
    }
    handlenonsalescancel(event) 
    {
        this.showfeedback=false;
    } 
    handleChanges(event) {
        this.nonsales = event.target.value;
        console.log(this.nonsales);
        console.log(this.getIdFromParent);
    } 
    handleClick(event) {
        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.getIdFromParent;
        fields[NONSALES.fieldApiName] = this.nonsales;
        console.log(this.recordId);
        console.log(this.nonsales);
        const recordInput = {
            fields: fields
          };

          updateRecord(recordInput).then((record) => {
            console.log(record);
          });
          this.showfeedback=false;
    }
    progress(event){

        if(this.mom!=null){
            const fields = {};
        fields[ID_FIELD.fieldApiName] = this.getIdFromParent;
        fields[MOM.fieldApiName] = this.mom;
        console.log(this.recordId);
        console.log(this.mom);
        const recordInput = {
            fields: fields
          };

          updateRecord(recordInput).then((record) => {
            console.log(record);
          

        const custEvent = new CustomEvent(
            'callpasstoparent', {
            
            });
        this.dispatchEvent(custEvent);
        this.hidemodel=true;
    }).catch(error=>{
        console.log('error'+JSON.stringify(error))
        const err=error.body.output.errors[0].message;
        console.log('error'+err)
        if(err.includes("Enter Today's or Future  Date")){
            const evt = new ShowToastEvent({
           
                message: "Related Opportunity Error, Enter Today's or Future  Date: [Opportunity Next Follow up]",
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
    

        }
        else if(err.includes('Error ID')){
        let er=err.replace(/Error ID:[^\.]+\.?/g, '');
        const strToRemove="You can look up ExceptionCode values in the SOAP API Developer Guide.";
        if(er.includes(strToRemove)){
            er=er.replace(strToRemove,'');
        }
        const evt = new ShowToastEvent({
           
            message: er,
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
    else{
        const evt = new ShowToastEvent({
           
            message: err,
            variant: 'error',
            mode: 'dismissable'
        });
        this.dispatchEvent(evt);
    }
    })

        }
        else{
           
            const evt = new ShowToastEvent({
           
                message: 'Please Eneter MOM Value',
                variant: 'error',
                mode: 'dismissable'
            });
            this.dispatchEvent(evt);
    
        }
    } 
    handleMOMChanges(event){
    
        this.mom=event.detail.value;
    }
    handlePostSaleCanceld(){
       this.postsales=false;
    }
}