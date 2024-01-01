import { LightningElement, track, wire } from 'lwc';
import getCustomLookupAccount from '@salesforce/apex/AccountProviderLWC.getCustomLookupAccount';
 
export default class LwcAccountCustomLookup extends LightningElement {
    
 @track accountName='';
 @track accountList=[];
 @track objectApiName='Account';
 @track accountId;
 @track isShow=false;
 @track messageResult=false;
 @track isShowResult = true;
 @track showSearchedValues = false;
 @wire(getCustomLookupAccount,{actName:'$accountName'})
 retrieveAccounts ({error,data}){
     this.messageResult=false;
     if(data){
         console.log('raw data## ' + data);
         console.log('data## ' + data.length);
         if(data.length>0 && this.isShowResult){
            this.accountList =data;
            console.log('List of Account  inside true## ' + this.accountList);
            this.showSearchedValues=true;
            this.messageResult=false;
         }
         else if(data.length == 0){
            this.accountList=[];
            console.log('List of Account  inside false## ' + this.accountList);
            this.showSearchedValues=false;
            if(this.accountName != ''){
               this.messageResult=true;
            }
         }
         else if(error){
             this.accountId='';
             this.accountName='';
             this.accountList=[];
             this.showSearchedValues=false;
             this.messageResult=true;
         }
 
     }
 }
 
 
 
 searchHandleClick(event){
  this.isShowResult = true;
  this.messageResult = false;
}
 
 
searchHandleKeyChange(event){
  this.messageResult=false;
  this.accountName = event.target.value;
  console.log('## account name ',this.accountName)
}
 
parentHandleAction(event){        
    this.showSearchedValues = false;
    this.isShowResult = false;
    this.messageResult=false;
    //Set the parent calendar id
    this.accountId =  event.target.dataset.value;
    console.log('accountId::'+this.accountId);
    //Set the parent calendar label
    this.accountName =  event.target.dataset.label;      
    console.log('accounName::'+this.accountName);    
    const selectedEvent = new CustomEvent('selected', { detail: this.accountId });
        // Dispatches the event.
    this.dispatchEvent(selectedEvent);    
}
 
}