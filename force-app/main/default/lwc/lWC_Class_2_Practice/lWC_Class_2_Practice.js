import { LightningElement } from 'lwc';

export default class LWC_Class_2_Practice extends LightningElement {


    firstName
    lastName
    dob
    gender

    showData(){
      var ele= this.template.querySelectorAll("lightning-input");

      ele.forEach(element => {
            if(element.name=="firstName"){
                    this.firstName=element.value
            } 
            if(element.name=="lastName"){
                this.lastName=element.value
            }
            if(element.name='dob'){
                this.dob=element.value
            }    
      });
    }
    get options() {
        return [
            { label: 'Male', value: 'Male' },
            { label: 'Female', value: 'Female' },
            { label: 'Transgender', value: 'Transgender' },
        ];
    }
    handleGender(event) {
        this.gender = event.detail.value;
    }

}