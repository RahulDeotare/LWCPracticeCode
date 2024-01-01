import { LightningElement, track } from 'lwc';

export default class BindingCompoOne extends LightningElement {
    @track greeting='Rahul';

    greetingChange(event){
        this.greeting=event.target.value;
    }
}