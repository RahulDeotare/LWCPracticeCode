import { LightningElement } from 'lwc';
import getAllAccountsDataTableMethod from '@salesforce/apex/AccountProviderLWC.getAllAccountsDataTableMethod';
import updateAccountList from '@salesforce/apex/AccountProviderLWC.updateAccountList';
import deleteAccountListMethod from '@salesforce/apex/AccountProviderLWC.deleteAccountListMethod';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const  columns = [
    { label: 'Id', fieldName: 'Id', editable: true },
    { label: 'Name', fieldName: 'Name', editable: true },
    { label: 'Type', fieldName: 'Type', editable: true },
  ];
  

export default class Lwc_Class_7_Practice extends LightningElement {
    accList
    columns=columns
    draftValues=[];
    selectedRows=[];
    SelectedRecordsCount
    selectedAccRecords
    deleteButton='Delete Selected Records'
    searchButton='Search All Accounts'

    getAllAccountsRecordsMethod(){
        this.searchButton='Searching....!!';
        getAllAccountsDataTableMethod()
        .then((result)=>{
            this.accList=result
            this.showToast('SUCCESS', 'Account records fetched Successfully', 'success');
            this.searchButton=='Search All Accounts'
        })
        .catch((error)=>{
            console.log(error)
            this.showToast('SUCCESS', 'Account records edited Successfully', 'failure');
        })
    }
    saveHandler(event){
        var editedAccList=event.detail.draftValues
        updateAccountList({accList : editedAccList})
        .then((result)=>{
            console.log('Successful')
            this.showToast('SUCCESS', 'Account records edited Successfully', 'success');
        })
        .catch((error)=>{
            console.log(error)
        })
    }
    showToast(title,message,variant){
        this.dispatchEvent(
            new ShowToastEvent({
                title:title,
                message:message,
                variant:variant
            })
        );
    }
    selectedRecordsHandler(event){
        const selectedRows=event.detail.selectedRows
        this.SelectedRecordsCount=event.detail.selectedRows.length;

        let recordsSets = new Set();

        // getting selected record id
        for (let i = 0; i < selectedRows.length; i++) {
            recordsSets.add(selectedRows[i].Id);
        }

        // coverting to array
        this.selectedAccRecords = Array.from(recordsSets);

    }
    deleteAllAccountsRecordsMethod(){
        this.deleteButton='Deleting.....'
        deleteAccountListMethod({accIdSet: this.selectedAccRecords})
        .then((result)=>{
            console.log('Deleted Account record')
            this.accList=result
            this.showToast('SUCCESS', 'Account records deleted Successfully', 'success');
            this.deleteButton='Delete Selected Records'
        })
        .catch((error)=>{
            console.log(error)
        })
    }
}