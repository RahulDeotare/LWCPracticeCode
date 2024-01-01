import { LightningElement, track,wire,api } from 'lwc';
import { getObjectInfos } from 'lightning/uiObjectInfoApi';
import ACCOUNT_OBJECT from '@salesforce/schema/Account';
import OPPORTUNITY_OBJECT from '@salesforce/schema/Opportunity';
import CONTACT_OBJECT from '@salesforce/schema/Contact';

export default class lwcAssignmentTwo extends LightningElement {
    objectApiNames = [ACCOUNT_OBJECT, OPPORTUNITY_OBJECT,CONTACT_OBJECT];
    @track customObjectOptions = [];
    @api selectValue = 'Account';
    
@wire(getObjectInfos, { objectApiNames: '$objectApiNames' })
wireHandler({ data, error }) {
   if (data) {
   let i;
     for (i = 0; i < data.results.length; i++) {
        
        var item = {
            label: data.results[i].result.label,
            value: data.results[i].result.apiName
        };
        this.customObjectOptions.push(item);
     }
     console.log(this.customObjectOptions);
     console.log(JSON.stringify(this.customObjectOptions));
   }
  }
  connectedCallback(){
    console.log(this.customObjectOptions);
  }

  handleChange(event){
 const value = event.target.value;
 this.selectValue =  value;
 console.log(value);
  }

}