import { LightningElement,api,track,wire} from 'lwc';
import opportunity from '@salesforce/schema/BiomatiQ_Lead__c';
import companyinformation from '@salesforce/apex/Companydetailautofetch.companyinformation';
import clusterlists from '@salesforce/apex/Companydetailautofetch.clusterlists';
import contactList from '@salesforce/apex/Companydetailautofetch.contactList';
import { updateRecord } from 'lightning/uiRecordApi';
import conlists from '@salesforce/apex/Companydetailautofetch.conlists';
import { getRecordNotifyChange, RecordFieldDataType } from 'lightning/uiRecordApi';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import ID_FIELD from '@salesforce/schema/BiomatiQ_Lead__c.Id';
import CONTACT_FIELD from '@salesforce/schema/BiomatiQ_Lead__c.Contact__c';
import MOBILE_FIELD from '@salesforce/schema/BiomatiQ_Lead__c.Mobile__c';
import EMAIL_FIELD from '@salesforce/schema/BiomatiQ_Lead__c.Email__c';
import DEPART_FIELD from '@salesforce/schema/BiomatiQ_Lead__c.Department__c';
import DESIG_FIELD from '@salesforce/schema/BiomatiQ_Lead__c.Designation__c';

//import { CloseActionScreenEvent } from 'lightning/actions';

export default class NewOpportunity extends NavigationMixin(LightningElement) {
  @api recordId;
  @track isLoading = false;
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
      stateText='';
      cluster='';
      country='';
      branch;
      @api sourceVisit;
      isIndia=false;
      //isIndia1=false;
     newContForm=false;
     isStatus=false;
      isStatu1=false;
      isStatus2=false;
      isStatus3=false;
      saveAndNew=false;
      save=false;
      opportunityForm=false;
      @api contactVal;
       @api selectedAccount;
       @track childOFCompany;
       @track clusterValue;
       @track clusterOptions;
       @track orgCluster=false;
       @track cusCluster=false;
    //isStatus=false;
    //isStatu1=false;
    //isStatus2=false;
    //isStatus3=false;
     

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
  
    
    showContact=false;
    hideCompobox=false;
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

    //insAction=false;
    //insAction1=false;
   // insAction2=false;
    productchange(event)
    {
        
        /*if(event.detail.value=='Instrumentation')
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
        }*/

    }

    handleContactSelection1(event){

        if(event.target.value){

        }else{
            this.hideCompobox=false;
            this.showContact=false;  
        }

      }
    handleContactSelection(event){
        let selectedContact = event.target.value;
        this.contactVal=selectedContact;
        if(selectedContact){            
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
            this.email= null;
            this.mobile = null;
            this.Department= null;
            this.Designation = null;

        }
        this.hideCompobox=true;
        this.showContact=true;
        
    }

    @wire(companyinformation,{RecordID: '$selectedAccount'})
    wiredQuote({data,error}){
     
     if(data){
         data.ownerId ? this.ownerId=data.ownerId : this.ownerId=null;
         data.Id ? this.CompanyId=data.Id:this.CompanyId=null;
         data.Phone ? this.Phone=data.Phone:this.Phone=null;
         data.Cluster__c ? this.clusterValue=data.Cluster__c:this.clusterValue=null;
         data.Cluster__c ? this.cluster=data.Cluster__c:this.cluster=null;
         data.Cluster__r.Bio_Billing_State__c ? this.branch=data.Cluster__r.Bio_Billing_State__c:this.branch=null;
         data.Territory__c ? this.state=data.Territory__c:this.state=null;
         data.State__c ? this.stateText = data.State__c : this.stateText= null;
               data.Country__c ? this.country = data.Country__c : this.country= null;
              
        if(data.Cluster__c){
            this.cusCluster=true;
            this.orgCluster=true;  
        }
        if( data.Country__c=='India'){
          this.isIndia=true;
          //this.cusCluster=true;
        }
        else if(data.Country__c !='India'){
         // this.isIndia1=false;
        }
        else{
          this.isIndia=false;
         // this.isIndia1=true;

        }
          //clusters lists

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
            // this.error1 = error;
             console.log('clusteroptionsError'+ this.error1); 
         })

         //contact lists

         var contacts = data.Contacts;
        
