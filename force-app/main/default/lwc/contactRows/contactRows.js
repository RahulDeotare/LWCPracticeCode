import { LightningElement,wire } from 'lwc';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import LEADSOURCE_FIELD from '@salesforce/schema/Contact.LeadSource';
import LEVEL__C_FIELD from '@salesforce/schema/Contact.Level__c';
import {ShowToastEvent} from 'lightning/platformShowToastEvent';
import saveContacts from '@salesforce/apex/contactProvider.saveContacts';
import getAllContacts from '@salesforce/apex/contactProvider.getAllContacts';
import { getListUi } from 'lightning/uiListApi';

const columns = [
    { label: 'Last Name', fieldName: 'LastName' },
    { label: 'Lead Source', fieldName: 'LeadSource' },
    { label: 'Phone', fieldName: 'Phone' ,type: 'phone'},
    { label: 'Level', fieldName: 'Level__c'  },
    { label: 'Account Name', fieldName: 'Account.Name' },
];


export default class ContactRows extends LightningElement {
    error;
    columns = columns;
    leadsourceOptions = [{ value: '-None-', label: '' }];
    levelOptions= [{value: '-None-', label: ''}];
    filterList = [];
    keyIndex = 0;
    isSpinner = false;

    @wire(getObjectInfo, { objectApiName: CONTACT_OBJECT })
    contactinfo;
    @wire(getPicklistValues, { recordTypeId: '$contactinfo.data.defaultRecordTypeId', fieldApiName: LEADSOURCE_FIELD})
    

    leadsourceValues({ data, error }) {
        if (data) {
            data.values.forEach(val => {
                this.leadsourceOptions = [...this.leadsourceOptions, { value: val.value, label: val.label }];
            });
        }
        else if (error) {
            this.processErrorMessage(error);
        }
    }
    @wire(getPicklistValues, { recordTypeId: '$contactinfo.data.defaultRecordTypeId', fieldApiName: LEVEL__C_FIELD })
    levelValues({ data, error }) {
        if (data) {
            data.values.forEach(val => {
                this.levelOptions = [...this.levelOptions, { value: val.value, label: val.label }];
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
        if (event.target.name == 'lastName') {
            this.filterList[event.currentTarget.dataset.index].LastName = event.target.value;
        }
        else if (event.target.name == 'leadsource') {
            this.filterList[event.currentTarget.dataset.index].LeadSource = event.target.value;
        }
        else if (event.target.name == 'conPhone') {
            this.filterList[event.currentTarget.dataset.index].Phone = event.target.value;
        }
        else if (event.target.name == 'level') {
            this.filterList[event.currentTarget.dataset.index].Level__c = event.target.value;
        }
        
    }
    handleAccountSelection(event){

        console.log("the selected record id is"+event.detail);
    }
    handleAddRow() {
        let objRow = {
            LastName: '',
            LeadSource: '',
            Phone: '',
            Level__c:'',
            
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
        saveContacts({ conList: this.filterList }).then(result => {
            this.isSpinner = false;
            this.showToastMessage('success', 'Contact Saved Successfully!!', 'Success');
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
    contacts=[]
    //@wire(getAllContacts)
    //contacts;
    @wire(getListUi,{
        objectApiName:CONTACT_OBJECT,
        listViewApiName:'AllContacts'
    })
    listViewHandler({data,error}){
        if(data){
            console.log(data)
            this.contacts=data.records.records
            
        }
        if(error){
            console.error(error)
        }
    }
}