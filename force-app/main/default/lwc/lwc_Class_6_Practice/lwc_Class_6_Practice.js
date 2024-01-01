import { LightningElement } from 'lwc';
import getAllAccounts from '@salesforce/apex/AccountProviderLWC.getAllAccounts';

export default class Lwc_Class_6_Practice extends LightningElement {
    showTableFlag=false
    editAccountFlag=false
    accList
    showAccountTable(){

        getAllAccounts()
        .then((result)=>{
            this.accList=result
            this.showTableFlag=true
            this.editAccountFlag=false
        })
        .catch((error)=>{
            console.log(error)
        })
    }
    editAccountHandler(){
        this.editAccountFlag=true
    }

}