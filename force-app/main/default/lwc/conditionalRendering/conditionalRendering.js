import { LightningElement } from 'lwc';

export default class ConditionalRendering extends LightningElement {

    areDetailVisible=false;

    handleChange(event){
        this.areDetailVisible=event.target.checked;
    }
}