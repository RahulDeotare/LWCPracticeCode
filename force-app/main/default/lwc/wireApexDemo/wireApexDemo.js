import { api, LightningElement, wire } from 'lwc';
import getContacts from '@salesforce/apex/contactProviderNov.getContacts';

export default class WireApexDemo extends LightningElement {

    @api recordId;
    contacts;
    error;
    @wire(getContacts, {accId:'$recordId'})
    wiredContact({error,data}){
        if(data){
            console.log('#contact data',data);
            this.contacts=data;
            this.error=undefined;
        }
        else if(error){
            this.error=error;
            this.contacts=undefined;
        }
    }


}