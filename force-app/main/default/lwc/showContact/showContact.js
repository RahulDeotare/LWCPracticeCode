import { LightningElement, track } from 'lwc';
import searchContactMethod from '@salesforce/apex/ContactProviderLWC.searchContactMethod';

export default class ShowContact extends LightningElement {

    @track conObj={'sobjectType':'Contact'}
    sentDataToChildCon(){
        this.conObj.Name=this.template.querySelector('lightning-input').value

        searchContactMethod({objCon: this.conObj})
            .then((result)=>{
                this.conObj=result
            })
            .catch((error)=>{
                console.log(error)
            })
    }
}