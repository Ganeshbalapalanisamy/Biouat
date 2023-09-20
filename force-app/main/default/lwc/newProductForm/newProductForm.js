import { LightningElement,api,wire,track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import { NavigationMixin } from 'lightning/navigation';
import fetchLookupData from '@salesforce/apex/newproductFormController.fetchLookupDataUnits';
import fetchProductsByCatNo from '@salesforce/apex/newproductFormController.fetchProductsByCatNo';
import fetchProdFamData from '@salesforce/apex/newproductFormController.fetchLookupDataProdFamily';
import fetchSubCategoryData from '@salesforce/apex/newproductFormController.fetchSubCategoryRecords';
import fetchSigngleCategoryData from '@salesforce/apex/newproductFormController.fetchSubCategoryRecord';
import { updateRecord } from 'lightning/uiRecordApi';

import Unit_FIELD from '@salesforce/schema/Product__c.Unit__c';
import HSNCODE_FIELD from '@salesforce/schema/Product__c.HSN_Code__c';
import SACCODE_FIELD from '@salesforce/schema/Product__c.SAC_Code__c';
import ProductFamily_FIELD from '@salesforce/schema/Product__c.Product_Family_Name__c';
import ID_FIELD from '@salesforce/schema/Product__c.Id';
//const DELAY = 300;  //dealy apex callout timing in miliseconds 
export default class NewProductForm extends NavigationMixin(LightningElement) {
  saveAndNew=false;
  save=false;
  cancel=false;
  hsnValue='';
  sacValue='';
  hsnValueText='';
  prodIdVal;
    closepage =true;
    currencyIso=false;
    costPriceOther;
    currencyValue;
    brandName;
    subcategory;
    SubCategoryVal;
    subCategoryOptions;
    segment;category;catNo;
    productType;accessory=false;
    @track purchaseDescription;
    @track sellingDescription;
    @api recordId;

    isHSNhasValue=false;
    isSAChasValue=false;
     // handel custom lookup component event 
     lookupRecord(event){
       // event.preventDefault();
        this.hsnValue= (event.detail.selectedRecord);
        this.hsnValueText=(event.detail.selectedRecord.HSN_Code__c);

        if(this.hsnValueText == undefined){
            this.hsnValueText ='';
        }
      // alert('Selected Record Value on Parent Component is ' +  JSON.stringify(event.detail.selectedRecord));
    }
    lookupRecordSAC(event){
         this.sacValue=(event.detail.selectedRecordSAC.SAC_Code__c);
     }
    setNewHsnValue(event){
        this.hsnValueText=event.detail.newHSN;
       // this.isHSNhasValue=true;
    }
    setNewSACValue(event){
        this.sacValue=event.detail.newSAC;
    }
    
    isInputValid() {
        let isValid = true;
        let inputFields = this.template.querySelectorAll('.validate');
        inputFields.forEach(inputField => {
            if(!inputField.checkValidity()) {
                inputField.reportValidity();
                isValid = false;
            }
            //this.contact[inputField.name] = inputField.value;
        });
        return isValid;
    }

    handleSave(event)
    {
        
        let nameCmp = this.template.querySelector(".combobox");
        if (!nameCmp.value) {
            nameCmp.setCustomValidity("Complete this field.");
        } else {
            nameCmp.setCustomValidity(""); // clear previous value
        }
        nameCmp.reportValidity();

         if(this.type=='Goods'){
             if(this.hsnValueText && /^\d+$/.test(this.hsnValueText)){
               
            } else{
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Error',
                            message: 'Please enter valid input in the HSN code ',
                            variant: 'error'
                        })
                    );
                    
                }
            }
            else if(this.type=='Service'){
                if(this.sacValue && /^\d+$/.test(this.sacValue)){
               
                } else{
                        this.dispatchEvent(
                            new ShowToastEvent({
                                title: 'Error',
                                message: 'Please enter valid input in the SAC code ',
                                variant: 'error'
                            })
                        );
                        
                    }
            }
            
        console.log('handlesave'+event.target.value);
            this.saveAndNew = false;
        this.save=true;
        this.cancel=false;

    
    
    }

    handleSavemouseOver(){
    if(this.type=='Goods'){
        this.isHSNhasValue=true;
    }
    if(this.type=='Service'){
       
        this.isSAChasValue=true;
    }
    this.isProdFamilyhasvalue=true;
    }
    handleSavemouseOut(){
        this.isHSNhasValue=false;
        this.isSAChasValue=false;
        this.isProdFamilyhasvalue=false;
    }
    handleSaveAndNew(event){

        let nameCmp = this.template.querySelector(".combobox");
        if (!nameCmp.value) {
            nameCmp.setCustomValidity("Complete this field.");
        } else {
            nameCmp.setCustomValidity(""); // clear previous value
        }
        nameCmp.reportValidity();
            console.log('handlesave& New'+event.target.value);
        this.saveAndNew = true;
        this.save=false;
        this.cancel=false;
      //  this.handleRecordSave();
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

    handleError(event){
        console.log('error '+JSON.stringify(event.detail));
       // alert(event.detail.detail);
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Error',
                message: "Can't save this record,Please enter valid data",
                variant: 'error',
            }),
           
        );
    }

    handleSuccess(event) {
        this.catNo='';this.type='';
        this.productTypeVal='';
        if(this.cancel==false){
        if(this.saveAndNew ){
            this.prodIdVal = event.detail.id; 
            
         // this.updateProduct(this.prodIdVal);
          this.dispatchEvent(
              new ShowToastEvent({
                  title: 'Success',
                  message: 'Product record has been created',
                  variant: 'success',
              }),
             
          );
          this.handleReset();
         
        } else if(this.save ){
          
            this.prodIdVal = event.detail.id; 
            this.dispatchEvent(
                new ShowToastEvent({
                    title: 'Success',
                    message: 'Product record has been created',
                    variant: 'success',
                }),
               
            );
            
            this[NavigationMixin.Navigate]({
                type: 'standard__objectPage',
                attributes: {
                    objectApiName: 'Product__c',
                    actionName: 'list'
                },
                state: {
                   
                    filterName: 'Recent'
                }
            });
           }
    }
        }
        
        
        handleRecordSave(event) {
            event.preventDefault(); 
    
                    this.fields = event.detail.fields;
                    this.template.querySelector('lightning-record-edit-form').submit(this.fields);
                   getRecordNotifyChange([{recordId: this.recordId}]);
      
              
            }
            
        
        
    /*  handleCancel()
     {
        this.closepage=false;
        window.location.assign('/'+this.recordId);
        
     }*/
     productTypeValue;
    productType=false;
