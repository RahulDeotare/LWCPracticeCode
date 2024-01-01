import { LightningElement } from 'lwc';
import IntegrationXMLSerialize from '@salesforce/apex/IntegrationXMLSerialize.methodIntegrationXMLSerialize';

export default class LwcForIntegration extends LightningElement {

    xmlData;
    getXML() {
        IntegrationXMLSerialize()
            .then(result => {
                console.log('result', result);
                this.xmlData = result;
            })
            .catch(error => {
                console.log(error);
            });
    }
    handleClick() {
        this.getXML();
    }
    get xmlData() {
        return this.xmlData;
    }
}