import { LightningElement, track, wire,api} from 'lwc';

import getProducts from '@salesforce/apex/AddProductsController.getProducts';
import getBrands from '@salesforce/apex/AddProductsController.getBrands';
import getBrandsByString from '@salesforce/apex/AddProductsController.getBrandsByString';
import oppDetails from '@salesforce/apex/AddProductsController.oppDetails';
import getProductsByString from '@salesforce/apex/AddProductsController.getProductsByString';
import saveProdListWithBrand from '@salesforce/apex/AddProductsController.saveProdListWithBrand';
//import getSelectedProducts from '@salesforce/apex/AddProductsController.getSelectedProducts';
import updateProducts from '@salesforce/apex/AddProductsController.updateProducts';
//import getProductListItem from '@salesforce/apex/AddProductsController.getProductListItem';
import getNewOrder1 from '@salesforce/apex/AddProductsController.getNewOrder1';
import deleteSelectedAccount from '@salesforce/apex/AddProductsController.deleteSelectedAccount';
import { NavigationMixin } from 'lightning/navigation';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import OppID_FIELD from '@salesforce/schema/BiomatiQ_Lead__c.Id';
import PriceBookField from '@salesforce/schema/BiomatiQ_Lead__c.Price_Book__c';
import { updateRecord } from 'lightning/uiRecordApi';
import getPriceBooks from '@salesforce/apex/AddProductsController.getPriceBooks';
import getPriceBooksEntries from '@salesforce/apex/AddProductsController.getAllPriceBookEntries';
import { refreshApex } from '@salesforce/apex';

  const columns = [
     {label: 'Product Name', fieldName: 'Name', type: 'Text'},
     {label: 'Brand Name', fieldName: 'Brand_Picklist__c',type: 'Text'},
     {label: 'Selling Price', fieldName: 'Selling_Price__c',type: 'Currency'},
     {label: 'LineItem', fieldName: 'LineItem__c',type: 'Text Area'},
     {label: 'Description', fieldName: 'Description__c',type:'Text'},
   ];

   const actions = [{ label: 'Delete', name: 'delete' }];
   const column= [];
      
      
export default class Addproducts extends NavigationMixin(LightningElement){

    @api recordId;
    @api objectname=getNewOrder1;
    @track SelectedData=[];
    @track data=[];
    @track branddata=[];
    @track myList;
  insertedProducts=[];

  insertedProductsSelected;
   productIdswithExclusivities=[];
   brands=[];
  gstlocation;
  priceBook;
  priceBookOptions=[];
  priceBookEntries;
  choosePriceBook=false;
   ids=[];
   idsdup=[];
   showProd=false;
    @track show=true;
    @track show1=true;
   @track selected=[];
    newSelectedList;
   ValSelected=false;
   //repeat=false;
   searchValue = '';
 
   col = columns;
   column=column;
   fldsItemValues = [];
   productLineItem=[];
   
oppRecord

//show&hide ProductName
    @track productShow=false;
//search operation for brands alone
    searchKeywordBrand(event){
        this.searchValue = event.target.value;
        var selectIds=this.ids;
        getBrandsByString({ searchValue: this.searchValue,brandIds:this.brands,selectIds:selectIds})
            .then((result) => {
                this.error = undefined;
                 if (result) {
	  let currentData1 = [];

            result.forEach((row) => {
                let rowData = {};
                rowData.Name = row.Name;
                // Brand data
                if (row.Brand_Name__c) {
                    rowData.Brand_Name__c = row.Brand_Name__c;
                 }

                // Accessories Line Item
                

                rowData.Id=row.Id;
             
                currentData1.push(rowData);
            });
          this.branddata = currentData1;
   
        event.preventDefault();
         
         console.log('currentData'+JSON.stringify(data)); 
    }

         
         else if (error) {
         console.log(error);
        
         }
            })
            .catch((error) => {
                this.error = error;
                
            });
    }