serviceType=false;

    handleTypevalchange(event){
        this.type=event.target.value;
        if(this.type=='Goods'){
            this.productType=true;
            this.serviceType=false;
            this.productTypeValue='Goods';
        }
        else if(this.type=='Service'){
            this.productType=false;
            this.serviceType=true;
            this.productTypeValue='Service';
        }
        else{
           this.productType=false;
            this.serviceType=false; 
            this.productTypeValue='';
        }
    }

    habdleCatNOChange(e){
        this.catNo=e.target.value;

        fetchProductsByCatNo({catNo:this.catNo})
        .then((result)=>{
            if(result){
            console.log(JSON.stringify(result));
               alert("Duplicate found:\n"+'Id : '+result.Id+',Product : '+result.Name+'\n'+'Use different Cat.No. ');     

            }
        }).catch((error)=>{
console.log(error)
        })
    }

   handleCancel(event){
       this.cancel=true;
       event.preventDefault(); 
      
        this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Product__c',
                actionName: 'list'
            },
            state: {
               
                filterName: 'Recent'
            }
        });
        
        return false;
    }
    //-------custom lookup--------------------
    @api label = 'custom lookup label';
    @api placeholder = 'search units...'; 
    @api iconName = 'standard:product';
    @api sObjectApiName = 'Product__c';
    @api defaultRecordId = '';
    showUnitlookup=true;
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
               // alert(this.hasRecords)
                this.unitValue=this.searchKey;
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
      //  window.clearTimeout(this.delayTimeout);
        const searchKey = event.target.value;
       // this.delayTimeout = setTimeout(() => {
        this.searchKey = searchKey;
       // }, DELAY);


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

    event.preventDefault();
   this.searchKey = '';    
    this.selectedRecord = {};
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
handelSelectedRecord(event){   
    
     var objId = event.target.getAttribute('data-recid'); // get selected record Id 
     if(objId!=undefined){
     this.selectedRecord = this.lstResult.find(data => data.Id === objId); // find selected record from list 
     this.lookupUpdatehandler(this.selectedRecord); // update value on parent component as well from helper function 
     this.handelSelectRecordHelper(); // helper function to show/hide lookup result container on UI
    this.unitValue=this.selectedRecord.Unit__c;
     this.showUnitlookup=false;
    
}
}
unitValue='';
handleUnitChange(event){
    if(event.target.value!=''){
        this.unitValue=event.target.value;
    }
    else{
        this.showUnitlookup=true;
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



//--------Update HSN and Unit Code---------------------------
updateProduct() {
if(this.prodIdVal !=undefined){
        // Create the recordInput object

        const fields = {};
        fields[ID_FIELD.fieldApiName] = this.prodIdVal;
       // fields[HSNCODE_FIELD.fieldApiName] = this.hsnValueText;
       // fields[Unit_FIELD.fieldApiName] = this.unitValue;
        //fields[SACCODE_FIELD.fieldApiName] = this.sacValue;
        fields[ProductFamily_FIELD.fieldApiName] = this.ProdFamilyValue;
        const recordInput = { fields };

        updateRecord(recordInput)
            .then(() => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Success',
                        message: 'Product record has been created',
                        variant: 'success',
                    }),
                   
                );
                // Display fresh data in the form
               // return refreshApex(this.contact);
               if(this.save){
                
                this[NavigationMixin.Navigate]({
                    type: 'standard__objectPage',
                    attributes: {
                        objectApiName: 'Product__c',
                        actionName: 'list'
                    },
                    state: {
                       
                        filterName: 'Recent'
                    }
                });
               }
            })
            .catch(error => {
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error creating record',
                        message: error.body.message,
                        variant: 'error'
                    })
                );
            });
        }
    else {
        // The form is not valid
        this.dispatchEvent(
            new ShowToastEvent({
                title: 'Something is wrong',
                message: 'Check your input and try again.',
                variant: 'error'
            })
         );
    }
}