         let options=[];
         for(var key in contacts){
          options.push({label:contacts[key].Name,value: contacts[key].Id});
          console.log(contacts[key].Name);  
          }
         this.childOFCompany = options;
         console.log('conoptions'+this.childOFCompany);
        
     }else{
         
         console.log('error'+error);
     }

    }
    
    
    
    
    handleAccountSelection(event){
        this.selectedAccount = event.target.value;
          if(this.selectedAccount){  
                        
              companyinformation({ RecordID: this.selectedAccount })
              .then(result => {
                console.log('testtttttttttttttttt1'+result);  
                console.log('contettttststssatastsatdf2'+JSON.stringify(result));
                var contacts = result.Contacts;
                console.log('dsgsfdgfgfdgtestt3 :' + JSON.stringify(result.Contacts));
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
                 result.Cluster__c ? this.cluster = result.Cluster__c : this.cluster= null;
                 result.Cluster__r.Bio_Billing_State__c ? this.branch = result.Cluster__r.Bio_Billing_State__c : this.branch= null;
                  Contacts.MobilePhone ? this.MobilePhone = Contacts.MobilePhone : this.MobilePhone= null;
                  console.log('contrrddddddddddddd3ettttststssatastsatdf'+JSON.stringify(result.Phone));
                  if(result.Country__c=='India'){
                    this.isIndia=true;
                    //this.cusCluster=true;
                   // this.isIndia1=false;
                  }
                  else if(this.country=='Other'){
                    this.isIndia=false;
                   // this.isIndia1=true;
                  }
                  else{
                    this.isIndia=false;
                    //this.isIndia1=false;
                  }
                  //clusters lists

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
            // this.error1 = error;
             console.log('clusteroptionsError'+ this.error1); 
         })
        //clusters Ends
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
             // this.cluster='';
              this.country='';
              this.stateText='';
              
          }   
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
       // this.contactVal=event.detail;
this.newContForm=false;
 let selectedContact = event.detail;
this.contactVal=selectedContact;
if(selectedContact){ 
  console.log('selectedContact'+this.selectedContact);           
    conlists({conatctId: selectedContact })
    .then(result => {
        result.Email ? this.email = result.Email : this.email = null;
        result.MobilePhone ? this.mobile = result.MobilePhone : this.mobile= null;
        result.Department__c ? this.Department = result.Department__c : this.Department= null;
        result.Designation__c ? this.Designation = result.Designation__c : this.Designation= null;

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
this.hideCompobox=true;
this.showContact=true;
        //window.location.reload();
      }
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

 handlePhoneValChange(event)
 {
        this.Phone=event.target.value;
      }

    handleCountryValChange(event){
        this.country=event.target.value;
        if(this.country=='India'){
            this.isIndia=true;
            //this.cusCluster=true;
           // this.isIndia1=false;
          }
          else if(this.country !='India'){
            this.isIndia=false;
           // this.isIndia1=true;
  
          }
          else{
            this.isIndia=false;
           // this.isIndia1=false;
          }
      }
      handleStateTextChange(event){
        this.stateText=event.target.value;
      }
      handlestatevalchange(event){
        this.state=event.target.value;
       // alert('state==>'+event.target.value);
         //cluster Lists
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
            // this.error1 = error;
             console.log('clusteroptionsError'+ this.error1); 
         })
      }
 
         
     clusterChange(event){
           //alert('org cluster==>'+event.target.value);
          // console.log('org cluster==>'+event.target.value);
         if(event.target.value){
            //this.cluster=event.target.value;  
          }else{
               this.cusCluster=false;
               this.orgCluster=false;
          }
          
      }
     handleCancel(event){ 
        //alert('cancel')
        this.showmodal=true;
         this.opportunityForm=false;
         this.saveAndNew = false;
              this.save=false;
        event.preventDefault();
       /* this.closeQuickAction();
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
          return false; */     
      }
       /*closeQuickAction() {
        this.dispatchEvent(new CloseActionScreenEvent());*/

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

      handleNewOpportError(e){
        alert(JSON.stringify(e));
      }
    handleSuccess(event) {
        this.loaded = false;
        if(this.save){
            this.oppIdVal = event.detail.id; 
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Opportunity record has been created',
                    variant: 'success',
                }),
            );
            this.handleContactUpdate(this.oppIdVal); 
            
        }else if(this.saveAndNew){
            this.oppIdVal = event.detail.id; 
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Opportunity record has been created',
                    variant: 'success',
                }),
            );
            this.handleContactUpdate(this.oppIdVal); 
           this.handleReset();
        }
        }   
    handleRecordSave(event) {
        this.loaded=true;
        event.preventDefault(); 
        this.fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(this.fields);
       getRecordNotifyChange([{recordId: this.recordId}]);
      
    }

 //Update Contact Record Id in Opportunity
 handleContactUpdate(event){
    if (this.contactVal) {
        const fields = {};
    fields[ID_FIELD.fieldApiName] = this.oppIdVal;
        fields[CONTACT_FIELD.fieldApiName] = this.contactVal;
        fields[EMAIL_FIELD.fieldApiName] = this.email;
        fields[MOBILE_FIELD.fieldApiName] = this.mobile;
        fields[DEPART_FIELD.fieldApiName] = this.Department;
        fields[DESIG_FIELD.fieldApiName] = this.Designation;

        
     
        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
               console.log("Contact Id updated in opportunity");
               if(this.save==true){
                this.showmodal=true;
               }
            })
            .catch(error => {
             console.log("Error occured while update opportunity ");
             console.log(error.detail)
            });
        }
    else {
        // The form is not valid
        
    
}
  }

handleDeptChange(event)
{
        this.Department=event.target.value;
      }
      handleDesignationChange(event)
      {
        this.Designation=event.target.value;
      }
      handleMobileChange(event)
      {
        this.MobilePhone=event.target.value;
      }
      handleEmailChange(event)
      {
        this.email=event.target.value;
      }

      clusterHandleChange(event){
           this.clusterValue=event.target.value;
           console.log('this.clusterValue===>'+this.clusterValue);

      if(event.target.value){
          this.cluster=event.target.value;
          this.orgCluster=true;
          this.cusCluster=true;
          
      }else{
         
      }


      }

     
}