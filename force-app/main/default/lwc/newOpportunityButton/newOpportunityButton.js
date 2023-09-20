import { LightningElement,api,track} from 'lwc';
import opportunity from '@salesforce/schema/BiomatiQ_Lead__c';
import companyinformation from '@salesforce/apex/Companydetailautofetch.companyinformation';
import contactList from '@salesforce/apex/Companydetailautofetch.contactList';
import { updateRecord } from 'lightning/uiRecordApi';
import conlists from '@salesforce/apex/Companydetailautofetch.conlists';
import clusterlists from '@salesforce/apex/Companydetailautofetch.clusterlists';
import { getRecordNotifyChange, RecordFieldDataType } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import CONTACT_FIELD from '@salesforce/schema/BiomatiQ_Lead__c.Contact__c';
import Cluster_FIELD from '@salesforce/schema/BiomatiQ_Lead__c.Cluster_Lookup__c';
import ID_FIELD from '@salesforce/schema/BiomatiQ_Lead__c.Id';
import { CloseActionScreenEvent } from 'lightning/actions';

export default class NewOpportunityButton extends NavigationMixin(LightningElement) {
    @api recordId;
    @api showmodal=false;
    @track loaded = false;
    objApi = opportunity;
    // website;
      Phone='';
      email='';
      mobile='';
      Department='';
      Designation='';
      state='';
      cluster='';
      newContForm=false;
      branch;
      state='';
      stateText='';
      cluster='';
      country='';
      isIndia=false;
      isIndia1=false;
      //gsttreatment;
      isStatus=false;
      isStatu1=false;
      isStatus2=false;
      isStatus3=false;
      saveAndNew=false;
      save=false;
      opportunityForm=false;
      error1;
      @api contactVal;
      @api clusterValue;
    //aj
      @track selectedAccount;
      @track childOFCompany;
      @track clusterOptions;
     /* statusCheck(event)
      {
          if(event.detail.value=='Customer Engagement')
          {
              this.isStatus=true;
          }
          else  if(event.detail.value=='Technical Close')
          { 
              this.isStatus=true;
          }
          else   if(event.detail.value=='Quote Request')
          { 
              this.isStatus=true; 
          }
          else   if(event.detail.value=='Quote Sent')
          {
              
              this.isStatus=true;
          }
          else {
            
              this.isStatus=false;
          }
  
      }*/
      ischeck=false;
      ischeck1=false;
      ischeck2=false;
      handlechange(event)
      {
          if(event.detail.value=='Referral - Through colleague')
          {
              this.ischeck=true;
              this.ischeck1=false; 
              this.ischeck2=false;
          }
          else   if(event.detail.value=='Referral - Through principal company')
          {
           
              this.ischeck1=true; 
              this.ischeck=false;
              this.ischeck2=false;
          }
          else   if(event.detail.value=='Revival-Through Colleague')
          {
            
              this.ischeck2=true; 
              this.ischeck=false;
              this.ischeck1=false;
          }
          else{
            
              this.ischeck1=false; 
              this.ischeck=false;
              this.ischeck2=false;
          }
      }
  
      insAction=false;
      insAction1=false;
      insAction2=false;
      productchange(event)
      {
          if(event.detail.value=='Instrumentation')
          {
              this.insAction=true; 
              this.insAction1=false; 
              this.insAction2=false;
          }
          else if (event.detail.value=='Regular Essentials') {
              this.insAction1=true; 
              this.insAction=false; 
              this.insAction2=false;
          }
          else if (event.detail.value=='Specialty Products') {
              this.insAction2=true; 
              this.insAction=false; 
              this.insAction1=false;
          }
           else {
              this.insAction1=false; 
              this.insAction=false; 
              this.insAction2=false;
          }
  
      }
      /*ajay changes------------
      pickConDetails(event){
            
        var selectCon = event.target.value;
        if(selectCon!=null&&selectCon.length>0){
        console.log('con selected'+selectCon);
        console.log('con'+JSON.stringify(this.varResult));
        var contacts = this.varResult;
        for(var key in contacts){
            console.log('is this'+contacts[key].Id);
         if(contacts[key].Id===selectCon){     
            if(((contacts[key].MobilePhone)&&(contacts[key].Name)&&(contacts[key].Email))!=null) {  
        this.selectedContact = contacts[key].Id;
        this.mobile = contacts[key].MobilePhone;
        this.conName = contacts[key].Name;
        this.email  = contacts[key].Email;
        console.log(this.conMob);            
            }
            else{
                this.mobile = '';
                this.conName = '';
                this.email  = '';
            }
        }
        }  
    }
    else{
        this.mobile = '';
        this.conName = '';
        this.email  = '';
    }
       }

       */

       handleCancelContact(event){
        console.log(event.detail);
        //alert("cancel");
        this.newContForm=false;
       }

