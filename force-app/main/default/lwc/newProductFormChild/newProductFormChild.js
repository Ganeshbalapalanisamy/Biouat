import { LightningElement,api,wire} from 'lwc';
import fetchLookupData from '@salesforce/apex/newproductFormController.fetchLookupData';
import fetchLookupDataSAC from '@salesforce/apex/newproductFormController.fetchLookupDataSAC';
const DELAY = 300;  //dealy apex callout timing in miliseconds  

export default class NewProductFormChild extends LightningElement {

        // public properties with initial default values 
        @api label = 'custom lookup label';
        @api placeholder = 'search...'; 
        @api iconName = 'standard:product';
        @api sObjectApiName = 'Product__c';
        @api defaultRecordId = '';
        @api productType=false;
        @api serviceType=false;
        // private properties 
        lstResult = []; // to store list of returned records   
        hasRecords = true; 
        searchKey=''; // to store input field value    
        isSearchLoading = false; // to control loading spinner  
        delayTimeout;
        selectedRecord = {}; // to store selected lookup record in object formate 
      
        // wire function property to fetch search record based on user input
        @wire(fetchLookupData, { searchKey: '$searchKey' , sObjectApiName : '$sObjectApiName' })
         searchResult(value) {
            const { data, error } = value; // destructure the provisioned value
            this.isSearchLoading = false;
            if (data) {
                 this.hasRecords = data.length == 0 ? false : true; 
                 this.lstResult = JSON.parse(JSON.stringify(data)); 

                 if(!this.hasRecords){
                    const sendNeHSN = new CustomEvent('newhsncode',
                    {
                        'detail': {newHSN: this.searchKey}
                    }
                
                );
                this.dispatchEvent(sendNeHSN);
                }
                 
             }
            else if (error) {
                console.log('(error---> ' + JSON.stringify(error));
             }
        };
           
      // update searchKey property on input field change  
        handleKeyChange(event) {
            // Debouncing this method: Do not update the reactive property as long as this function is
          
            // being called within a delay of DELAY. This is to avoid a very large number of Apex method calls.
         
            this.isSearchLoading = true;
            window.clearTimeout(this.delayTimeout);
            const searchKey = event.target.value;
            this.delayTimeout = setTimeout(() => {
            this.searchKey = searchKey;
            }, DELAY);
   
       
        }
        // method to toggle lookup result section on UI 
        toggleResult(event){
            const lookupInputContainer = this.template.querySelector('.lookupInputContainer');
            const clsList = lookupInputContainer.classList;
            const whichEvent = event.target.getAttribute('data-source');
            switch(whichEvent) {
                case 'searchInputField':
                    clsList.add('slds-is-open');
                   break;
                case 'lookupContainer':
                    clsList.remove('slds-is-open');    
                break;                    
               }
        }
       // method to clear selected lookup record  
       handleRemove(event){
        var hsnValue='';
        event.preventDefault();
        this.searchKey = '';    
        this.selectedRecord = {};
        this.lookupUpdatehandler(hsnValue); // update value on parent component as well from helper function 
        
        // remove selected pill and display input field again 
        const searchBoxWrapper = this.template.querySelector('.searchBoxWrapper');
         searchBoxWrapper.classList.remove('slds-hide');
         searchBoxWrapper.classList.add('slds-show');
         const pillDiv = this.template.querySelector('.pillDiv');
         pillDiv.classList.remove('slds-show');
         pillDiv.classList.add('slds-hide');
      }
      // method to update selected record from search result 
    handelSelectedRecord(event){   
        
         var objId = event.target.getAttribute('data-recid'); // get selected record Id 
         if(objId!=undefined){
         this.selectedRecord = this.lstResult.find(data => data.Id === objId); // find selected record from list 
         this.lookupUpdatehandler(this.selectedRecord); // update value on parent component as well from helper function 
         this.handelSelectRecordHelper(); // helper function to show/hide lookup result container on UI
    }
}
    /*COMMON HELPER METHOD STARTED*/
    handelSelectRecordHelper(){
        this.template.querySelector('.lookupInputContainer').classList.remove('slds-is-open');
         const searchBoxWrapper = this.template.querySelector('.searchBoxWrapper');
         searchBoxWrapper.classList.remove('slds-show');
         searchBoxWrapper.classList.add('slds-hide');
         const pillDiv = this.template.querySelector('.pillDiv');
         pillDiv.classList.remove('slds-hide');
         pillDiv.classList.add('slds-show');     
    }
    // send selected lookup record to parent component using custom event
    lookupUpdatehandler(value){  
          if(value!=undefined){
        const oEvent = new CustomEvent('lookupupdate',
        {
            'detail': {selectedRecord: value}
        }
    );
    this.dispatchEvent(oEvent);
    }

    
}


//-------SAC CODE lookup-----------------------
      // public properties with initial default values 
      @api iconNameSAC = '';
      @api defaultRecordIdSAC = '';
      // private properties 
      lstResultSAC = []; // to store list of returned records   
      hasRecordsSAC = true; 
      searchKeySAC=''; // to store input field value    
      isSearchLoadingSAC = false; // to control loading spinner  
      delayTimeoutSAC;
      selectedRecordSAC = {}; // to store selected lookup record in object formate 
    