handleSellDescChange(event){
   
    this.sellingDescription=event.target.value;

    this.purchaseDescription=event.target.value;
}
handlePurchDescChange(e){
this.purchaseDescription=e.target.value;
}
handleBrandChange(event){
this.brandName=event.target.value;

    fetchSubCategoryData({brand:this.brandName})
    .then(result=> {

        let options=[];
        for(var key in result){
         options.push({label:result[key].Sub_Category__c,value: result[key].Id});
           
         }

this.subCategoryOptions=options;
this.SubCategoryVal='';
this.subcategory='';
this.template.querySelector('.segment').classList.remove('slds-show');
this.template.querySelector('.segment').classList.add('slds-hide');
this.template.querySelector('.subcombo').classList.add('slds-show');
this.template.querySelector('.subcombo').classList.remove('slds-hide');
    }).catch(error=>{
console.log('error'+error);
    })

}
handleSubCategorySelection(e)
{
    this.SubCategoryVal=e.detail.value;
    this.subcategory=e.detail.value;
    fetchSigngleCategoryData({subCategory:this.subcategory})
    .then(result=>{  
result.Segment__c?this.segment=result.Segment__c:this.segment='';
result.Category__c?this.category=result.Category__c:this.category='';
this.template.querySelector('.segment').classList.add('slds-show');
this.template.querySelector('.segment').classList.remove('slds-hide');
this.template.querySelector('.segment1').classList.add('slds-show');
this.template.querySelector('.segment1').classList.remove('slds-hide');
this.template.querySelector('.subcombo').classList.remove('slds-show');
this.template.querySelector('.subcombo').classList.add('slds-hide');
    }).catch(error=>{
        console.log('error'+error);
    })
}
handleSubCategory(e){
    this.SubCategoryVal='';
    this.subcategory=e.detail.value;
    this.template.querySelector('.segment').classList.remove('slds-show');
this.template.querySelector('.segment').classList.add('slds-hide');
this.template.querySelector('.segment1').classList.remove('slds-show');
this.template.querySelector('.segment1').classList.add('slds-hide');
this.template.querySelector('.subcombo').classList.add('slds-show');
this.template.querySelector('.subcombo').classList.remove('slds-hide');
}


 //-------Product Family Name custom lookup--------------------
 ProdFamilyValue='';
 isProdFamilyhasvalue=false;
 @api placeholderProdFam = 'search Product Family...'; 
 @api iconNameProdFam = 'standard:product';
 //@api sObjectApiName = 'Product__c';
 @api defaultRecordIdProd = '';
 // private properties 
 lstResultProdFam = []; // to store list of returned records   
 hasRecordsProdFam = true; 
 searchKeyProdFam=''; // to store input field value    
 isSearchLoadingProdFam = false; // to control loading spinner  
 delayTimeout;
 selectedRecordProdFam = {}; // to store selected lookup record in object formate 

 // wire function property to fetch search record based on user input
 @wire(fetchProdFamData, { searchKey: '$searchKeyProdFam' , sObjectApiName : '$sObjectApiName' })
  producFamilyResult(value) {
     const { data, error } = value; // destructure the provisioned value
     this.isSearchLoadingProdFam = false;
     if (data) {
          this.hasRecordsProdFam = data.length == 0 ? false : true; 
          this.lstResultProdFam = JSON.parse(JSON.stringify(data)); 
          

          if(!this.hasRecordsProdFam){
             //alert(this.hasRecordsProdFam)
             this.ProdFamilyValue=this.searchKeyProdFam;
            // alert(this.ProdFamilyValue)
          }
      }
     else if (error) {
         console.log('(error---> ' + JSON.stringify(error));
      }
 };
    
