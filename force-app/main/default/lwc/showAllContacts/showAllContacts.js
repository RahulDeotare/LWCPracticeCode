import { LightningElement } from 'lwc';
import getAllContacts from '@salesforce/apex/contactProvider.getAllContacts';
export default class ShowAllContacts extends LightningElement {

    showTableFlag=false
    conList
    showAccountTable(){
 
        getAllAccounts()
        
            this.conList=result
            this.showTableFlag=true
        
    }

}