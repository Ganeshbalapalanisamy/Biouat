import { LightningElement,api,track} from 'lwc';
import opportunity from '@salesforce/schema/BiomatiQ_Lead__c';
import companyinformation from '@salesforce/apex/Companydetailautofetch.companyinformation';
import fetchvalues from '@salesforce/apex/existingopportunity.opportunityinformation';
import updateVisit from '@salesforce/apex/existingopportunity.updateVisitRec';
import conlists from '@salesforce/apex/Companydetailautofetch.conlists';
import { getRecordNotifyChange, RecordFieldDataType } from 'lightning/uiRecordApi';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';

export default class existingopportunity extends NavigationMixin(LightningElement) {
  @api visitid;
  @api Openexistingmodal=false;
  objApi = opportunity;
  @track loaded = false;
   website;
   phone;
    email;
    mobile;
    Department;
    Designation;
    actionables;
    company;
    leadsource;
    quotenumber;
    contact;
    referral;
    revivalcollegue;
    referalcompany;
    leadstatus;
    stageupdate;
    territory;
    branch;
    //urgent;
    //opportunitytimetoactionl;
    productcategory;
    modeldiscussed;
    instruments;
    regular;
    speciality;
    domain;
    value;
    rating;
    nextfollowup;
    quotenumber;
    ponumber;
    specificremarks;
    isStatus=false;
    isStatu1=false;
    isStatus2=false;
    isStatus3=false;
     selectedId;
     exisOppName;
save=false;lost=false;remarksForLost;
    statusCheck(event)
    {
        if(event.detail.value=='Customer Engagement')
        {
            this.isStatus=true;
           

        }
        else    if(event.detail.value=='Technical Close')
        {
          
            this.isStatus=true;
           
         
        }
        else      if(event.detail.value=='Quote Request')
        {
           
            this.isStatus=true;
            

        }
        else    if(event.detail.value=='Quote Sent')
        {
            
            this.isStatus=true;
        }
        else {
          
            this.isStatus=false;
        }

    }
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
    handleContactSelection(event){
        let selectedContact = event.target.value;
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
        
    }
    handleAccountSelection(event){
        let selectedAccount= event.target.value;
        if(selectedAccount){            
            companyinformation({ RecordID: selectedAccount })
            .then(result => {
                result.Website ? this.website= result.Website : this.website= null;
                result.Phone ? this.Phone = result.Phone : this.Phone= null;
            })
            .catch(error => {
                this.error = error;
            })
        }
        else{
            this.website= null;
            this.Phone = null;
        }
        
       
    }
               isIndia=false;
            isIndia1=false;

    handleCountryValChange(event){
       // this.country=event.detail.value;
      
        if(event.detail.value=='India'){
       
            this.isIndia=true;
            this.isIndia1=false;
          }
          else if(event.detail.value=='Other'){
            
            this.isIndia=false;
            this.isIndia1=true;
  
          }
          else{
        
            this.isIndia=false;
            this.isIndia1=false;
          }
    }
    handleCancelexisting(event){
        this.Openexistingmodal=false;
        return false;
    }

    handleinput(){
        if(this.loaded=true){
            this.loaded=false;
        }
    }
    handleLeadStatus(e){
        this.leadstatus=e.target.value;

        if(this.leadstatus=='Closed Lost'){
            this.lost=true;
        }
    }
    handleRemarksLost(event){
        this.remarksForLost=event.target.value;

    }
    handlesave()
        { 
             this.save=true;
            
            this.handleRecordSave();
           // this.Openexistingmodal=false;    
        }
    handleSuccess(event) {
        this.loaded = false;
        if(this.save=true){
        
            this.oppIdVal = event.detail.id; 
            
          //  this.handleReset();
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Opportunity record has been updated',
                    variant: 'success',
                }),
            );
            
            this.Openexistingmodal=false;



//update visitmanagement whether opportunity closed won/lost

