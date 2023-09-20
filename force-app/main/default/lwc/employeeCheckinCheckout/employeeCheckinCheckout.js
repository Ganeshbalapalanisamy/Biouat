import { LightningElement,api,track,wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { getRecord } from 'lightning/uiRecordApi';
import setCheckin from '@salesforce/apex/EmployeeCheckinandCheckoutController.setCheckin';
import setCheckout from '@salesforce/apex/EmployeeCheckinandCheckoutController.setCheckout';
import checkDayIn from '@salesforce/apex/EmployeeCheckinandCheckoutController.checkDayIn';
import intervalLocation from '@salesforce/apex/EmployeeCheckinandCheckoutController.intervalLocation';
import CHECK_IN_ADDRESS from '@salesforce/schema/Daily_Activity_Report__c.CheckInaddress__c';
import CHECK_OUT_ADDRESS from '@salesforce/schema/Daily_Activity_Report__c.CheckoutAddress__c';
import parseJSONResponse from '@salesforce/apex/EmployeeCheckinandCheckoutController.parseJSONResponse';
import parseJSONResponse1 from '@salesforce/apex/EmployeeCheckinandCheckoutController.parseJSONResponse1';
import { NavigationMixin } from "lightning/navigation";
export default class EmployeeCheckinCheckout extends NavigationMixin(LightningElement) {
    connectedcallback(){

       // alert('hello');
      

       } 
    @track location = {};
    @track record;
     showButton=false;
    //startLocation
    orginlatitude;
    orginlongitude;
    Startaddress;
    //descLocation
     desclatitude;
     desclongitude;
     Endaddress;

     //setinterval variable assign
     setTimeInterval;
     intvallatitude;
     intvallongitude;
     booleanVal=false;
    //lstMarkers = [];
    zoomlevel = "12";
    lat1 = '';
    long1 = '';
    lat2 = '';
    long2 = '';
   
    @api recordId; 
    @api ObjectName;
    @api FieldSetName;
    @api objectApiName;
   
        objectApiNameInputValue='Daily_Activity_Report__c';
        lstMarkers=[];
        zoomlevel=12;
        @track lapp;
        @track data;
        @track error;

        connectedCallback() {
          // alert('I am run connectedcallback()');
          }

         /* @wire(checkDayIn)
         wiredFunctionName({error, data}) {
          
          
          // this.handleClick();
           if (data) {
            alert('Daycheckin'+JSON.stringify(data.Clock_in_Location__c));
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(position => {
                     setInterval(() => {
                        console.log('position.coords.latitude==>'+position.coords.latitude+';'+'position.coords.longitude==>'+position.coords.longitude);
                    
                     }, 5000);
                });
            }
           
        } else if (error) {
           console.log('error'+error);
          }
          }*/
        
      /*  @wire(getRecord, { recordId: '$recordId', fields: [CHECK_IN_ADDRESS,CHECK_OUT_ADDRESS] })
        wiredAccount({ error, data }) {
    if (data) {
        this.record = data;
       
    } else if (error) {
       console.log('error'+error);
      }
    }*/
         lstMarkers = [{
             location: {
                City: 'Hyderabad',
                Country:'India',
                State: 'Telangana',
                Street: ' Quthabullapur, 1386, Apuroopa Township, Oop.More Super market Satyavathi Park Avenue,Pragathi Nagar', 
            }
            }]

          
           
        handleClick(){
                if (navigator.geolocation) {
                    navigator.geolocation.getCurrentPosition(position => {
                        // Get the Latitude and Longitude from Geolocation API
                      this.orginlatitude = position.coords.latitude;
                      this.orginlongitude = position.coords.longitude;
        
                        //console.log(latitude);
                       // console.log(longitude);
                        this.location.latitude = position.coords.latitude;
                        this.location.longitude = position.coords.longitude;
                        this.lstMarkers = [{
                            location : {
                                Latitude: this.orginlatitude,
                                Longitude : this.orginlongitude
                            },
                        }];
                   
                        //setinterval functionality
                       
                        
                        this.zoomlevel = "16";
                            setCheckin({
                                objectApiName: this.objectApiNameInputValue,
                                lat1: this.location.latitude,
                                long1:this.location.longitude,  
                            }).then((result) => {

                            }).catch((error)=>{
                                console.log('error'+error);
                            });
                            const evt = new ShowToastEvent({
               
                                message: 'Successfully Clocked-In',
                                variant: 'success',
                                mode: 'dismissable'
                            });
                            this.dispatchEvent(evt);    
                        });  
                         //checkin Integration
                     /*    parseJSONResponse({
                             objectApiName: this.objectApiNameInputValue,
                              addr:this.orginlatitude,
                              addr1:this.orginlongitude,
                         }) .then((result) => {
                            // alert('checkin result==>'+result);
                            this.Startaddress=result;
                            //alert('checkin this.Startaddress===>'+this.Startaddress);
                               })
                          .catch((error) => {
                             this.error = error;
                          }); */
                
                                       
                
            }
     }
        checkouthandler(event) {
            if (navigator.geolocation) {
                navigator.geolocation.getCurrentPosition(position => {
                    // Get the Latitude and Longitude from Geolocation API
                  this.desclatitude= position.coords.latitude;
                  this.desclongitude = position.coords.longitude;
    
                    this.location.latitude = position.coords.latitude;
                    this.location.longitude = position.coords.longitude;
                    this.lstMarkers = [{
                        location : {
                            Latitude: this.desclatitude,
                            Longitude : this.desclongitude
                        },
                    }];

             
                          
                    this.zoomlevel = "16";
                    
                        setCheckout({
                            objectApiName: this.objectApiNameInputValue,
                            lat2: this.location.latitude,
                            long2:this.location.longitude,  
                        }).then((data) => {
                           // alert('Id'+data.Id);
                             this.recordId=data.Id;
                        }).catch((error) =>{
                            console.log(error);
                        });  
                         const evt = new ShowToastEvent({
               
                            message: 'Successfully Clocked-Out',
                            variant: 'success',
                            mode: 'dismissable'
                        }); 
                        this.dispatchEvent(evt);
                    });

                       //checkout Integration
                      parseJSONResponse1({
                        objectApiName: this.objectApiNameInputValue,
                        addr:this.desclatitude,
                        addr1:this.desclongitude,
                   }) .then((result) => {
                      // alert('checkoutresult==>'+result);
                      this.Endaddress=result;
                     // alert('checkoutthis.Startaddress===>'+this.Startaddress);
                         })
                    .catch((error) => {
                       this.error = error;
                    });
                    } 
                    this.showButton=true; 
                }

                navigateToMap(event) {
    event.stopPropagation();
    let routeMapUrl;
    const userLocationSet = new Set();
    const accountLocationSet = new Set();
    userLocationSet.add(this.Startaddress);
    accountLocationSet.add(this.Endaddress);

    if (
      userLocationSet &&
      userLocationSet.size > 0 &&
      accountLocationSet &&
      accountLocationSet.size > 0
    ) {
      routeMapUrl =
        "https://www.google.com/maps/dir/" +
        Array.from(userLocationSet).join("+") +
        "/" +
        Array.from(accountLocationSet).join("+");
    } else {
      //Error Toast to be shown
     // routeMapUrl = "https://www.google.com/maps";
    }

    this[NavigationMixin.Navigate]({
      type: "standard__webPage",
      attributes: {
        url: routeMapUrl
      }
    });
  }
            }