import { LightningElement, track } from 'lwc';
import createNewAccount from '@salesforce/apex/AccountProviderLWC.createNewAccount';
import readAccountMethod from '@salesforce/apex/AccountProviderLWC.readAccountMethod';
import editAccountMethod from '@salesforce/apex/AccountProviderLWC.editAccountMethod';
import deleteAccountMethod from '@salesforce/apex/AccountProviderLWC.deleteAccountMethod';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class LWC_Class_5_Pract extends LightningElement {

    rating = 'none';
    @track accountObj= {'sobjectType':'Account'};
    connectedCallback() {
        console.log('accountObj',this.accountObj);
    }
    createAccountHandler(){
        console.log('accountObj',this.accountObj);
        this.accountObj.Name=this.template.querySelector('lightning-input[data-formfield="accountName"]').value
        // this.accountObj.Rating=this.template.querySelector('lightning-input[data-formfield="accountRating"]').value
        // this.accountObj.Type=this.template.querySelector('lightning-input[data-formfield="accountType"]').value
        this.accountObj.SLA__c=this.template.querySelector('lightning-input[data-formfield="accountSLA"]').value

        createNewAccount({objAcc : this.accountObj})
        .then((result)=> {
            this.result=result;
            this.error=undefined;
            this.showToast('SUCCESS', 'Created Succesfully', 'success');
            
        })
        .catch((error)=>{
            this.error=error;
            this.result=undefined;
            this.showToast('ERROR', error.message, 'error');
        });
    }
    readAccountHandler(){
        this.accountObj.Name=this.template.querySelector('lightning-input[data-formfield="accountName"]').value

        readAccountMethod({objAcc:this.accountObj})
            .then((result)=>{
                console.log(result)
                this.accountObj=result
                this.showToast('SUCCESS', 'Fetched Account Record Succesfully', 'success');
            })
            .catch((error)=>{
                console.log(error)
            })
    }
    editAccountHandler(){
        this.accountObj.Name=this.template.querySelector('lightning-input[data-formfield="accountName"]').value
        // this.accountObj.Rating=this.template.querySelector('lightning-input[data-formfield="accountRating"]').value
        // this.accountObj.Type=this.template.querySelector('lightning-input[data-formfield="accountType"]').value
        this.accountObj.SLA__c=this.template.querySelector('lightning-input[data-formfield="accountSLA"]').value
        
        editAccountMethod({objAccount:this.accountObj})
        .then((result)=>{
            console.log(result)
            this.showToast('SUCCESS', 'Account updated Succesfully', 'success');
        })
        .catch((error)=>{
            console.log(error)
        })
    }
    deleteAccountHandler(){
        this.accountObj.Name=this.template.querySelector('lightning-input[data-formfield="accountName"]').value
        deleteAccountMethod({objA:this.accountObj})
        .then((result)=>{
            console.log(result)
            this.accountObj.Name = undefined;
            // this.accountObj.Rating = undefined;
            // this.accountObj.Type = undefined;
            this.accountObj.SLA__c = undefined;
            this.showToast('SUCCESS', 'Account deleted Succesfully', 'success');
        })
        .catch((error)=>{
            console.log(error)
        })
    }

    showToast(title, message, variant) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );
    }
    get ratingFields() {
        return [
            { label: 'Hot', value: 'Hot' },
            { label: 'Warm', value: 'Warm' },
            { label: 'Cold', value: 'Cold' },
        ];
    }

    handleRating(event) {
        this.accountObj.Rating = event.detail.value;
    }
    get typeField() {
        return [
            { label: 'Prospect', value: 'Prospect' },
            { label: 'Customer - Direct', value: 'Customer - Direct' },
            { label: 'Customer - Channel', value: 'Customer - Channel' },
            { label: 'Channel Partner / Reseller', value: 'Channel Partner / Reseller' },
            { label: 'Installation Partner', value: 'Installation Partner' },
            { label: 'Technology Partner', value: 'Technology Partner' },
            { label: 'Other', value: 'Other' }
        ];
    }

    handleType(event) {
        this.accountObj.Type = event.detail.value;
    }
}