      // wire function property to fetch search record based on user input
      @wire(fetchLookupDataSAC, { searchKey: '$searchKeySAC' , sObjectApiName : '$sObjectApiName' })
       searchResultSAC(value) {
          const { data, error } = value; // destructure the provisioned value
          this.isSearchLoadingSAC = false;
          if (data) {
               this.hasRecordsSAC = data.length == 0 ? false : true; 
               this.lstResultSAC = JSON.parse(JSON.stringify(data)); 

               if(!this.hasRecordsSAC){
                  const sendNewSAC = new CustomEvent('newsaccode',
                  {
                      'detail': {newSAC: this.searchKeySAC}
                  }
              
              );
              this.dispatchEvent(sendNewSAC);
              }
               
           }
          else if (error) {
              console.log('(error---> ' + JSON.stringify(error));
           }
      };
         
    // update searchKey property on input field change  
      handleKeyChangeSAC(event) {
          // Debouncing this method: Do not update the reactive property as long as this function is
        
          // being called within a delay of DELAY. This is to avoid a very large number of Apex method calls.
       
          this.isSearchLoadingSAC = true;
          window.clearTimeout(this.delayTimeoutSAC);
          const searchKey = event.target.value;
          this.delayTimeoutSAC = setTimeout(() => {
          this.searchKeySAC = searchKey;
          }, DELAY);
 
     
      }
      // method to toggle lookup result section on UI 
      toggleResultSAC(event){
        
          const lookupInputContainer = this.template.querySelector('.lookupInputContainer');
          const clsList = lookupInputContainer.classList;
          const whichEvent = event.target.getAttribute('data-source');
          switch(whichEvent) {
              case 'searchInputField':
                  clsList.add('slds-is-open');
                 break;
              case 'lookupContainer':
                  clsList.remove('slds-is-open');    
              break;                    
             }
      }
     // method to clear selected lookup record  
     handleRemoveSAC(event){
        event.preventDefault();
      this.searchKeySAC = '';    
      this.selectedRecordSAC = {};
      this.lookupUpdatehandler(event.target.value); // update value on parent component as well from helper function 
      
      // remove selected pill and display input field again 
      const searchBoxWrapper = this.template.querySelector('.searchBoxWrapper');
       searchBoxWrapper.classList.remove('slds-hide');
       searchBoxWrapper.classList.add('slds-show');
       const pillDiv = this.template.querySelector('.pillDiv');
       pillDiv.classList.remove('slds-show');
       pillDiv.classList.add('slds-hide');
    }
    // method to update selected record from search result 
  handelSelectedRecordSAC(event){   
      
       var objId = event.target.getAttribute('data-recid'); // get selected record Id 
       if(objId!=undefined){
       this.selectedRecordSAC = this.lstResultSAC.find(data => data.Id === objId); // find selected record from list 
       this.lookupUpdatehandlerSAC(this.selectedRecordSAC); // update value on parent component as well from helper function 
       this.handelSelectRecordHelperSAC(); // helper function to show/hide lookup result container on UI
  }
}
  /*COMMON HELPER METHOD STARTED*/
  handelSelectRecordHelperSAC(){
      this.template.querySelector('.lookupInputContainer').classList.remove('slds-is-open');
       const searchBoxWrapper = this.template.querySelector('.searchBoxWrapper');
       searchBoxWrapper.classList.remove('slds-show');
       searchBoxWrapper.classList.add('slds-hide');
       const pillDiv = this.template.querySelector('.pillDiv');
       pillDiv.classList.remove('slds-hide');
       pillDiv.classList.add('slds-show');     
  }
  // send selected lookup record to parent component using custom event
  lookupUpdatehandlerSAC(value){  
        if(value!=undefined){
      const sendSACToParent = new CustomEvent('lookupupdatesac',
      {
          'detail': {selectedRecordSAC: value}
      }
  );
  this.dispatchEvent(sendSACToParent);
  }
  }



    }