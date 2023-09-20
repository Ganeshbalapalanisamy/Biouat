import { LightningElement,api,track,wire} from 'lwc';
import opportunity from '@salesforce/schema/BiomatiQ_Lead__c';
import clusterlists from '@salesforce/apex/Companydetailautofetch.clusterlists';
import companyinformation from '@salesforce/apex/Companydetailautofetch.companyinformation';
import companyOppInsert from '@salesforce/apex/Companydetailautofetch.companyOppInsert';
import conlists from '@salesforce/apex/Companydetailautofetch.conlists';

import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';


export default class newCompanyOpp extends NavigationMixin(LightningElement) {
    @api recordId;
    @api showmodal=false;
    @api contactVal;
    @track selectedAccount;
    @track clusterValue;
    @track option2=[];
    @track clusterOptions;
    @track clusterId;
    @track loaded = false;
    error;
    error1;
    newContForm=false;
    objApi = opportunity;
    // website;
      ownerId='';
      Phone='';
      email='';
      mobile='';
      Department='';
      Designation='';
      isIndia;
      branch;
     //@track isIndia1=true;
      state='';
   //stateText='';
      cluster='';
      country='';
      Actionable;
      CompanyId='';
      opportunitySource;
      opportunityStage;
      Division;
      followUp;
      closeDate;
     
      //timeToAction;
     //priority;
      refferalColleague;
      Domain;
     // Instrument;
      //Regular;
    //SpecialBrand;
      CategoryModel;
      Value;
      SpecialRemark;
      Rating;
      RefCompanyName;
      Revival;
      //gsttreatment;
      isStatus=false;
      isStatu1=false;
      isStatus2=false;
      isStatus3=false;
      saveAndNew=false;
    //aj
      @track selectedAccount;
      @track childOFCompany;
   
      ischeck=false;
      ischeck1=false;
      ischeck2=false;
      handlechange(event)
      {
          if(event.detail.value=='Referral - Through colleague')
          { 
              this.opportunitySource=event.detail.value;
              this.ischeck=true;
              this.ischeck1=false; 
              this.ischeck2=false;
          }
          else   if(event.detail.value=='Referral - Through principal company')
          {
              this.opportunitySource=event.detail.value;
              this.ischeck1=true; 
              this.ischeck=false;
              this.ischeck2=false;
          }
          else   if(event.detail.value=='Revival-Through Colleague')
          {
              this.opportunitySource=event.detail.value;
              this.ischeck2=true; 
              this.ischeck=false;
              this.ischeck1=false;
          }
          else{
              this.opportunitySource=event.detail.value;
              this.ischeck1=false; 
              this.ischeck=false;
              this.ischeck2=false;
          }
      }
  
