/*
* @File Name          : locationTracker.js
* @Description        : Using GeoLocation Updating check-in and Checkout Location JS.
* @Author             : Karthick Ravi
* @Apex Class         : locationTrackerController
* @Apex Test Class    : locationTrackerControllerTest
* @Parent Component   : locationTracker.js
* @Child  Component   : checkOutForm.js
* @Last Modified By   : karthick.ravi@rudhrainfosolutions.com
* @Last Modified On   : 6/10/2022
* @Modification Log   : 
*==============================================================================
* Ver         Date                     Author            Modification
*==============================================================================
* 1.0    6/10/2022                 Karthick Ravi          Initial Version
*/
import { LightningElement,api,track,wire} from 'lwc';
import setLocation from "@salesforce/apex/locationTrackerController.setLocation1";
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import getvisitFieldValues from "@salesforce/apex/locationTrackerController.getvisitFieldValues";
import COMPANY from '@salesforce/schema/Visit_Management__c.Company__c';
import { getRecord, getFieldValue  } from 'lightning/uiRecordApi';
export default class CurrentLocation extends LightningElement {
    @track location = {};
    lstMarkers = [];
    zoomlevel = "12";
    lat1 = '';
    lat2 = '';
    @api objectApiName;
    @api latFieldApiName;
    @api longFieldApiName;
    @api recordId;
    @api getIdFromParent;
    @api getCompanyId;
    showSearchComponent = false;
    accName;
    mom;checkin;checkout;
    hidemodel=false;

    /*_title = 'Sample Title';
    message = 'Sample Message';
    variant = 'error';
    variantOptions = [
        { label: 'error', value: 'error' },
    ];*/
    @wire(getvisitFieldValues,{recordId1:'$recordId'}) 
    visitsvalues({error,data}){
        if(data){
            console.log(JSON.stringify(data));
            console.log(data.MOM__c);
            data.MOM__c?this.mom=data.MOM__c:this.mom=null;
            data.Check_In__c?this.checkin=data.Check_In__c:this.checkin='';
            data.Check_Out__c?this.checkout=data.Check_Out__c:this.checkout='';
        }
        else if(error){
            console.log(error);
        }
    }
    @wire(getRecord, { recordId: '$recordId', fields: ['Visit_Management__c.Company__c'] })
    wiredRecord({ data }) {
        if (data) {
         this.visit = data;
            this.accName = data.fields.Company__c.value;
           console.log('myaccountname'+this.accName);
        }
    }


    handleClick() {
        var fields = {};
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(position => {
                // Get the Latitude and Longitude from Geolocation API
                var latitude = position.coords.latitude;
                var longitude = position.coords.longitude;

                console.log( latitude);
                console.log( longitude);
                this.location.latitude = position.coords.latitude;
                this.location.longitude = position.coords.longitude;
                this.lstMarkers = [{
                    location : {
                        Latitude: latitude,
                        Longitude : longitude
                    },
                }];
                this.zoomlevel = "16";
               
                    setLocation({
                        objectApiName: this.objectApiName,
                        lat1: this.location.latitude,
                        long1:this.location.longitude,
                        recordId: this.recordId,
                        isCheckin: true
                       
                    }).then((result) => {
                    
                        eval("$A.get('e.force:refreshView').fire();");
                        if(result =='success'){

                            this.showToast('', 'Successfully Checked-In','success');
                        
                            const event1 = setTimeout(() => {
                                window.location.reload();
                              }, 3000);
    console.log('Checkin Success' +evt);
                       }
                        else
                        {
     
                            console.log(result)
                            this.showToast('Error', result,'error');
                            //this.showToast('Error', 'You cannot Check-In for Past/Future Appointments','error');
                    
                        }
                  })
.catch((error)=>{
   
                        console.log(JSON.stringify(error.body.pageErrors)+JSON.stringify(error.body.fieldErrors))///'Please enter valid data before click check-in'
//this.showToast('Error',JSON.stringify(error.body) ,'error');
 })
                   
                });         
        }
    }

    showToast(title, message, variant) {
        const toastEvent = new ShowToastEvent({
          title: title,
          message: message,
          variant: variant,
          mode:'dismissable',
          bubbles: true // Set bubbles to true
        });
        this.dispatchEvent(toastEvent);
      }

    checkoutclick(event) {
       // this.mom=event.detail;
       
        //debugger;
        if (navigator.geolocation) {
            navigator.geolocation.getCurrentPosition(position => {
                // Get the Latitude and Longitude from Geolocation API
                var latitude = position.coords.latitude;
                var longitude = position.coords.longitude;
                this.location.latitude = position.coords.latitude;
                this.location.longitude = position.coords.longitude;
                console.log( latitude);
                console.log( longitude);
                // Add Latitude and Longitude to the markers list.
                this.lstMarkers = [{
                    location : {
                        Latitude: latitude,
                        Longitude : longitude
                    }
                }];
                this.zoomlevel = "16";
                setLocation({
                    objectApiName: this.objectApiName,
                    lat1: latitude,
                    long1: longitude,
                    recordId: this.recordId,
                    isCheckin: false
                  //  mom:this.mom
                }).then((result) => {
                    eval("$A.get('e.force:refreshView').fire();");
                    if(result =='success'){
                    this.showToast('', 'Successfully Clocked-Out','success');
                        const event1 = setTimeout(() => {
                            window.location.reload();
                          }, 3000);
                        }
                        else{
 this.showToast('Error', result,'error');
                           // this.showToast('Error', "You cannot Check-In for Past/Future Appointments",'error');

                        }
                    } )
                    .catch((error) => {
                        alert(JSON.stringify(error.body));
                        //this.showToast('Error', "You can't save this record,Please verify all the fields",'error');

                      
 })

            })
               
           
        }

    }
    showclick() {
    
        if(this.checkin){
           

            if(this.checkout){
                this.showToast('Error', "You have already checked-out",'error');
            }

            else{
                this.showSearchComponent = true;
            }
            }
            else{
                this.showToast('Error', "Please first click check-in",'error');
             }
        }
    }