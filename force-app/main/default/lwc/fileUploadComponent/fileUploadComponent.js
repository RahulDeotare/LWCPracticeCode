import { LightningElement } from 'lwc';
import getAllAccountRecord from '@salesforce/apex/UploadProvider.getAllAccountRecord'
import uploadFile from '@salesforce/apex/UploadProvider.uploadFile'
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
 
const  columns = [    
    { label:'Name', fieldName:'Name', editable:true },
    { label:'Type', fieldName:'Type', editable:true },
    { label:'Rating', fieldName:'Rating', editable:true },
    { label:'SLA__c', fieldName:'SLA__c', editable:true },
   
  ];
export default class FileUploadComponent extends LightningElement {
   
    fileData
    draftValues=[];
    columns = columns;
    selectedRecords;
    
    selectedRows
    accList
    connectedCallback(){
 
        getAllAccountRecord()
        .then( (result) => {
        this.result = result;
        this.error = undefined;
        console.log(this.result);
        this.accList=result
  })
  .catch((error)=>{
    this.result=undefined
    this.error=error
    console.log(this.error)
  })
 
    }
 
    openfileUpload(event) {
        const file = event.target.files[0]
        var reader = new FileReader()
 
      
        reader.onload = () => {
           
            var base64 = reader.result.split(',')[1]
            console.log(base64)
            
            this.fileData = {
                'filename': file.name,
                'base64': base64,
                'recordId': this.selectedRecords,
                'size':file.size
               
            }
            console.log(this.fileData)
            
        }
        reader.readAsDataURL(file)
    }
    handleClick(){
        debugger;
        for (let i = 0; i< this.selectedRecords.length; i++) {
          
             console.log('in for loop'+this.selectedRecords.length);
         const {base64, filename, this:selectedRecords,} = this.fileData
        
            console.log('selectedRecords'+this.selectedRecords); 
 
              uploadFile({ base64, filename,this:selectedRecords })
              .then(result=>{
                  this.fileData = result
                  let title = `${filename} uploaded successfully!!`
                  this.toast(title)
              })
              .catch(error=>{
                this.fileData = null
                let title = `${filename} unsuccesfull successfully!!`
                this.toast(title)
            })
         
          
        }
      }
      selectedRecordsHandler(event){
        console.log('Selected Rows');            
        const selectedRows  =   event.detail.selectedRows;
        console.log("Selected Rows = "+ JSON.stringify(selectedRows))
        
        let recordsSets = new Set();
 
        // getting selected record id
        for (let i = 0; i<selectedRows.length; i++) {
            recordsSets.add(selectedRows[i].Id);
        }
 
        // coverting to array
        this.selectedRecords = Array.from(recordsSets);
 
       
        }
        //Toast Message
        toast(title){
            const toastEvent = new ShowToastEvent({
                title, 
                variant:"success"
            })
            this.dispatchEvent(toastEvent)
        }
    }