if (this.leadstatus=='Closed Won'||this.leadstatus=='Closed Lost') {
    // Create the recordInput object
    updateVisit({visitId:this.visitid,Status:this.leadstatus,OppName:this.exisOppName})
    .then(result=>{
        console.log('Visitmanagement Updated');
    }).catch(error=>{
        console.log('error while update visit management'+error);
    });
    

}
        }
        }  
    handleRecordSave(event) {
        this.loaded=true;
     event.preventDefault(); 
        this.fields = event.detail.fields;
        this.template.querySelector('lightning-record-edit-form').submit(this.fields);
       getRecordNotifyChange([{recordId: this.recordId}]);
    }

    @api childExistingOpportnity(parentParam){
        this.Openexistingmodal=true;
        this.selectedId=parentParam.oppId;
      
        this.handlevaluesPopulate();
    }
    handlevaluesPopulate(){

        var selectedOpportunity= this.selectedId; 
        if(selectedOpportunity){            
            fetchvalues({ RecordID: selectedOpportunity })
            .then(result => {
                result.Actionables__c ? this.actionables= result.Actionables__c : this.actionables= null;
                result.Opportunity_Closing__c ? this.oppclosing = result.Opportunity_Closing__c : this.oppclosing= null;
                result.Company_Name__c ? this.company = result.Company_Name__c : this.company= null;
                result.Lead_Source__c ? this.leadsource = result.Lead_Source__c : this.leadsource= null;
                result.Contact__c ? this.contact = result.Contact__c : this.contact= null;
                result.Reffererl_through_Colleague__c ? this.referral = result.Reffererl_through_Colleague__c : this.referral= null;
                result.Referral_Company_Name__c ? this.referalcompany = result.Referral_Company_Name__c : this.referalcompany= null;
                result.Revival__c ? this.revivalcollegue = result.Revival__c : this.revivalcollegue= null;
                result.Department__c ? this.Department = result.Department__c : this.Department= null;
                 result.Country__c ? this.country  = result.Country__c : this.country = null;
                 result.Territory__c ? this.state  = result.Territory__c : this.state = null;
                 result.Cluster_Lookup__c ? this.cluster  = result.Cluster_Lookup__c : this.cluster = null;
                 result.State_Province__c ? this.stateText  = result.State_Province__c : this.stateText = null;
                result.Lead_Status__c ? this.leadstatus = result.Lead_Status__c : this.leadstatus= null;
                result.Designation__c ? this.Designation = result.Designation__c : this.Designation= null;
                result.Stage_Update__c ? this.stageupdate = result.Stage_Update__c : this.stageupdate= null;
                result.Website__c ? this.website = result.Website__c : this.website= null;
                result.Territory__c ? this.territory = result.Territory__c : this.territory= null;
               // result.Urgent__c ? this.urgent = result.Urgent__c : this.urgent= null;
                result.Mobile__c ? this.mobile = result.Mobile__c : this.mobile= null;
               // result.Opportunity_Time_to_Action__c ? this.opportunitytimetoactionl = result.Opportunity_Time_to_Action__c : this.opportunitytimetoactionl= null;
                result.Email__c ? this.email = result.Email__c : this.email= null;
                result.Phone__c ? this.phone = result.Phone__c : this.phone= null;
                result.Opportunity_Product_Category__c ? this.productcategory = result.Opportunity_Product_Category__c : this.productcategory= null;
                result.Product_Category_Model_Discussed__c ? this.modeldiscussed = result.Product_Category_Model_Discussed__c : this.modeldiscussed= null;
                result.Instrument_Brands_Lead__c ? this.instruments = result.Instrument_Brands_Lead__c : this.instruments= null;
                result.Regular_Brands_Lead__c ? this.regular = result.Regular_Brands_Lead__c : this.regular= null;
                result.Speciality_Brands_Lead__c ? this.speciality = result.Speciality_Brands_Lead__c : this.speciality= null;
                result.Domain__c ? this.domain = result.Domain__c : this.domain= null;
                result.	PONumber__c ? this.ponumber = result.	PONumber__c : this.ponumber= null;
                result.QuoteNumber__c ? this.quotenumber = result.QuoteNumber__c : this.quotenumber= null;
                result.Value__c ? this.value = result.Value__c : this.value= null;
                result.Opportunity_Next_Follow_up__c ? this.nextfollowup = result.Opportunity_Next_Follow_up__c : this.nextfollowup= null;
                result.Opportunity_Specific_Remarks__c ? this.specificremarks = result.Opportunity_Specific_Remarks__c : this.specificremarks= null;
                result.Rating__c ? this.rating = result.Rating__c : this.rating= null;
                result.Branch__c?this.branch=result.Branch__c:this.branch=null;
                result.Name?this.exisOppName=result.Name:this.exisOppName=null;

                if(this.leadsource=='Referral - Through colleague')
                {
                    this.ischeck=true;
                    this.ischeck1=false; 
                    this.ischeck2=false;
                }
                else   if(this.leadsource=='Referral - Through principal company')
                {
                    this.ischeck1=true; 
                    this.ischeck=false;
                    this.ischeck2=false;
                }
                else   if(this.leadsource=='Revival-Through Colleague')
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


                
      /*  if(this.productcategory=='Instrumentation')
        {
            this.insAction=true; 
            this.insAction1=false; 
            this.insAction2=false;
        }
        else if (this.productcategory=='Regular Essentials') {
            this.insAction1=true; 
            this.insAction=false; 
            this.insAction2=false;
        }
        else if (this.productcategory=='Specialty Products') {
            this.insAction2=true; 
            this.insAction=false; 
            this.insAction1=false;
        }
         else {
            this.insAction1=false; 
            this.insAction=false; 
            this.insAction2=false;
        }*/

        if(this.country=='India'){
            this.isIndia=true;
           // this.isIndia1=false;
          }
          else if(this.country=='Other'){
            this.isIndia=false;
          //  this.isIndia1=true;
  
          }
          else{
            this.isIndia=false;
           // this.isIndia1=false;
          }

            })
            .catch(error => {
                this.error = error;
            })
        }
        else{
            this.actionables= null;
            this.oppclosing = null;
            this.company = null;
            this.website=null;
            this.phone=null;
            this.email=null;
            this.mobile=null;
            this.Department=null;
            this.Designation=null;
            this.actionables=null;
            this.company=null;
            this.leadsource=null;
            this.quotenumber=null;
            this.contact=null;
            this.referral=null;
            this.revivalcollegue=null;
            this.referalcompany=null;
            this.leadstatus=null;
            this.stageupdate=null;
            this.territory=null;
           //this.urgent=null;
            //this.opportunitytimetoactionl=null;
            this.productcategory=null;
            this.modeldiscussed=null;
            this.instruments=null;
            this.regular=null;
            this.speciality=null;
            this.domain=null;
            this.value=null;
            this.nextfollowup=null;
            this.rating=null;
            this.specificremarks=null;
            this.ponumber=null;
            this.quotenumber=null;

            
        }
        
    }


    handleExistOpperror(event){
        alert('Error :'+JSON.stringify(event.detail.detail));
    }
}