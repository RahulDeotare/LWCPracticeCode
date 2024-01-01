import { api, LightningElement } from 'lwc';

export default class SliderCompo extends LightningElement {
    val=20

    volumeSliderHandler(event){
        this.val=event.target.value
    }
    @api resetChildVolume(){
        this.val=0
    }
}