    //search operation for brand and products
    searchKeyword(event) {
    
        this.searchValue = event.target.value;
        var selectIds=this.ids;
        //this.repeat=false;
  getProductsByString({ searchValue: this.searchValue,proList:selectIds,productsExclusivities:this.productIdswithExclusivities})
            .then((result) => {
                this.contacts = result;
                this.error = undefined;
                 if (result) {

	  let currentData1 = [];
      let lineItem1=[];
     
            result.forEach((row) => {
                let sellingPriceTemp=0;
                for(var key in this.priceBookEntries){
                    if(row.Id== key){
                    sellingPriceTemp=this.priceBookEntries[key].Selling_Price__c;
                    }
                }
                let rowData = {};
                rowData.Name = row.Name;
                // Brand data
                if (row.Brand_Picklist__c) {
                    rowData.Brand_Picklist__c = row.Brand_Picklist__c;
                 }

                // Accessories Line Item
                if(row.Product_Lists__r !=null){
                    
                   row.Product_Lists__r.forEach(data =>{
                    if(data.Accessory__c){
                      lineItem1.push(data.Accessory__r.Name);
                    }
                   });
                    rowData.LineItem__c=lineItem1;
                    lineItem1=[];
                }else{
                    rowData.LineItem__c=null;

                }

                rowData.Id=row.Id;
               // rowData.Brand_Picklist__c = row.Brand_Picklist__c;
                rowData.Selling_Price__c=sellingPriceTemp;
                rowData.Description__c=row.Description__c;
                rowData.Model__c=row.Model__c;
                rowData.Cat_No__c=row.Cat_No__c;
                currentData1.push(rowData);
            });
          this.data = currentData1;
   
        event.preventDefault();
         
         console.log('currentData'+JSON.stringify(data)); 
    }

         
         else if (error) {
         console.log(error);
        
         }
            })
            .catch((error) => {
                this.error = error;
                this.contacts = undefined;
            });
    }
        @wire(oppDetails, { oppId:'$recordId' })
        wiredOpp({ error, data }) {
        if (data) {
            if(data.Lead_Status__c =="Yet to Tap" || data.Lead_Status__c =="Customer Engagement" || data.Lead_Status__c =="None"){
             //alert(data.Lead_Status__c);
             this.productShow=false;
            }else{
            this.productShow=true;
            if(data.Price_Book__c!=null){
            this.priceBook=data.Price_Book__r.Name;
            }
            else if(data.Price_Book__c==null){
                this.show=false;
                getPriceBooks().then((result=>{
                    for(const list of result){
                        const option = {
                            label: list.Name,
                            value: list.Id
                        };
                        // this.selectOptions.push(option);
                        this.priceBookOptions = [ ...this.priceBookOptions, option ];
                    }
                })).catch((error=>{
                    console.log(error.body.message)
                }))
                this.choosePriceBook=true;
            }
            }
           
        } else if (error) {
           
        }
    }

/*@wire(getproductterms, { recordId: '$recordId' })
    paymentterms;
    get payment(){


 return paymentterms.data.Company_Name__r.Payment_Term__c.value;
 
}

    ({data,error}){
        if (data) {
            alert('productItem'+JSON.stringify(data));
           switch (data.Company_Name__r.Payment_Term__c ){
                case 0: '100% Adv' 
                
                const columns = [
                    {label: 'Product Name', fieldName: 'Name', type: 'Text'},
                    {label: 'Brand Name', fieldName: 'Brand_Name_Text__c',type: 'Text'},
                    {label: 'Selling Price', fieldName: 'X100_Adv__c',type: 'Currency'},
                    {label: 'LineItem', fieldName: 'LineItem__c',type: 'Text Area'},
                    {label: 'Description', fieldName: 'Description__c',type:'Text'},
                  ];
               
                break;
                	 case 1:'50% Adv' 
                 pr.Selling_Price__c=pro.X50_Adv__c;
                
                break;
                 case 2:'30 days credit' 
                pr.Selling_Price__c=pro.X30_days_credit__c;
                break;

                case 3:'45 days credit' 
                 pr.Selling_Price__c=pro.X45_days_credit__c;
                 break;
                 case 4: '60 days credit'
                  pr.Selling_Price__c=pro.X60_days_credit__c;
                  break;
                  case 5:'90 days credit'
                  pr.Selling_Price__c=pro.X90_days_credit__c;
                  break;
                  case 6: '120 days credit'
                 pr.Selling_Price__c=pro.X120_days_credit__c;
                 break;
                 case 7:'Prod Selling Price'
                 pr.Selling_Price__c=pro.Selling_Price__c;
                 break;

                default: 
                  pr.Selling_Price__c=pro.Selling_Price__c;
                
              }
    }*/
	

