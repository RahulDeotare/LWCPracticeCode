import { LightningElement } from 'lwc';
import createAccount from '@salesforce/apex/AccountProviderLWC.createAccount';

export default class LWCClass_4_Practice extends LightningElement {

    accountName
    
    accountPhone
    createAcountController(){
        var ele=this.template.querySelectorAll('lightning-input');

        ele.forEach(element=>{
                if(element.name=="accountName"){
                    this.accountName=element.value
                }
                
                if(element.name=="accountPhone"){
                    this.accountPhone=element.value
                }
        })

        createAccount({accName: this.accountName,accPhone: this.accountPhone })
        .then((result)=> {
            this.result=result;
            this.error=undefined;

        })
        .catch((error)=>{
            this.error=error;
            this.result=undefined;
        });
        
    }
}