import { LightningElement,api,track,wire} from 'lwc';
import opportunity from '@salesforce/schema/BiomatiQ_Lead__c';
import clusterlists from '@salesforce/apex/Companydetailautofetch.clusterlists';
import companyinformation from '@salesforce/apex/Companydetailautofetch.companyinformation';
import contactList from '@salesforce/apex/Companydetailautofetch.contactList';
import conlists from '@salesforce/apex/Companydetailautofetch.conlists';
import companyOppInsert from '@salesforce/apex/Companydetailautofetch.companyOppInsert';
import { getRecordNotifyChange, RecordFieldDataType } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class newContactOpp extends NavigationMixin(LightningElement) {
    @api recordId;
    @api showmodal=false;
    
    objApi = opportunity;
    // website;
      CompanyId='';
      Phone='';
      email='';
      mobile='';
      Department='';
      Designation='';
       state='';
  // stateText='';
      cluster='';
      country='';
     @track  isIndia;
     @track loaded = false;
      ContactId='';
      opportunitySource='';
      opportunityStage='';
      Division='';
      Actionable='';
      followUp;
      closeDate;
      SpecialRemark='';
      RefCompanyName;
      Revival;
      Rating;
      branch;
      //timeToAction;
      //priority;
      refferalColleague;
      Domain;
      //Instrument;
      //Regular;
      //SpecialBrand;
      CategoryModel;
      Value;
      //gsttreatment;
      isStatus=false;
      isStatu1=false;
      isStatus2=false;
      isStatus3=false;
      saveAndNew=false;
    //aj
      @track selectedAccount;
      @track childOFCompany;
      //cluster variable declaration
     @track  clusterValue;
     @track clusterOptions;
     @track clusterCondition=true;
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
            
              this.isStatus=false;alert
          }
  
      }*/
      ischeck=false;
      ischeck1=false;
      ischeck2=false;
      handlechange(event)
      {
        this.opportunitySource=event.target.value;
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
      //insAction2=false;
      productchange(event)
      {
        this.Division=event.target.value;
         /* if(event.detail.value=='Instrumentation')
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
      handleActionChange(event){
        this.Actionable=event.target.value;

      }
      handleOppNextChange(event){
       
        var d1 = new Date(event.target.value);
        var date=d1.toISOString().slice(0,10);
        //alert('date'+date);
        var today = new Date();
        let yyyyMmDd = today.toISOString().slice(0,10);
        //alert('yyyyMmDd'+yyyyMmDd);
        //var today = new Date();
        //this.date=today.toISOString();
        if(date<yyyyMmDd ){
           alert("Enter Today's or Future Date");
           let inputDate1 = this.template.querySelector(".dateCmp");
            inputDate1.reset();
        }else{
          this.followUp=event.target.value;

        }
      }
      handleClosingChange(event){
       
        var d2 = new Date(event.target.value);
        var date2=d2.toISOString().slice(0,10);
        //alert('date2'+date2);
        //let inputDate = this.template.querySelector(".dateCmp");
        //let dateValue = inputDate.value;
        var d3 = this.followUp;
       // alert('followup'+d3);
        var today = new Date();
        let yyyyMmDd = today.toISOString().slice(0,10);
        //alert(' yyyyMmDd '+ yyyyMmDd);
        
        if( date2 == d3 || date2 <yyyyMmDd || date2<d3){
            alert("Opportunity Closing Date Cannot be Added Before Follow up Date or Same.Please Enter Future Date");
            let inputDate2 = this.template.querySelector(".closeDate");
            inputDate2.reset();
        }else{
          this.closeDate=event.target.value;

        }
      }
      handleRemarksChange(event){
        this.SpecialRemark=event.target.value;
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
      
       
      
       @wire(conlists,{conatctId: '$recordId'})
       wiredQuote({data,error}){
        
        if(data){
            data.Id ? this.ContactId=data.Id:this.ContactId=null;
           
            data.AccountId ? this.CompanyId=data.AccountId:this.CompanyId=null;
           // data.Account.Clusters__c ? this.cluster=data.Account.Clusters__c:this.cluster=null;
            data.Account.Territory__c ? this.state=data.Account.Territory__c:this.state=null;
            data.Account.Phone ? this.Phone=data.Account.Phone:this.Phone=null;
            data.Account.Country__c ? this.country=data.Account.Country__c:this.country=null;
           // data.Account.State__c ? this.stateText=data.Account.State__c:this.stateText=null;

            data.Email ? this.email = data.Email : this.email = null;
            data.MobilePhone ? this.mobile = data.MobilePhone : this.mobile= null;
            data.Department__c ? this.Department = data.Department__c : this.Department= null;
            data.Designation__c ? this.Designation = data.Designation__c: this.Designation= null;

            //invoke companyInfo apex
            

           if( data.Account.Country__c == 'India'){
             this.isIndia=true;
           }
           else if(data.Account.Country__c != 'India'){
            // this.isIndia1=false;
           }else{
             this.isIndia=true;
           //  this.isIndia1=true;
           }
           //cluster Value
           clusterlists({stateValue:this.state})
           .then(result => {
               let options1=[];
               for(var key in result){
                options1.push({label:result[key].Name,value: result[key].Id});
                console.log(result[key].Name);  
                }
               this.clusterOptions = options1;
               this.selectedAccount=this.CompanyId;
            if(this.selectedAccount){
            this.companyInfo();
            }
              console.log('stateclusteroptions'+this.clusterOptions);  
           })
           .catch(error => {
             this.error1 = error;
             console.log('stateclusteroptionsError'+ this.error1); 
         })
   

           
        }else{
           
            console.log('error'+error);
        }

       }

    handleOppStage(event){
        this.opportunityStage=event.target.value;

    }

      handleContactSelection(event){
          let selectedContact = event.target.value;
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

      companyInfo(){
        companyinformation({ RecordID: this.selectedAccount })
        .then(result => {
          console.log('testtttttttttttttttt1'+result);  
          console.log('contettttststssatastsatdf2'+JSON.stringify(result));
          var contacts = result.Contacts;
          console.log('dsgsfdgfgfdgtestt3 :' + JSON.stringify(result.Contacts));
    
      let options=[];
      for(var key in contacts){
       options.push({label:contacts[key].Name,value: contacts[key].Id});
       console.log(contacts[key].Name);  
       }
      this.childOFCompany = options;
      console.log('conoptions'+this.childOFCompany);  

            result.Phone ? this.Phone = result.Phone : this.Phone= null;
      
            result.Territory__c ? this.state = result.Territory__c : this.state= null; 
            result.Country__c ? this.country = result.Country__c : this.country= null;
           // result.State__c ? this.stateText = result.State__c : this.stateText= null;
           result.Cluster__c ? this.clusterValue = result.Cluster__c : this.clusterValue= null; 
           result.Cluster__r.Bio_Billing_State__c ? this.branch = result.Cluster__r.Bio_Billing_State__c: this.branch= null;
           // Contacts.MobilePhone ? this.MobilePhone = Contacts.MobilePhone : this.MobilePhone= null;
       
             if( result.Country__c=='India'){
       this.isIndia=true;
     }
     else if(result.Country__c !='India'){
     //  this.isIndia1=false;
     }else{
       this.isIndia=true;
      // this.isIndia1=true;
     }
     //cluster Value

     clusterlists({stateValue:this.state})
     .then(result => {
         let options1=[];
         for(var key in result){
          options1.push({label:result[key].Name,value: result[key].Id});
          console.log(result[key].Name);  
          }
         this.clusterOptions = options1;
         
        console.log('stateclusteroptions'+this.clusterOptions);  
     })
     .catch(error => {
       this.error1 = error;
       console.log('stateclusteroptionsError'+ this.error1); 
   })
   
  })
        .catch(error => {
            this.error = error;
        })
      }

      handleAccountSelection(event){
        
        this.selectedAccount = event.target.value;
        this.CompanyId=event.target.value;
        //alert('recordId'+this.recordId);
          if(this.selectedAccount){  
                     
             this.companyInfo();
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
          }   
      }
      handlePhoneValChange(event){
        this.Phone=event.target.value;
      }
      handlestatevalchange(event){
        this.state=event.target.value;
        //Cluster Value
        clusterlists({stateValue:this.state})
           .then(result => {
               let options1=[];
               for(var key in result){
                options1.push({label:result[key].Name,value: result[key].Id});
                console.log(result[key].Name);  
                }
               this.clusterOptions = options1;
               
              console.log('stateclusteroptions'+this.clusterOptions);  
           })
           .catch(error => {
             this.error1 = error;
             console.log('stateclusteroptionsError'+ this.error1); 
         })
      }
       handleCountryValChange(event){
        this.country=event.target.value;
        if(this.country=='India'){
          this.isIndia=true;
         //  this.isIndia1=true;
        }
        else if(this.country !='India'){
         // this.isIndia1=false;
          this.isIndia=false;

        }else{
          this.isIndia=true;
         // this.isIndia1=true;
        }
      }
    /*  handleStateTextChange(event){
        this.stateText=event.target.value;
      }*/
      handleCancel(event){ 

        
        /*event.preventDefault();
       this[NavigationMixin.Navigate]({
              type: 'standard__objectPage',
              attributes: {
                  objectApiName: 'BiomatiQ_Lead__c',
                  actionName: 'list'
              },
              state: {
                 
                  filterName: 'Recent'
              }
          });*/
          window.history.back();
          
          //return false;      
      }
    /* handleSubmit(event){
       // event.preventDefault();       // stop the form from submitting
       const fields = event.detail.fields;
       // fields.Cluster_Lookup__c=this.clusterValue;
        this.template.querySelector('lightning-record-edit-form').submit(fields);
     }*/
     //
      handleSave(event){
          // alert(this.cluster);
           // if(this.CompanyId !=null &&  this.opportunitySource !=null && this.opportunityStage !=null && this.Division !=null && this.Actionable !=null
            //    && this.followUp !=null  && this.closeDate !=null &&  this.SpecialRemark !=null)

           // alert('Id==>'+this.CompanyId +'source==>'+this.opportunitySource+'stage==>'+this.opportunityStage+'Division==>'+this.Division +'Actionable'+this.Actionable+'followUp'+this.followUp+'CloseDate'+this.closeDate+'Remarks==>'+this.SpecialRemark);
           if(this.CompanyId !='' && this.opportunitySource !='' && this.opportunityStage !='' && this.opportunityStage !='' && this.Division !='' && this.Actionable !='' && this.followUp !=undefined && this.closeDate !=undefined){
            //Apex Class

            this.loaded = true;
            companyOppInsert({companyId:this.CompanyId,comPhone:this.Phone,country:this.country,state:this.state,contactId:this.recordId,mobile:this.mobile ,Email:this.email,Designation:this.Designation,Department:this.Department,
              oppSource:this.opportunitySource,refCompanyName:this.RefCompanyName,Revival:this.Revival,Rating:this.Rating,
              refcolleague:this.refferalColleague,domain:this.Domain,division:this.Division,oppstage: this.opportunityStage,
              product:this.CategoryModel,oppValue:this.Value,actionable:this.Actionable,remarks:this.SpecialRemark,oppFollowup:this.followUp,oppClose:this.closeDate,clusterName:this.clusterValue})
              .then(result=>{
                 console.log("resultId"+JSON.stringify(result.Id));
                 this.loaded = false;
                 alert('Opportunity Record is Created Successful!!!');
                 
                 window.location.assign('/'+this.recordId);
              })
              .catch(error=>{
                this.loaded = false;
                alert('error'+JSON.stringify(error.body.message));
              })
           
           /*   this.fields = event.detail.fields;
          // fields.Cluster_Lookup__c=this.clusterValue;
            const inputFields = this.template.querySelectorAll(
            'lightning-input-field' );

        if ( inputFields) {
          inputFields.forEach(field => {
                console.log('Field is==> ' + field.fieldName);
                console.log('Field is==> ' + field.value);
            });
        }
        try{
            this.template.querySelector('lightning-record-edit-form').submit(this.fields);
        }
        catch(error){
          alert(JSON.stringify(error));

        }

             alert('Opportunity Record is Successfully Created!!!  1223');
              this.saveAndNew = false;
           
             window.location.assign('/'+this.recordId);
            // this.handleRecordSave(); */
}
else{
    alert("Please fill the required fields");
}
          }
      
          
       /* handleSuccess(event){
            const updatedRecord = event.detail.id;
            alert('onsuccess: '+updatedRecord);
      }*/

      handleSaveAndNew(event){
          this.saveAndNew = true;
          if(this.CompanyId !='' && this.opportunitySource !='' && this.opportunityStage !='' && this.opportunityStage !='' && this.Division !='' && this.Actionable !='' && this.followUp !=undefined && this.closeDate !=undefined){
            
            //Apex Class

          this.loaded = true;
            companyOppInsert({companyId:this.CompanyId,comPhone:this.Phone,country:this.country,state:this.state,contactId:this.recordId,mobile: this.MobilePhone,Email:this.email,Designation:this.Designation,Department:this.Department,
              oppSource:this.opportunitySource,refCompanyName:this.RefCompanyName,Revival:this.Revival,Rating:this.Rating,
              refcolleague:this.refferalColleague,domain:this.Domain,division:this.Division,oppstage: this.opportunityStage,
              product:this.CategoryModel,oppValue:this.Value,actionable:this.Actionable,remarks:this.SpecialRemark,oppFollowup:this.followUp,oppClose:this.closeDate,clusterName:this.clusterValue})
              .then(result=>{
                this.loaded = false;
                 console.log("resultId"+JSON.stringify(result.Id));
                 alert('Opportunity Record is Created Successful !!!');
                 const inputFields = this.template.querySelectorAll(
                  'lightning-input-field'
              );
              if (inputFields) {
                  inputFields.forEach(field => {
                  field.reset();
                  });
              }
               //  window.location.assign('/'+this.recordId);
              })
              .catch(error=>{
                this.loaded = false;
                alert('error'+JSON.stringify(error.body.message));
              })
            
            
            
            
            
            
            
            
            
            
          //  this.fields = event.detail.fields;
               
           // this.template.querySelector('lightning-record-edit-form').submit(this.fields);
        //Reset Function
           
          }
            else{
                alert("Please fill the required fields");
            }
          //this.handleSave();
         // this.handleReset();   
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
      handleContactChange(event){
        this.ContactId=event.target.value;

      }

      clusterHandleChange(event){
        this.clusterValue=event.target.value;

       /* if(this.clusterValue !=null){

          this.clusterCondition=false;
          this.isIndia=false;
          this.cluster=event.target.value;

        }else{
          
        }*/
      }
     /* lookupClusterHandleChange(event){
         this.cluster=event.target.value;
         console.log('Lookup this.cluster==>'+this.cluster);
         if(this.cluster == null || this.cluster ==''){
          this.isIndia=true;
          this.clusterCondition=true;
         }
      }*/

      handleRefCompanyNameChange(event){
        
        this.RefCompanyName=event.target.value;
        
       }
       handleRevivalChange(event){
        //alert('this.Revival'+event.target.value);
        this.Revival=event.target.value;
       }
       handleRatingChange(event){
        this.Rating=event.target.value;
       }
      /* handleTimeToAction(event){
        this.timeToAction=event.target.value;
       }
       handlePriority(event){
        this.priority=event.target.value;
       }*/
       handleReferralColleague(event){
        this.refferalColleague=event.target.value;
       }
       handleDomainChange(event){
        this.Domain=event.target.value;
       }
      /* handleInstrumentChange(event){
        this.Instrument=event.target.value;
       }
       handleRegularChange(event){
        this.Regular=event.target.value;
       }
       handleSpecialBrandChange(event){
        this.SpecialBrand=event.target.value;
       }*/
       handleCategoryModelChange(event){
        this.CategoryModel=event.target.value;
       }
       handleValueChange(event){
        this.Value=event.target.value;
       }
}