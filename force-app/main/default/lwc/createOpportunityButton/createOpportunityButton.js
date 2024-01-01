import { LightningElement } from 'lwc';


export default class CreateOpportunityButton extends LightningElement {

    accountId;
    handleSuccess(event) {
        this.accountId = event.detail.id;
    }
}