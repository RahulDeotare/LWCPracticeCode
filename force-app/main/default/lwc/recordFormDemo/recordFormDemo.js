import { LightningElement } from 'lwc';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import ACCOUNT_OBJECT from '@salesforce/schema/Account'
import NAME_FIELD from '@salesforce/schema/Account.Name'
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry'
import TYPE_FIELD from '@salesforce/schema/Account.Type'

export default class RecordFormDemo extends LightningElement {

    objectName=ACCOUNT_OBJECT
    fields=[NAME_FIELD,INDUSTRY_FIELD,TYPE_FIELD]

    successHandler(event){
        const toastEvt= new ShowToastEvent({
            title:'Account Created!',
            message:'Record Id:' + event.detail.id,
            variant: 'success'
        })
        this.dispatchEvent(toastEvt);
    }
}