import { LightningElement,track } from 'lwc';

export default class ConditionalRenderingCompo extends LightningElement {

    @track displayMyName=false;

    showName(event){
        this.displayMyName=event.target.checked;
    }
}