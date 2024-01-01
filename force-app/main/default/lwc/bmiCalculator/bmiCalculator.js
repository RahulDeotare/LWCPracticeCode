import { LightningElement,track } from 'lwc';

export default class BmiCalculator extends LightningElement {

    weight;
    height;
    @track bmi;

    onWeightChange(event){
        this.weight= parseFloat(event.target.value);
    }
    onHeightChange(event){
        this.height= parseFloat(event.target.value);
    }

    getBmiValue(){
        this.bmi=this.weight/(this.height*this.height);
    }
}