    @wire(getProducts,{opportunityId:'$recordId'}) 
     wiredAccounts({data,error})
   {
         if (data) {
             //alert('data==>',data);
     
      let currentData = [];
      let lineItem=[];
       getPriceBooksEntries({oppId:this.recordId}).then((result=>{
        this.priceBookEntries=result;
    
            data.forEach((row) => {
let sellPricetemp=0;
                for (var key in result) {
                    if(key == row.Id){
                     console.log('key', key, result[key].Selling_Price__c);
                     sellPricetemp=result[key].Selling_Price__c;
                    }
                 }
                 console.log('sellPricetemp'+sellPricetemp)
                let rowData = {};
                 rowData.Name = row.Name;
                
                // Account related data
                if (row.Brand_Picklist__c) {
                    rowData.Brand_Picklist__c = row.Brand_Picklist__c;
                    console.log('brand'+rowData.Brand_Picklist__c);
                }
                rowData.Id=row.Id;
                this.productIdswithExclusivities.push(row.Id);
                // Accessories Line Item
                if(row.Product_Lists__r !=null){
                    
                   row.Product_Lists__r.forEach(data =>{
                    if(data.Accessory__c){
                      lineItem.push(data.Accessory__r.Name);
                    }
                   });
                    rowData.LineItem__c=lineItem;
                    lineItem=[];
                }else{
                    rowData.LineItem__c=null;

                }
               
                rowData.Selling_Price__c=sellPricetemp;
               rowData.Model__c=row.Model__c;
               rowData.Cat_No__c=row.Cat_No__c;
                rowData.Description__c=row.Description__c;
                currentData.push(rowData);
            });
    
          
            this.data = currentData;
        })).catch((error=>{
            console.log(error)
        }))
   }

         
         else if (error) {
         alert(error);
         }
    }

  
    @wire(getBrands,{opportunityId:'$recordId'}) 
    wiredBrands({data,error})
  {
        if (data) {
    
     let currentData = [];
   
           data.forEach((row) => {

               let rowData = {};
                rowData.Name = row.Name;
   
               if (row.Brand_Name__c) {
                   rowData.Brand_Name__c = row.Brand_Name__c;
                   console.log('brand'+rowData.Brand_Name__c);
               }
               rowData.Id=row.Id;
               this.brands.push(row.Id);
               currentData.push(rowData);  
           });
   
           this.branddata = currentData;
   }
        else if (error) {
        console.log(error);
        }
   }

 
   handleClick(){
      
         // this.ids = [...new Set(this.idsdup)];
         
if(this.ids==''){
    alert("Please Select products");
}
    else{
       getNewOrder1({recId:this.recordId,proid: JSON.stringify(this.ids),objectApiName:'Product_List__c',insertedProducts:this.insertedProducts})
     .then(result => {
         result.forEach(currentProd=>{
            this.gstlocation=currentProd.Opportunity__r.GST_Location__c;
             //this.gstlocation=currentProd.Opportunity__r.Local_Non_Local__c;
             this.selected.push(currentProd);
                this.insertedProducts.push(currentProd.Product__c);
               
         })
 
        // window.alert("this.result====>"+result);
        this.ValSelected=true;
        
           window.alert("Products added successfully");
          // window.history.back();
          // window.location.reload();
         
          if(this.gstlocation=='Intra State'){
              
  this.column= [
       {label: 'Product Name', fieldName: 'Product_Name_Text__c',type: 'Text'},
       {label: 'Brand Name', fieldName: 'Brand_Name_Text__c', type: 'Text'},
       { label: 'Selling Price', fieldName: 'Selling_Price__c',type:'Currency',editable: true},
       { label: 'Quantity', fieldName: 'Quantity__c',type:'Number',editable: true },
       { label: 'Discount', fieldName: 'Discount__c',type:'Percent',editable: true },
       { label: 'Discount Eligible', fieldName: 'Eligible_Discount__c',type:'Percent' },
       { label: 'CGST', fieldName: 'Cgst__c',type:'Percent',editable: true},
       { label: 'SGST', fieldName: 'SGST__c',type:'Percent',editable: true},
      // { label: 'BrandId', fieldName: 'Brand__c',type:'text' },
       {
         type: 'action',
         typeAttributes: { rowActions: actions },
       },
  ];
   }
           
           else if(this.gstlocation=='Inter State'){
                this.column= [
       {label: 'Product Name', fieldName: 'Product_Name_Text__c',type: 'Text'},
       {label: 'Brand Name', fieldName: 'Brand_Name_Text__c', type: 'Text'},
       { label: 'Selling Price', fieldName: 'Selling_Price__c',type:'Currency',editable: true},
       { label: 'Quantity', fieldName: 'Quantity__c',type:'Number',editable: true },
       { label: 'Discount', fieldName: 'Discount__c',type:'Percent',editable: true },
       { label: 'Discount Eligible', fieldName: 'Eligible_Discount__c',type:'Percent' },
       { label: 'IGST', fieldName: 'IGST__c',type:'Percent',editable: true},
      // { label: 'BrandId', fieldName: 'Brand__c',type:'text' },
      
       {
         type: 'action',
         typeAttributes: { rowActions: actions },
       },
  ];
  
   }
   else if(this.gstlocation=='No GST'){
   // window.alert("this.result====>"+result);
       this.selected=result;
       //alert('No GST Section'+JSON.stringify(this.selected));
        this.column= [
       {label: 'Product Name', fieldName: 'Product_Name_Text__c',type: 'Text'},
       {label: 'Brand Name', fieldName: 'Brand_Name_Text__c', type: 'Text'},
       { label: 'Selling Price', fieldName: 'Selling_Price__c',type:'Currency',editable: true},
       { label: 'Quantity', fieldName: 'Quantity__c',type:'Number',editable: true },
       { label: 'Discount', fieldName: 'Discount__c',type:'Percent',editable: true },
       { label: 'Eligible Discount', fieldName: 'Eligible_Discount__c',type:'Percent' },
      // { label: 'BrandId', fieldName: 'Brand__c',type:'text' },
      
       {
         type: 'action',
         typeAttributes: { rowActions: actions },
       },
  ];
   }else{
      
       
   }
   
  
  })
  .catch(error=>{
    
    alert('Error : '+JSON.stringify(error));
            
         
          })
            this.show=false; 
       }
   }

