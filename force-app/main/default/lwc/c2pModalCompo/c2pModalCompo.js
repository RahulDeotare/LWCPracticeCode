import { LightningElement } from 'lwc';

export default class C2pModalCompo extends LightningElement {

    closeHandler(){
        const myEvt=new CustomEvent('close',{
            detail:"Modal Closed Successfully!!"
        })
        this.dispatchEvent(myEvt)
    }
}