import { LightningElement,api } from 'lwc';
import ersatz_tableAccountContactData from "@salesforce/apex/AccountProviderForAura.tableAccountContactData";
import ersatz_getContactRecords from "@salesforce/apex/AccountProviderForAura.getContactRecords";
import ersatz_deleteSelectedContactRecords from "@salesforce/apex/AccountProviderForAura.deleteSelectedContactRecords";

export default class AuraToLwcTest extends LightningElement {

    @api
    recordId = null;

    @api
    accountObject = {
        sObjectType: "Account"
    };

    @api
    accList = [];

    @api
    accTableColumns = [];

    @api
    accID = null;

    @api
    contactList = [];

    @api
    contactTableColumns = [];

    @api
    countOfContacts = 0;

    @api
    SelectedContactRows = 0;

    @api
    SelectedContactRecords = [];

    @api
    showContactDetailFlag = false;

    @api
    showContactDeleteButtonFlag = false;

    searchAccountController(event) {
        
        this.accTableColumns = [
            {label: 'Account Name', fieldName: 'Name', type: 'text'},
            {label: 'Type', fieldName: 'Type', type: 'text'},
            {label: 'SLA', fieldName: 'SLA__c', type: 'text'},
            {label: 'Rating', fieldName: 'Rating', type: 'text'}
        ];
        
        this.contactTableColumns = [
            {label: 'Contact First Name', fieldName: 'FirstName', type: 'text'},
            {label: 'Contact Last Name', fieldName: 'LastName', type: 'text'},
            {label: 'Lead Source', fieldName: 'LeadSource', type: 'text'}          
        ];
        
		this.searchAccountHelperMethod(event);
	}

    selectedAccountRows(event) {
        var selectedAccountRows =  event.detail.selectedRows;// Array
        var selectedAccountID = selectedAccountRows[0].Id;
        console.log(selectedAccountID);
        this.accID = selectedAccountID;
        
        if(selectedAccountRows.length>0){
        this.showContactDetailFlag = true;
        }
        else{
            this.showContactDetailFlag = false;
        }
        this.fetchContactsHelperMethod(event);
    }

    selectedContactRows(event) {
        var selectContactRows =  event.detail.selectedRows;// Array
        console.log('contact Selected '+selectContactRows.length);
        this.SelectedContactRows = selectContactRows.length;
        
        var selectedConRows=[];
         for(var i=0; i<selectContactRows.length; i++){
            selectedConRows.push(selectContactRows[i]);
         }
        
        this.SelectedContactRecords = selectedConRows;
        
        if(selectedConRows.length>0){
            this.showContactDeleteButtonFlag = true;
        }
        else{
            this.showContactDeleteButtonFlag = false;
        }
    }

    deleteContactRecord(event) {
        this.deleteSelectedContactHelperMethod(event);
    }

    searchAccountHelperMethod(event) {
        var action=ersatz_tableAccountContactData;
        action({"objAcc" : this.accountObject}).then(response => {
            console.log(response);
            this.accList = response;
        });
    }

    fetchContactsHelperMethod(event) {
        var action=ersatz_getContactRecords;
        action({"AccountID" : this.accID}).then(response => {
            console.log(response);
            this.contactList = response;
            
            this.countOfContacts = response.length;
        });
    }

    deleteSelectedContactHelperMethod(event) {
        var action=ersatz_deleteSelectedContactRecords;
        action({"conDeleteList" : this.SelectedContactRecords}).then(() => {
            console.log(response.getReturnvalue());
        });
    }
}