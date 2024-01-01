import { LightningElement } from 'lwc';

export default class VolumeResetCompo extends LightningElement {

    resetChildSlider(){
        this.template.querySelector('c-slider-compo').resetChildVolume()
    }
}