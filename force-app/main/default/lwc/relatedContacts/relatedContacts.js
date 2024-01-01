import { api, LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/contactProviderNov.getContacts';
import { getRecord } from 'lightning/uiRecordApi';

export default class RelatedContacts extends LightningElement {

    @api recordId;
    contacts;
    error;

    @wire(getRecord,{recordId:'$recordId', fields:'Account.Name'})
    record;

    @wire(getContacts,{accId:'$recordId'})
    wiredContcts({data,error}){
        if(data){
            this.contacts=data
            this.error=undefined
        }
        else if(error){
            this.error=error
            this.contacts=undefined
        }
    }
}