       callContactCreationForm(event){
        //alert("Add Button");
        //event.preventDefault();
        this.newContForm=true;
       }
      handleContactSelection(event){
          let selectedContact = event.target.value;
          this.contactVal=selectedContact;
          if(selectedContact){ 
            console.log('selectedContact'+this.selectedContact);           
              conlists({conatctId: selectedContact })
              .then(result => {
                  result.Email ? this.email = result.Email : this.email = null;
                  result.MobilePhone ? this.mobile = result.MobilePhone : this.mobile= null;
                  result.Department__c ? this.Department = result.Department__c : this.Department= null;
                  result.Designation__c ? this.Designation = result.Designation__c: this.Designation= null;
  
              })
              .catch(error => {
                  this.error = error;
              })
          }
          else{
              
              this.email= ' ';
              this.mobile = ' ';
              this.Department= ' ';
              this.Designation = ' ';
              
              console.log('phone'+this.email);
  
          }
          
      }
fetchClusterValue(){

    
}

      handleAccountSelection(event){
        this.selectedAccount = event.target.value;
          if(this.selectedAccount){  
                        
              companyinformation({ RecordID: this.selectedAccount })
              .then(result => {
                console.log('testtttttttttttttttt1'+result);  
                console.log('contettttststssatastsatdf2'+JSON.stringify(result));
                var contacts = result.Contacts;
                console.log('result.Contacts :' + JSON.stringify(result.Contacts));
                clusterlists({stateValue:result.Territory__c})
                .then(result => {
                    let options1=[];
                    for(var key in result){
                     options1.push({label:result[key].Name,value: result[key].Id});
                     console.log(result[key].Name);  
                     }
                    this.clusterOptions = options1;
                    
          console.log('clusteroptions'+this.clusterOptions);  
                })
                .catch(error => {
                  this.error1 = error;
                  console.log('clusteroptionsError'+ this.error1); 
              })
          /*  for(var key in contacts){
                this.childOFCompany = contacts[key].Id;
                console.log('dsgsfdgfgfdg :' + JSON.stringify(this.childOFCompany));
            }*/
            let options=[];
            for(var key in contacts){
             options.push({label:contacts[key].Name,value: contacts[key].Id});
             console.log(contacts[key].Name);  
             }
            this.childOFCompany = options;
            console.log('conoptions'+this.childOFCompany);  

            
           /* if(this.conId.length>0){
             const newOptions = {label:this.showConName,value:this.showConId};
             this.childOFCompany=[...this.childOFCompany,newOptions]; 
            /}*/
                 // result.Website ? this.website= result.Website : this.website= null;
                  result.Phone ? this.Phone = result.Phone : this.Phone= null;
                  console.log('contrrddddddddddddd3ettttststssatastsatdf'+JSON.stringify(result.Phone));
                  result.Territory__c ? this.state = result.Territory__c : this.state= null;
                  result.State__c ? this.stateText = result.State__c : this.stateText= null;
                  result.Country__c ? this.country = result.Country__c : this.country= null;
                  //result.GST_Treatment__c ? this.gsttreatment = result.GST_Treatment__c : this.gsttreatment= null;
                  result.Cluster__c ? this.clusterValue = result.Cluster__c : this.clusterValue= null;
                  result.Cluster__r.Bio_Billing_State__c ? this.branch = result.Cluster__r.Bio_Billing_State__c : this.branch= null;
                  Contacts.MobilePhone ? this.MobilePhone = Contacts.MobilePhone : this.MobilePhone= null;
                  console.log('contrrddddddddddddd3ettttststssatastsatdf'+JSON.stringify(result.Phone));
                  if(result.Country__c=='India'){
                    this.isIndia=true;
                    this.isIndia1=false;
                  }
                  else if(this.country=='Other'){
                    this.isIndia=false;
                    this.isIndia1=true;
                  }
                  else{
                    this.isIndia=false;
                    this.isIndia1=false;
                  }

                 
                  
                })
              .catch(error => {
                  this.error = error;
              })
          }
          else{
              
              //this.website= null;
              this.Phone = '';
              this.childOFCompany='';
              this.email= ' ';
              this.mobile = ' ';
              this.Department= ' ';
              this.Designation = ' ';
              this.state = '';
              this.cluster='';
              this.country='';
              this.stateText='';
          }   
      }

      clusterHandleChange(event){
this.clusterValue=event.target.value;

      }