   handleSaveBrand(){

if(this.ids==''){
    alert("Please Select Brand");
}
    else{
        saveProdListWithBrand({recId:this.recordId,brandIds: JSON.stringify(this.ids)})
     .then(result => {
        window.location.assign('/'+this.recordId);
           window.alert("Brands added successfully");
  })
  .catch(error=>{
    
    alert('Error : '+JSON.stringify(error.body.message));

          })
            this.show=false; 
       }
   }

      closeModalAction(event){
         this.show=false;
        
       
       // window.history.back();
    
window.location.assign('/'+this.recordId);
   
       }
   
       changeHandler(){
         this.show=true;
    }
   
   handleSave(event) {
         const updatedFields = event.detail.draftValues;
   
   // Prepare the record IDs for getRecordNotifyChange()
   const notifyChangeIds = updatedFields.map(row => { return { "recordId": row.Id } });

   try {
       // Pass edited fields to the updateContacts Apex controller
       const result = updateProducts({data: updatedFields});
       console.log(JSON.stringify("Apex update result: "+ result));
       this.dispatchEvent(
           new ShowToastEvent({
               title: 'Success',
               message: 'Contact updated',
               variant: 'success'
           })
       );

       // Refresh LDS cache and wires
       getRecordNotifyChange(notifyChangeIds);

       // Display fresh data in the datatable
       refreshApex(this.selected).then(() => {
           // Clear all draft values in the datatable
           this.draftValues = [];
       });
  } catch(error) {
          this.dispatchEvent(
              new ShowToastEvent({
                  title: 'Error updating or refreshing records',
                  message: error.body.message,
                  variant: 'error'
              })
        );
   };
       const fields = {}; 
       fields[ID_FIELD.fieldApiName] = event.detail.draftValues[0].Id;
       fields[QUANTITY.fieldApiName] = event.detail.draftValues[0].Quantity;
     //  fields[DISCOUNT.fieldApiName] = event.detail.draftValues[0].Discount;
      

       const recordInput = {fields};

       updateRecord(recordInput)
       .then(() => {
           this.dispatchEvent(
               new ShowToastEvent({
                   title: 'Success',
                   message: 'ProductLineItem record created',
                   variant: 'success'
               })
           );
           // Display fresh data in the datatable
           return refreshApex(this.selected).then(() => {

               // Clear all draft values in the datatable
               this.draftValues = [];

           });
       }).catch(error => {
           this.dispatchEvent(
               new ShowToastEvent({
                   title: 'Error updating or reloading record',
                   message: error.body.message,
                   variant: 'error'
               })
           );
       });
   }
   saveHandleAction(event) {
       this.fldsItemValues = event.detail.draftValues;
       //alert(JSON.stringify(event.detail.draftValues));
       const inputsItems = this.fldsItemValues.slice().map(draft => {
           const fields = Object.assign({}, draft);
           return { fields };
       });
      // alert('inputsItems'+JSON.stringify(inputsItems));
     const promises = inputsItems.map(recordInput => updateRecord(recordInput));
       Promise.all(promises).then(result => {
           alert("Records Updated Successfully!!");
           this.selected=false;
           window.location.reload();
           this.dispatchEvent(
               new ShowToastEvent({
                   title: 'Success',
                   message: 'Records Updated Successfully!!',
                   variant: 'success'
               })

           );
           this.fldsItemValues = [];
           return this.refresh();
       }).catch(error => {
           alert(error.body.message);
           this.dispatchEvent(
               new ShowToastEvent({
                   title: 'Error',
                   message: 'An Error Occured!!',
                   variant: 'error'
               })
           );
       }).finally(() => {
           //this.fldsItemValues = [];
       });
   }
   
