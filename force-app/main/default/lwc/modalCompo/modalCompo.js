import { api, LightningElement } from 'lwc';
import CONTACT_OBJECT from '@salesforce/schema/Contact'
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName'
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName'
import EMAIL_FIELD from '@salesforce/schema/Contact.Email'
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';

export default class ModalCompo extends LightningElement {

    
    /*PHONE_FIELD
    
    objectName = CONTACT_OBJECT
    fields={ 
        
        nameField:FIRSTNAME_FIELD,
        titleField:LASTNAME_FIELD,
        phoneField:EMAIL_FIELD,
        emailField:PHONE_FIELD
    }*/
    @api getIdFromParent
    @api objectApiName

    closeModal(){
        this.dispatchEvent(new CustomEvent('close'))
     }
     
}