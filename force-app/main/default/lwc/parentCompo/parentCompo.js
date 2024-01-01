import { LightningElement } from 'lwc';

export default class ParentCompo extends LightningElement {

    showPopUpFlag=false
    popUpHandler(){
        this.showPopUpFlag=true
    }
    cancelPopUp(){
        this.showPopUpFlag=false
    }
}