   async refresh() {
       await refreshApex(this.selected);

window.location.assign('/'+this.recordId);

   }
firstTime=true;
handleRowActions(event){
    
     var idval=event.target.value;
   
     
if(this.firstTime){
 
    if(this.ids.includes(idval)){
      

        this.idsdup = this.idsdup.filter(value => value !== idval);
         this.ids = this.ids.filter(value => value !== idval);
        
       this.firstTime=false;
    }
    
    else{
        this.idsdup.push(idval);
       this.ids = [...new Set(this.idsdup)];
       this.firstTime=false;
      
    }
}else{
    
      this.firstTime=true;
       
   }
}
           
          
      
       

   //repeat=true;
   
      /* var selectedRecords =this.template.querySelector("lightning-datatable").getSelectedRows(); 
        //alert('selectedRecords'+JSON.stringify(selectedRecords));
        selectedRecords.forEach(currentItem => {
           // alert(currentItem.Id);
           this.idsdup.push(currentItem.Id);
           
        }); 
   
    event.preventDefault();*/
        


 
  handleRowActionProList(event) {

        const actionName = event.detail.action.name;
        const row = event.detail.row;

        console.log('row'+JSON.stringify(row));
        console.log('selected'+JSON.stringify(this.selected));
        switch (actionName) {
            case 'delete':
                this.handleDeleteRow(row.Id);
            break;
            default:
          }
 }

