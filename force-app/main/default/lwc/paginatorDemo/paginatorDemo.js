import { LightningElement } from 'lwc';

export default class PaginatorDemo extends LightningElement {
    handlePrevious() {
        this.dispatchEvent(new CustomEvent('previous'));
    }

    handleNext() {
        this.dispatchEvent(new CustomEvent('next'));
    }
}