// update searchKey property on input field change  
handleKeyChangeProdFam(event) {
     // Debouncing this method: Do not update the reactive property as long as this function is
   
     // being called within a delay of DELAY. This is to avoid a very large number of Apex method calls.
  
     this.isSearchLoadingProdFam = true;
   //  window.clearTimeout(this.delayTimeout);
     const searchKey = event.target.value;
    // this.delayTimeout = setTimeout(() => {
     this.searchKeyProdFam = searchKey;
    // }, DELAY);


 }
 // method to toggle lookup result section on UI 
 toggleResultProdFam(event){
 
     const lookupInputContainerProd = this.template.querySelector('.lookupInputContainerProd');
     const clsList = lookupInputContainerProd.classList;
     const whichEvent = event.target.getAttribute('data-source');
     switch(whichEvent) {
         case 'searchInputFieldProdFam':
             clsList.add('slds-is-open');
            break;
         case 'lookupContainerProd':
             clsList.remove('slds-is-open');    
         break;                    
        }
 }
// method to clear selected lookup record  
handleRemoveProdFam(event){

 event.preventDefault();
this.searchKeyProdFam = '';    
 this.selectedRecordProdFam = {};
 
 // remove selected pill and display input field again 
 const searchBoxWrapperProd = this.template.querySelector('.searchBoxWrapperProd');
 searchBoxWrapperProd.classList.remove('slds-hide');
 searchBoxWrapperProd.classList.add('slds-show');
  const pillDivProd = this.template.querySelector('.pillDivProd');
  pillDivProd.classList.remove('slds-show');
  pillDivProd.classList.add('slds-hide');
}
// method to update selected record from search result 
handelSelectedRecordProdFam(event){   
 
  var objId1 = event.target.getAttribute('data-recid'); // get selected record Id 
  if(objId1!=undefined){
  this.selectedRecordProdFam = this.lstResultProdFam.find(data => data.Id === objId1); // find selected record from list 
  this.handelSelectRecordHelperProdFam(); // helper function to show/hide lookup result container on UI
 this.ProdFamilyValue=this.selectedRecordProdFam.Product_Family_Name__c;

}
}


/*COMMON HELPER METHOD STARTED*/
handelSelectRecordHelperProdFam(){
 this.template.querySelector('.lookupInputContainerProd').classList.remove('slds-is-open');
  const searchBoxWrapperProd = this.template.querySelector('.searchBoxWrapperProd');
  searchBoxWrapperProd.classList.remove('slds-show');
  searchBoxWrapperProd.classList.add('slds-hide');
  const pillDivProd = this.template.querySelector('.pillDivProd');
  pillDivProd.classList.remove('slds-hide');
  pillDivProd.classList.add('slds-show');     
}
// send selected lookup record to parent component using custom event
//Product Family Name lookup

//cost price currency
handleCurrencyValue(event){
    this.currencyValue=event.target.value;
    if(this.currencyValue=='USD - U.S. Dollar'){
        this.currencyIso=true;
        this.costPriceOther='$';
    }
    else{
        this.currencyIso=false;
    }
}
handlecostPriceOtherchange(event){
    //alert('hadlechange')
    this.costPriceOther=event.target.value;
}

mouseLeave(){
    this.costPriceOther='$'+this.costPriceOther
    
}
mouseenter(){
    this.costPriceOther = this.costPriceOther.replace('$','');
  
}

handleProductTypeChange(e){
    this.productTypeVal=e.target.value
    if(this.productTypeVal=='Accessory'){
        this.accessory=true;
    }else{
        this.accessory=false;
    }
}

}