import { LightningElement ,api,track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import setCheckout from '@salesforce/apex/Employeecheckoutcontroll.setCheckout';
export default class Employeecheckoutcontroll extends LightningElement {
    @track location = {};
    @api objectApiName;
    @api recordId;	
    lat1 = '';
    long1 = '';
    lstMarkers = [];
    zoomlevel = "12";
    objectApiNameInputValue='Daily_Activity_Report__c';
    checkouthandler() {
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
                setCheckout({
                    objectApiName: this.objectApiNameInputValue,
                    recordId: this.recordId,
                    lat1: this.location.latitude,
                    long1:this.location.longitude,  
                }).then(() => {
                });    
            });
        }

    }
}