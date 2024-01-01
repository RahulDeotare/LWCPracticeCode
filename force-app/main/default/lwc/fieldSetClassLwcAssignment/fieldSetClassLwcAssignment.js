import { LightningElement, track,wire,api } from 'lwc';
import { getObjectInfos } from 'lightning/uiObjectInfoApi';
import Lead_Object from '@salesforce/schema/Lead';
import Opportunity_Object from '@salesforce/schema/Opportunity';
import Contact_Object from '@salesforce/schema/Contact';

export default class FieldSetClassLwcAssignment extends LightningElement {
    objectApiNames = [Lead_Object, Opportunity_Object,Contact_Object];
    @track customObjectOptions = [];
    @api selectValue = 'Lead';
    
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