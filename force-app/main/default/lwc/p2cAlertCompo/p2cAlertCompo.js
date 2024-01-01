import { api, LightningElement } from 'lwc';

export default class P2cAlertCompo extends LightningElement {
    @api message
    @api cardHeading
}