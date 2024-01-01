import { LightningElement } from 'lwc';

export default class C2pParentCompo extends LightningElement {
    message
    showModal=false;
    handleChange(){
        this.showModal=true;
    }
    closeHandler(event){
        this.message=event.detail
        this.showModal=false;
    }
}