      //insAction=false;
     // insAction1=false;
      //insAction2=false;
      productchange(event)
      {
        this.Division=event.detail.value;
        /*  if(event.detail.value=='Instrumentation')
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
    
      
       
      
       @wire(companyinformation,{RecordID: '$recordId'})
       wiredQuote({data,error}){
        
        if(data){
            data.ownerId ? this.ownerId=data.ownerId : this.ownerId=null;
            data.Id ? this.CompanyId=data.Id:this.CompanyId=null;
            data.Phone ? this.Phone=data.Phone:this.Phone=null;
            data.Cluster__r.Name ? this.clusterValue=data.Cluster__r.Name:this.clusterValue=null;
            data.Territory__c ? this.state=data.Territory__c:this.state=null;
            data.Cluster__r.Bio_Billing_State__c ? this.branch = data.Cluster__r.Bio_Billing_State__c: this.branch= null;
           // data.State__c ? this.stateText = data.State__c : this.stateText= null;
                  data.Country__c ? this.country = data.Country__c : this.country= null;
           if( data.Country__c=='India'){
             this.isIndia=true;
           }
           else if(data.Country__c != 'India'){
           //  this.isIndia1=false;
           }
           else{
             this.isIndia=true;
            // this.isIndia1=true;

           }
           //clusters lists

           clusterlists({stateValue:this.state})
           .then(result => {
               let options1=[];
               for(var key in result){
                options1.push({label:result[key].Name,value: result[key].Name});
               this.option2.push({label:result[key].Name,value: result[key].Id});
                console.log(result[key].Name);  
                }
               this.clusterOptions = options1;
               
     console.log('this.clusterOptions==>'+JSON.stringify(this.clusterOptions));  
     console.log('this.option2==>'+JSON.stringify(this.option2));
     this.option2.forEach(acc =>{
      if(acc.label == this.clusterValue){
        this.clusterId=acc.value;
      }
     
      });

      console.log('this.clusterId==>'+this.clusterId);
           })
           .catch(error => {
             this.error1 = error;
             console.log('clusteroptionsError'+ this.error1); 
         })
        
        
      
          console.log('this.clusterValue==>'+this.clusterValue);
           //Contact Picklists
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
       showContact=false;
       hideCompobox=false;
      handleContactSelection(event){
          let selectedContact = event.target.value;
          this.contactVal=selectedContact;
        this.conatctId=selectedContact;
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
              this.ownerId='';
              this.email= ' ';
              this.mobile = ' ';
              this.Department= ' ';
              this.Designation = ' ';
              
              console.log('phone'+this.email);
  
          }
          this.hideCompobox=true;
          this.showContact=true;
      }
      
      handleAccountSelection(event){
        this.selectedAccount = event.target.value;
        this.CompanyId=this.selectedAccount;
        //alert('recordId'+this.recordId);
          if(this.selectedAccount){  
                     
              companyinformation({ RecordID: this.selectedAccount })
              .then(result => {
                console.log('testtttttttttttttttt1'+result);  
                console.log('contettttststssatastsatdf2'+JSON.stringify(result));
                var contacts = result.Contacts;
                console.log('dsgsfdgfgfdgtestt3 :' + JSON.stringify(result.Contacts));
         
            let options=[];
            for(var key in contacts){
             options.push({label:contacts[key].Name,value: contacts[key].Name});
             console.log(contacts[key].Name);  
             }
            this.childOFCompany = options;
            console.log('conoptions'+this.childOFCompany);  

            
         
                 
                  result.Phone ? this.Phone = result.Phone : this.Phone= null;
                  console.log('contrrddddddddddddd3ettttststssatastsatdf'+JSON.stringify(result.Phone));
                  result.Territory__c ? this.state = result.Territory__c : this.state= null;
                     // result.State__c ? this.stateText = result.State__c : this.stateText= null;
                  result.Country__c ? this.country = result.Country__c : this.country= null;
                  //result.GST_Treatment__c ? this.gsttreatment = result.GST_Treatment__c : this.gsttreatment= null;
                  result.Cluster__r.Name ? this.clusterValue = result.Cluster__r.Name : this.clusterValue= null; 
                  result.Cluster__r.Bio_Billing_State__c ? this.branch = result.Cluster__r.Bio_Billing_State__c: this.branch= null;
                  Contacts.MobilePhone ? this.MobilePhone = Contacts.MobilePhone : this.MobilePhone= null;
                  console.log('contrrddddddddddddd3ettttststssatastsatdf'+JSON.stringify(result.Phone));
                    if( result.Country__c=='India'){
             this.isIndia=true;
           }
           else if(result.Country__c=='Other'){
            // this.isIndia1=false;
           }else{
             this.isIndia=true;
             //this.isIndia1=true;

           }
                })
              .catch(error => {
                  this.error = error;
              })
              //cluster picklist
          clusterlists({stateValue:this.state })
           .then(result => {
               let options1=[];
               for(var key in result){
                options1.push({label:result[key].Name,value: result[key].Name});
                this.option2.push({label:result[key].Name,value: result[key].Id});
                console.log(result[key].Name);  
                }
               this.clusterOptions = options1;
               this.option2.forEach(acc =>{
                if(acc.label == this.clusterValue){
                  this.clusterId=acc.value;
                }
               
                });
          
               
     console.log('clusteroptions'+this.clusterOptions);  
           })
           .catch(error => {
             this.error1 = error;
             console.log('clusteroptionsError'+ this.error1); 
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
            //  this.stateText='';
          }   



      }
      handlePhoneValChange(event){
        this.Phone=event.target.value;
      }
      handlestatevalchange(event){
        this.state=event.target.value;
      //cluster value
        clusterlists({stateValue:this.state})
        .then(result => {
            let options1=[];
            for(var key in result){
             options1.push({label:result[key].Name,value: result[key].Id});
             this.option2.push({label:result[key].Name,value: result[key].Id});
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
        console.log('this.country====>'+this.country);
        if(this.country=='India'){
          this.isIndia=true;
          //this.isIndia1=true;
        }
        else if(this.country !='India'){
        //  this.isIndia1=false;
          this.isIndia=false;

        }else{
             this.isIndia=true;
            // this.isIndia1=true;

           }
      }
     /* handleStateTextChange(event){
        this.stateText=event.target.value;
      }*/
      handleCancel(event){ 
       
        //var redUrl ="https://biomatiq--biouat.lightning.force.com/lightning/r/Account/"+this.recordId+"/view";
       // window.location.assign(redUrl);
       // window.open(redUrl);
       window.history.back();
               
      }
      save=false;
      handleSave(event)
          {
console.log(event.target.value);
//alert(this.closeDate)
           /* let inputDate = this.template.querySelector(".dateCmp");
            let dateValue = inputDate.value;
            var d1 = new Date(dateValue);
            var today = new Date();
            if (!dateValue) {
              inputDate.setCustomValidity("complete this field!");
          }
          
          else if(d1==today || d1>today)
          {
             inputDate.setCustomValidity("Enter Today's or Future Datetoday");
          }
          
          else {
              inputDate.setCustomValidity("");
          }
          inputDate.reportValidity();

          let inputDate1 = this.template.querySelector(".closeDate");
          let dateValue1 = inputDate1.value;
          var d2 = new Date(dateValue1);
          if (!dateValue1) {
            inputDate1.setCustomValidity("complete this field!");
        }
        else if(d2>d1)
        {
           inputDate1.setCustomValidity("Opportunity Closing Date Cannot be Added Before Follow up Date and Greater than followup date");
        }
        
        else {
            inputDate1.setCustomValidity("");
        }
        inputDate1.reportValidity();*/
            //alert('Id==>'+this.CompanyId +'source==>'+this.opportunitySource+'stage==>'+this.opportunityStage+'Division==>'+this.Division +'Actionable'+this.Actionable+'followUp'+this.followUp+'CloseDate'+this.closeDate+'Remarks==>'+this.SpecialRemark);
           
            
            if(this.CompanyId !=null &&  this.opportunitySource !=null && this.opportunityStage !=null && this.Division !=null && this.Actionable !=null
                && this.followUp !=undefined  && this.closeDate !=undefined &&  this.SpecialRemark !=null){
                  this.loaded = true;
                  companyOppInsert({companyId:this.CompanyId,comPhone:this.Phone,country:this.country,state:this.state,contactId:this.conatctId,mobile:this.mobile,Email:this.email,Designation:this.Designation,Department:this.Department,
                  oppSource:this.opportunitySource,refCompanyName:this.RefCompanyName,Revival:this.Revival,Rating:this.Rating,
                  refcolleague:this.refferalColleague,domain:this.Domain,division:this.Division,oppstage: this.opportunityStage,
                  product:this.CategoryModel,oppValue:this.Value,actionable:this.Actionable,remarks:this.SpecialRemark,oppFollowup:this.followUp,oppClose:this.closeDate,clusterName:this.clusterId})
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
                 

             }else{
              this.loaded = false;
                alert('Please Check the Required Fields');

            }
          
             
             
          }
         
      handleSaveAndNew(event){

        if(this.CompanyId !=null &&  this.opportunitySource !=null && this.opportunityStage !=null && this.Division !=null && this.Actionable !=null
          && this.followUp !=undefined  && this.closeDate !=undefined &&  this.SpecialRemark !=null){
            console.log('this.clusterValue====>'+this.clusterValue);
            this.loaded = true;
            companyOppInsert({companyId:this.CompanyId,comPhone:this.Phone,state:this.state,contactId:this.conatctId,mobile: this.mobile,Email:this.email,Designation:this.Designation,Department:this.Department,
            oppSource:this.opportunitySource,refCompanyName:this.RefCompanyName,Revival:this.Revival,Rating:this.Rating,
            refcolleague:this.refferalColleague,domain:this.Domain,division:this.Division,oppstage:this.opportunityStage,
           product:this.CategoryModel,oppValue:this.Value,actionable:this.Actionable,remarks:this.SpecialRemark,oppFollowup:this.followUp,oppClose:this.closeDate,clusterName:this.clusterId})
            .then(result=>{
              this.loaded = false;
               console.log("resultId"+JSON.stringify(result.Id));
               alert('Opportunity Record is Created Successful!!!');
               const inputFields = this.template.querySelectorAll(
                'lightning-input-field'
            );
            if (inputFields) {
                inputFields.forEach(field => {
                field.reset();
                });
            }
              
            })
            .catch(error=>{
              this.loaded = false;
              alert('error'+JSON.stringify(error.body.message));
            })
           

       }else{
        
          alert('Please Check the Required Fields');

      }

         
           /* this.fields = event.detail.fields;
            this.template.querySelector('lightning-record-edit-form').submit(this.fields);*/
        //Reset Function
          
        
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

      
      handleContactSelection1(event){

        if(event.target.value){
         

        }else{
            this.hideCompobox=false;
            this.showContact=false;  
        }

      }
      callContactCreationForm(event){
        
        this.newContForm=true;
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
       // window.location.reload();
        let selectedContact = event.detail;
          this.contactVal=selectedContact;
        this.conatctId=selectedContact;
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
              this.ownerId='';
              this.email= ' ';
              this.mobile = ' ';
              this.Department= ' ';
              this.Designation = ' ';
              
              console.log('phone'+this.email);
  
          }
          this.hideCompobox=true;
          this.showContact=true;
      }

      handleCancelContact(event){
        console.log(event.detail);
        //alert("cancel");
        this.newContForm=false;
       }
       opportunityChangeHandler(event){
        this.opportunityStage=event.target.value;

       }
       changeActionableChange(event){

        this.Actionable=event.target.value;

       }
       changeOppfollUpHandler(event){
        
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
           let inputDate2 = this.template.querySelector(".dateCmp");
           inputDate2.reset();
        }else{
          this.followUp=event.target.value;

        }


       }
       changeCloseDateHandler(event){
        
        var d2 = new Date(event.target.value);
        var date2=d2.toISOString().slice(0,10);
       // alert('date2'+date2);
        //let inputDate = this.template.querySelector(".dateCmp");
        //let dateValue = inputDate.value;
        var d3 = this.followUp;
       // alert('followup'+d3);
        var today = new Date();
        let yyyyMmDd = today.toISOString().slice(0,10);
      //  alert(' yyyyMmDd '+ yyyyMmDd);
        if( date2 == d3 || date2 <yyyyMmDd || date2<d3){
          this.closeDate='';

            alert("Opportunity Closing Date Cannot be Added Before Follow up Date or Same.Please Enter Future Date");
            let inputDate1 = this.template.querySelector(".closeDate");
            inputDate1.reset();
        }else{
       
          this.closeDate=event.target.value;

        }

       }
       
       handleOwnerChange(event){
        this.ownerId=event.target.value;
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
       changeSpecialRemarkHandler(event){
        this.SpecialRemark=event.target.value;
       }
       handleRatingChange(event){
        this.Rating=event.target.value;
       }
       handleRefCompanyNameChange(event){
        
        this.RefCompanyName=event.target.value;
        
       }
       handleRevivalChange(event){
        //alert('this.Revival'+event.target.value);
        this.Revival=event.target.value;
       }

       clusterHandleChange(event){

        this.clusterValue=event.target.value;
        this.option2.forEach(acc =>{
          if(acc.label == this.clusterValue){
            console.log('event id==>'+acc.value);
            this.clusterId=acc.value;
          }
         
          });
        

       }

      
}