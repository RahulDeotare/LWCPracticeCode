import { LightningElement } from 'lwc';

export default class ChildCompo extends LightningElement {

    cancelPopUp(){
        const cancelPopUpMessage=new CustomEvent('myshowpopupevent')
        this.dispatchEvent(cancelPopUpMessage)
    }

}