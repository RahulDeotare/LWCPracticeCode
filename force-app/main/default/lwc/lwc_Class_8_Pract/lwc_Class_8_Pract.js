import { LightningElement, track } from 'lwc';
import readAccountMethod from '@salesforce/apex/AccountProviderLWC.readAccountMethod';

export default class Lwc_Class_8_Pract extends LightningElement {
    
   @track accountObject={'sobjectType':'Account'}

   sendDataToChild(){
    this.accountObject.Name=this.template.querySelector('lightning-input').value

    readAccountMethod({objAcc:this.accountObject})
        .then((result)=>{
            this.accountObject=result
        })
        .catch((error)=>{
            console.log(error)
        })
   }
}