      handleDeleteRow(recordIdToDelete) {

       deleteSelectedAccount({recordIdToDelete:recordIdToDelete})
        .then(result =>{
           //alert('result'+JSON.stringify(result));
            alert('Product List Record is Successful Deleted!!!');
              /*const evt = new ShowToastEvent({
                 title: 'Success Message',
                 message: 'Record deleted successfully ',
                 variant: 'success',
                 mode:'dismissible'
               });
            this.dispatchEvent(evt);*/
            
           //return refreshApex(this.selected)
            this.newSelectedList =this.selected.filter((item) => item.Id !==recordIdToDelete);
            console.log('newSelectedList'+JSON.stringify(this.newSelectedList));

            this.selected=this.newSelectedList;
this.idsdup=[];
              this.selected.forEach(currentItem => {
           // alert(currentItem.Id);
           this.idsdup.push(currentItem.Product__c);
          
           
        }); 
        this.ids=this.idsdup;
 console.log('idsdup'+this.idsdup);
             console.log('SelectedList'+JSON.stringify(this.selected));

        })
      .catch(error => {
            this.error = error;
        });
 }
 backHandler(){
     this.searchValue='';


 var selectIds=this.ids;
        //this.repeat=false;
  getProductsByString({ searchValue: this.searchValue,proList:selectIds,productsExclusivities:this.productIdswithExclusivities})
            .then((result) => {
                this.contacts = result;
                this.error = undefined;
                 if (result) {

	  let currentData1 = [];
      
      result.forEach((row) => {
        let sellingPriceTemp=0;
        for(var key in this.priceBookEntries){
            if(row.Id== key){
            sellingPriceTemp=this.priceBookEntries[key].Selling_Price__c;
        }
        }
        let rowData = {};
        rowData.Name = row.Name;
        // Brand data
        if (row.Brand_Picklist__c) {
            rowData.Brand_Picklist__c = row.Brand_Picklist__c;
         }

        // Accessories Line Item
        if(row.Product_Lists__r !=null){
            
           row.Product_Lists__r.forEach(data =>{
            if(data.Accessory__c){
              lineItem1.push(data.Accessory__r.Name);
            }
           });
            rowData.LineItem__c=lineItem1;
            lineItem1=[];
        }else{
            rowData.LineItem__c=null;

        }

        rowData.Id=row.Id;
       // rowData.Brand_Picklist__c = row.Brand_Picklist__c;
        rowData.Selling_Price__c=sellingPriceTemp;
        rowData.Description__c=row.Description__c;
        rowData.Model__c=row.Model__c;
        rowData.Cat_No__c=row.Cat_No__c;
        currentData1.push(rowData);
                
            });
            console.log('currentData1'+currentData1);
          this.data = currentData1;
      
         console.log('currentData'+JSON.stringify(this.data)); 
    }

         
         else if (error) {
         console.log(error);
        
         }
            })
            .catch((error) => {
                this.error = error;
                this.contacts = undefined;
            });


    
     this.ValSelected=false;
     this.show=true;
     this.handlecheckval=false;
    // this.productShow="slds-show";
      
 }
 handlecheckval;
 allSelected(event){
     if(this.handlecheckval==true){
         this.handlecheckval=false;
   
     }
     else{
 this.handlecheckval=true;
 this.data.forEach(cuurentItem=>{
     this.idsdup.push(cuurentItem.Id);
 });
     }
 }

 handleShowHide(event){
    
     if(event.target.checked){
       //  this.productShow="slds-hide";

     }else{
        // this.productShow="slds-show";
     }


 }
cancelChanges(event){
    window.location.assign('/'+this.recordId);
}
handleOnselect(event){
    alert(event.target.value);

}
handleSelect(event){
    alert(event.target.value);
}


handleSavePriceBook(e){
    console.log('save')
    const fields = {}; 
    fields[OppID_FIELD.fieldApiName] = this.recordId;
    fields[PriceBookField.fieldApiName] = this.priceBook;
  //  fields[DISCOUNT.fieldApiName] = event.detail.draftValues[0].Discount;
   

    const recordInput = {fields};

    updateRecord(recordInput)
    .then(() => {
        alert('PriceBook updated successfully')
       
       window.location.reload();
    }).catch(error => {
        alert( error.body)  
    });
}
handlePriceBookChange(e){
    this.priceBook=e.target.value;
   
}
}