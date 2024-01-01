import { api, LightningElement, track, wire } from 'lwc';
import getContactsRecord from '@salesforce/apex/contactProviderNov.getContactsRecord';


export default class RelConAccCompo extends LightningElement {

    @api recordId
    @api showModal=false
    @api contacts
  @track contactRow={};  
   @wire(getContactsRecord,{accountId:'$recordId'}) 
   wireContact({data,error}){
    if(data){
        console.log("#Original data  ",data)
        this.contacts=data
        this.contactRow=data
        console.log("#this contact data  ",this.contacts)
    }
    if(error){
        console.log(error)
    }
   }


    handleEdit(event){

        console.log("# Data req",this.recordId)
        console.log("####Data",event.target.dataset.id)
        this.recordId=event.target.dataset.id

        //this.recordId = event.detail;
        //window.console.log('recordId ' + this.recordId);

        console.log("In HandleClick");
        //const recId = event.target.name;
        //this.recordId = event.currentTarget.name;
        //console.log("Selected Contact Id:::", event.target.name);
        //console.log("Selected Contact Id recordId :::", event.currentTarget.name);
        //console.log(this.showModal)
        this.showModal=true
        //console.log(event.target.value)
        //this.recordId=event.target.value
        //console.log(this.template.querySelector("c-modal-compo").handleSubmit());
        //console.log(this.template.querySelector("c-modal-compo").handleSuccess());

    }
   
    closeHandler(){
        console.log(this.showModal)
        this.showModal=false
    }
    saveHandler(){

    }
    deleteHandler(){

    }
    cloneHandler(){

    }

}