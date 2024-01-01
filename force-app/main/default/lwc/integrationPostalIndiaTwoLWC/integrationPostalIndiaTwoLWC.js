import { LightningElement,track } from 'lwc';
import getPincodeDetailAddress from '@salesforce/apex/IntegrationPostalIndiaLWC.getPincodeDetailAddress';

export default class IntegrationPostalIndiaTwoLWC extends LightningElement {
    
        @track pincode;
        @track places;
    
        handlePincodeChange(event) {
            this.pincode = event.target.value;
        }
    
        async getPincodeDetailAddress() {
            try {
                const result = await getPincodeDetailAddress({ pincode: this.pincode });
                if (result) {
                    this.places = result;
                }
            } catch (error) {
                // Handle error appropriately
                console.error('Error fetching pincode details:', error);
            }
        }
}