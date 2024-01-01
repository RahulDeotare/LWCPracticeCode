import { LightningElement, wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import INDUSTRY_FIELD from '@salesforce/schema/Account.Industry';
import RATING_FIELD from '@salesforce/schema/Account.Rating';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import saveAccounts from '@salesforce/apex/AccountProviderLWC.saveAccounts';

export default class InsertRecord extends LightningElement {

    industryOptions = [{ value: '-None-', label: '' }];
    ratingOptions= [{value: '-None-', label: ''}];
    filterList = [];
    keyIndex = 0;
    isSpinner = false;

    @wire(getObjectInfo, { objectApiName: ACCOUNT_OBJECT })
    accountinfo;
    @wire(getPicklistValues, { recordTypeId: '$accountinfo.data.defaultRecordTypeId', fieldApiName: INDUSTRY_FIELD})
    

    industryValues({ data, error }) {
        if (data) {
            data.values.forEach(val => {
                this.industryOptions = [...this.industryOptions, { value: val.value, label: val.label }];
            });
        }
        else if (error) {
            this.processErrorMessage(error);
        }
    }
    @wire(getPicklistValues, { recordTypeId: '$accountinfo.data.defaultRecordTypeId', fieldApiName: RATING_FIELD })
    ratingValues({ data, error }) {
        if (data) {
            data.values.forEach(val => {
                this.ratingOptions = [...this.ratingOptions, { value: val.value, label: val.label }];
            });
        }
        else if (error) {
            this.processErrorMessage(error);
        }
    }
    connectedCallback() {
        this.handleAddRow();
    }
    handleChange(event) {
        if (event.target.name == 'accName') {
            this.filterList[event.currentTarget.dataset.index].Name = event.target.value;
        }
        else if (event.target.name == 'industry') {
            this.filterList[event.currentTarget.dataset.index].Industry = event.target.value;
        }
        else if (event.target.name == 'accPhone') {
            this.filterList[event.currentTarget.dataset.index].Phone = event.target.value;
        }
        else if (event.target.name == 'rating') {
            this.filterList[event.currentTarget.dataset.index].Rating = event.target.value;
        }
    }
    handleAddRow() {
        let objRow = {
            Name: '',
            Industry: '',
            Phone: '',
            Rating:'',
            id: ++this.keyIndex
        }
        this.filterList = [...this.filterList, Object.create(objRow)];
    }
    handleRemoveRow(event) {
        this.filterList = this.filterList.filter((ele) => {
            return parseInt(ele.id) !== parseInt(event.currentTarget.dataset.index);
        });

        if (this.filterList.length == 0) {
            this.handleAddRow();
        }
    }
    saveRows() {
        console.log('this.filterList => ', this.filterList);
        this.isSpinner = true;
        saveAccounts({ lstAccs: this.filterList }).then(result => {
            this.isSpinner = false;
            this.showToastMessage('success', 'Accounts Saved Successfully!!', 'Success');
            this.filterList = [];
            if (this.filterList.length == 0) {

                this.handleAddRow();
            }
            console.log('result ==> ', result);
        }).catch(error => {
            this.processErrorMessage(error);
            this.isSpinner = false;
        })
    }
    processErrorMessage(message) {
        let errorMsg = '';
        if (message) {
            if (message.body) {
                if (Array.isArray(message.body)) {
                    errorMsg = message.body.map(e => e.message).join(', ');
                } else if (typeof message.body.message === 'string') {
                    errorMsg = message.body.message;
                }
            }
            else {
                errorMsg = message;
            }
        }
        this.showToastMessage('error', errorMsg, 'Error!');
    }
    showToastMessage(variant, message, title) {
        this.dispatchEvent(
            new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            })
        );
    }
}