      msgFromContChild(event){
        console.log('Contact Created successfully '+event.detail);
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Success',
                message: 'Contact record has been created',
                variant: 'success',
            }),
        );
        
        
        if(event.detail){ 
          console.log('selectedContact'+this.contactVal);           
            conlists({conatctId: event.detail })
            .then(result => {
                result.Email ? this.email = result.Email : this.email = null;
                result.MobilePhone ? this.mobile = result.MobilePhone : this.mobile= null;
                result.Department__c ? this.Department = result.Department__c : this.Department= null;
                result.Designation__c ? this.Designation = result.Designation__c: this.Designation= null;
                this.childOFCompany.push({label:result.Name,value: result.Id});
                this.contactVal=event.detail;
                console.log('conoptions'+this.childOFCompany);  

            })
            .catch(error => {
                this.error = error;
            })
       // window.location.reload();
        }
       
      }
      handlePhoneValChange(event){
        this.Phone=event.target.value;
      }
      handlestatevalchange(event){
        this.state=event.target.value;

        clusterlists({stateValue:this.state})
        .then(result => {
            let options1=[];
            for(var key in result){
             options1.push({label:result[key].Name,value: result[key].Id});
             console.log(result[key].Name);  
             }
            this.clusterOptions = options1;
            
  console.log('clusteroptions'+this.clusterOptions);  
        })
        .catch(error => {
          this.error1 = error;
          console.log('clusteroptionsError'+ this.error1); 
      })
      }
      handleStateTextChange(event){
        this.stateText=event.target.value;
      }
      handleCountryValChange(event){
        this.country=event.target.value;
        if(this.country=='India'){
            this.isIndia=true;
            this.isIndia1=false;
          }
          else if(this.country=='Other'){
            this.isIndia=false;
            this.isIndia1=true;
  
          }
          else{
            this.isIndia=false;
            this.isIndia1=false;
          }
      }
      handleCancel(event){ 
        event.preventDefault();
        this.closeQuickAction();
       this[NavigationMixin.Navigate]({
              type: 'standard__objectPage',
              attributes: {
                  objectApiName: 'BiomatiQ_Lead__c',
                  actionName: 'list'
              },
              state: {
                 
                  filterName: 'Recent'
              }
          });
          return false;      
      }

      closeQuickAction() {
        this.dispatchEvent(new CloseActionScreenEvent());
    }
    handleinput(){
        if(this.loaded=true){
            this.loaded=false;
        }
    }
      handleSave()
          {
            
              console.log('handlesave');
              this.opportunityForm=true;
              this.saveAndNew = false;
              this.save=true;
              
              this.handleRecordSave(); 
          }
      handleSaveAndNew(){
          this.saveAndNew = true;
          this.opportunityForm=true;
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
      handleoppButtonError(e){
        alert(JSON.stringify(e));
      }
      handleSuccess(event) {
        //alert(this.opportunityForm);
        this.loaded = false;
        if(this.opportunityForm){
          if(this.saveAndNew ){
              this.oppIdVal = event.detail.id; 
              this.handleReset();
              this.dispatchEvent(
                  new ShowToastEvent({
                      title: 'Success',
                      message: 'Opportunity record has been created',
                      variant: 'success',
                  }),
              );
this.handleContactUpdate(this.oppIdVal);
              
            
          } else{
            this.oppIdVal = event.detail.id; 
        
              this.dispatchEvent(
                  new ShowToastEvent({
                      title: 'Success',
                      message: 'Opportunity record has been created',
                      variant: 'success',
                  }),
                 
              );
             this.handleContactUpdate(this.oppIdVal);
              this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'BiomatiQ_Lead__c',
                    actionName: 'list'
                },
                state: {
                   
                    filterName: 'Recent'
                }
            });
          }
          }  
          }
//Update Contact Record Id in Opportunity
          handleContactUpdate(event){
             
                // Create the recordInput object
                const fields = {};
                fields[ID_FIELD.fieldApiName] = this.oppIdVal;
                if(this.contactVal){
                fields[CONTACT_FIELD.fieldApiName] = this.contactVal;
                }
                if(this.clusterValue){
                fields[Cluster_FIELD.fieldApiName] = this.clusterValue;
                }
                const recordInput = { fields };
    
                updateRecord(recordInput)
                    .then(() => {
                       console.log("Contact Id updated in opportunity");
                       if(this.save){
                        this[NavigationMixin.Navigate]({
                            type: 'standard__objectPage',
                            attributes: {
                                objectApiName: 'BiomatiQ_Lead__c',
                                actionName: 'list'
                            },
                            state: {
                               
                                filterName: 'Recent'
                            }
                        });
                    }
                    })
                    .catch(error => {
                     console.log("Error occured while update opportunity ");
                    });
                
           
          }
         
      handleRecordSave(event) {
        console.log('handleRecordSave');
        this.loaded=true;
      event.preventDefault(); 
       
       
        this.fields = event.detail.fields;
          this.template.querySelector('lightning-record-edit-form').submit(this.fields);
          
         getRecordNotifyChange([{recordId: this.recordId}]);
          
        
      }
      handleDeptChange(event){
        this.Department=event.target.value;
      }
      handleDesignationChange(event){
        this.Designation=event.target.value;
      }
      handleMobileChange(event){
        this.MobilePhone=event.target.value;
      }
      handleEmailChange(event){
        this.email=event.target.value;
      }
}