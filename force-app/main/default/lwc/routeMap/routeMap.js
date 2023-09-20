import { LightningElement,api,track,wire } from 'lwc';
import { getRecord, getFieldValue } from 'lightning/uiRecordApi';
import { NavigationMixin } from "lightning/navigation";
import fetchRecord from '@salesforce/apex/RouteMapController.fetchLocationDetails';
export default class RouteMap extends NavigationMixin(LightningElement) {
   


    @api recordId;
    @api Startaddress='';//="12.8394876, 77.6630009";
    leads;
    error;
   // @api Endaddress="12.8365062, 77.6647948";
   @api waypoints;//="12.8365062, 77.6647948";
    @api Endaddress;//="12.8383982, 77.6480593";
    @api Endaddress1  ="12.835486, 77.659189";
    connectedCallback(){
     
      this.locationFetch();
    }
    locationFetch(e){
      
    fetchRecord({ recordId: this.recordId })
            .then(result => {
                this.leads = result;
                console.log("Fetch "+JSON.stringify(this.leads));
               // result.Description ? this.Endaddress1 = result.Description : this.Endaddress1 = '';
              
                result.Value[0] ? this.Startaddress =result.Value[0] : this.Startaddress = '';
                result.Value[1]  ? this.Endaddress =result.Value[1] : this.Endaddress = '';
           //alert(this.Startaddress+'end:'+this.Endaddress);
              })
            .catch(error => {
                this.error = error;
            });
          }
    navigateToMap(event) {
      
        event.stopPropagation();
        let routeMapUrl;
        const userLocationSet = new Set();
        const accountLocationSet = new Set();
        const accountLocationSet1 = new Array();
        accountLocationSet1.push(this.Endaddress);
        accountLocationSet1.push(this.Endaddress1);
        userLocationSet.add(this.Startaddress);
        accountLocationSet.add(this.Endaddress);
       // accountLocationSet.add(this.Endaddress1);
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

            //Dynamic Locations
          /*  let fLen = accountLocationSet1.length;

            routeMapUrl = "https://www.google.com/maps/dir/"+ 
            Array.from(userLocationSet).join("+") +
            "/" ;
            for (let i = 0; i < fLen; i++) {
              routeMapUrl += "+"+accountLocationSet1[i] + "/";
            }
            routeMapUrl +=  "+"+Array.from(userLocationSet).join("+");*/

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