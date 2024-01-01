import { api, LightningElement,track,wire } from 'lwc';
import getContactsRecord from '@salesforce/apex/contactProviderNov.getContactsRecord';
import CONTACT_OBJECT from '@salesforce/schema/Contact';
import getAccountList from '@salesforce/apex/contactProviderNov.getAccountList'
import { deleteRecord } from 'lightning/uiRecordApi';
import { NavigationMixin } from 'lightning/navigation'
import {ShowToastEvent} from 'lightning/platformShowToastEvent'
import { updateRecord } from 'lightning/uiRecordApi';
import FIRSTNAME_FIELD from '@salesforce/schema/Contact.FirstName';
import LASTNAME_FIELD from '@salesforce/schema/Contact.LastName';
import {refreshApex} from '@salesforce/apex';
import EMAIL_FIELD from '@salesforce/schema/Contact.Email';
import PHONE_FIELD from '@salesforce/schema/Contact.Phone';
import ACCOUNTNAME_FIELD from '@salesforce/schema/Contact.AccountId';
import cloneMethod from '@salesforce/apex/contactProviderNov.cloneMethod';

export default class TestCompo extends NavigationMixin(LightningElement) {

    fields={ 
     
        firstnameField:FIRSTNAME_FIELD,
        lastnameField:LASTNAME_FIELD,
        emailField:EMAIL_FIELD,
        phoneField:PHONE_FIELD,
        accId:ACCOUNTNAME_FIELD
    }
    //For Clone of data
    @api invoke() {
        this.showToast('Deep Clone!','Starting cloning process...','success');
        //Call the cloning imperative apex js method
        this.cloneHandler();
    }
    @track openLwc=false;
    @track wiredAccountResult;
    wiredAccResult;
    @track error
    @api content
    @api recordId//try without api
    @api contacts  
  @track modalContainer = false;

   @wire(getContactsRecord,{accountId:'$recordId'}) 
   wireContact(result){
    console.log('##Result received before edit  ',result);
    this.wiredAccountResult=result;
    console.log('###Result received in wired account result  ',result)
    if(result.data){
        console.log("#Original data  ",result.data);
        this.contacts=result.data;
        //this.openLwc=true;
        this.closeModalAction();
        //this.openLwc=false;
        console.log("#this contact data  ",this.contacts);
       
    }
    if(result.error){
        console.log(error)
    }
   }
   
 
   handleEdit(event){     
      this.modalContainer=true;
      console.log("##Data set Id  ",event.target.dataset.id)
      this.content=event.target.dataset.id;
      
      //this.deleteHandler(event.target.dataset.id)
      console.log("##content Id received  ",event.target.dataset.id)
      //this.showToast("Contact Record", "Contact Details", "info")
   }

   closeModalAction(){
    this.modalContainer=false;
   }
   
   saveHandler(event){
    console.log('1');
    console.log('12',this.wiredAccountResult);
    refreshApex(this.wiredAccountResult);
    this.showToast("Success!!", "Contact Record Saved Successfully!!", "success");
    console.log('12');
    
    this[NavigationMixin.Navigate]({
        type: 'standard__recordPage',
        attributes: {
            recordId:this.recordId,
            objectApiName: 'Account',
            actionName: 'view',
        },
    });
    //this.showToast("Success!!", "Contact Record Saved Successfully!!", "success");
    //window.location.reload();
    console.log('123');
    
    console.log('1234');
    // this.modalContainer=false;
    console.log('12345');
   }
   cloneHandler(){

    cloneMethod({contactId: this.content})
        .then((result)=>{
            console.log("### result receieved  ",result);
            this.showToast("Deep Clone!", "Cloning Process Completed!!", "info");
            console.log("### result received  ",result.data);
            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId:this.recordId,
                    objectApiName: 'Account',
                    actionName: 'view',
                },
            });
        })
         .catch((error)=>{
            this.showToast('Deep Clone!','An Error occured during cloning'+error,'error');
            console.log("##### result received  ",error);
         });
         
}

   deleteHandler(event){
    console.log("In delete   ", event.target)
    console.log("In delete with value  ", event.detail.value)
    //this.content=data.target.dataset.id;
    console.log("##content Id received in delete ",this.content)
    //this.deleteId=this.content
    /*deleteContactMethod({conId:deleteId})
    .then((result)=>{
        console.log(result)       
        this.showToast("Warning!!", "Contact Record is deleted!!", "warning")
    })
    .catch((error)=>{
        console.log(error)
    })*/
    deleteRecord(this.content)
    .then((result)=>{
        console.log(result)
        refreshApex(this.wiredAccountResult);       
        this.showToast("Success!!", "Contact Record is deleted Successfully!!", "success")
        
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId:this.recordId,
                objectApiName: 'Account',
                actionName: 'view',
            },
        });
    })
    .catch((error)=>{
        console.log(error)
    })
    
    //window.location.reload();
    
   }
   showToast(title, message, variant){ 
    const event = new ShowToastEvent({ 
        title,
        message,
        variant,
    })
    this.dispatchEvent(event)
}
}