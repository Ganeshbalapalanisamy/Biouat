import { LightningElement,api,wire,track} from 'lwc';
import  contactInformation from '@salesforce/apex/VisitManagementForm.contactInformation';
export default class ContactVisitmanagement extends LightningElement {

//Variable Declaration
   @api recordId;
   opportunity;
   @track oppId;
  @track companyName;
  @track lookupShow=false;
  @track oppShow=false;
  contactId;
  
   @wire(contactInformation,{recId: '$recordId'})
   wiredVisit({data,error}){
    
    if(data){
       
        data.Id ? this.contactId=data.Id:this.contactId=null;
       
        data.AccountId ? this.companyName=data.AccountId:this.companyName=null;
       // data.Contact__c ? this.contactId=data.Contact__c:this.contactId=null;
       
     
      
       
    }else if(error){
       
        alert('e==>'+error.body.message);
    }

   }
@track cancel=false;
    handleCancel(event){
        this.cancel=true;
        event.preventDefault();  
        window.history.back();
        const inputFields = this.template.querySelectorAll(
        'lightning-input-field'
            );
        if (inputFields) {
            inputFields.forEach(field => {
            field.reset();
            });
        }
        return false;
    }
   oppHandler(event){
         
       
      this.opportunity=event.target.value;
      if(event.target.value ==''){
         
             this.lookupShow=false;
        this.oppShow=false;
           
      }
     // alert('this.opportunity'+this.opportunity);
        
    }
  
    handleSave(event){
          if(!this.cancel){
              
                 //send data to server side
            const fields = event.detail.fields;
            this.template.querySelector('lightning-record-edit-form').submit(fields);
            alert('Visit Management Record is Created');
            window.location.assign('/'+this.recordId);

           
              //alert('Please fill the Required fields');
         
          }
 }
    
    
  /*  handleSubmit(event){
        event.preventDefault();       // stop the form from submitting
       
        
     }
  
  
  handleSave(event){
        //event.preventDefault();
       this.fields = event.detail.fields;
       this.template.querySelector('lightning-record-edit-form').submit(this.fields);
       
        window.history.back();
        /
    }*/
    handleSaveAndNew(event){
       // this.fields = event.detail.fields;
       // this.template.querySelector('lightning-record-edit-form').reset();
        //this.fields.reset();
        if(!this.cancel){
            //send data to server side
       const fields = event.detail.fields;
       this.template.querySelector('lightning-record-edit-form').submit(fields);
       alert('Visit Management Record is Created');
       //window.location.assign('/'+this.recordId);
       const inputFields = this.template.querySelectorAll(
        'lightning-input-field'
        );
    if (inputFields) {
        inputFields.forEach(field => {
        field.reset();
        });
    }

      }else{
         alert('Please fill the Required fields');
      }

    }

    lookupRecord(event){
        
        if(event.detail.selectedRecord != undefined){
            // alert('Selected Record Value on Parent Component is ' +  JSON.stringify(event.detail.selectedRecord));
             
             this.oppId=event.detail.selectedRecord.Id;
             if(this.oppId){
                 this.lookupShow=true;
                 this.oppShow=true;
             }
           // alert('Id==>'+event.detail.selectedRecord.Id);
         }
    }
    appointmentChangeHandler(event){
       
        let d = new Date(event.target.value);
        let appoint = d.getFullYear()+'-'+(d.getMonth()+1)+'-'+d.getDate();
        let appointTime = d.getHours() + ":" + d.getMinutes();
        console.log('appoint==>'+appoint);
        console.log('appointTime==>'+appointTime);

        let date1 = new Date();
        let today = date1.getFullYear()+'-'+(date1.getMonth()+1)+'-'+date1.getDate();
        let todayTime = date1.getHours() + ":" + date1.getMinutes();

       console.log('today==>'+today);
       console.log('todayTime==>'+todayTime);
        //console.log('appoint==>'+d.toLocaleString());
      // let d1= new Date().toLocaleString();
     
       if(appoint<today && appointTime<=todayTime){
           alert('Appointment/Visit- Schedule Should be Current or Future Date');
       }else if(appoint==today && appointTime<todayTime ){
          alert('Appointment/Visit- Schedule Should be Current or Future Date');
       }

        
    }

   
}