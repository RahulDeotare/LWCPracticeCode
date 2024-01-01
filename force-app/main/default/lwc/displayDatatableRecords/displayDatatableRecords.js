import { LightningElement,api,track,wire } from 'lwc';
import retreieveRecords from '@salesforce/apex/LWCAssignment2.retreieveRecords';

export default class DisplayDatatableRecords extends LightningElement {
    @api objectName = ''; //holding objectName value which is passed from other component
    @api fieldAPINames = ''; //holds list of fields API Name which is passed from other component
    @track recordId;
    
    items=[]; 
    @track data=[];
    @track columns;
    isRecordsVisible; //decision to make if this dynamic table to be shown.

    //retrieve data from databased
    @wire(retreieveRecords,{objectName:'$objectName'
                            ,fieldAPINames:'$fieldAPINames'})
    wiredObjects({ error, data }) {
        if (data) {
            console.log('data in string='+ JSON.stringify(data));            
            this.data = data;            
            this.error = undefined;
        } else if (error) {
            this.error = error;
            this.data = undefined;
        }
    }

   
    retriveRecordHandler(event){
        let args = JSON.parse(JSON.stringify(event.detail));
       
        
        this.objectName = args.valueParam;
        this.fieldAPINames = args.selectedFieldsValueParam;
        
       
        let columnFields = args.selectedFieldsValueParam.split(',');
        this.items='';

        //create columns for dynamic data display. Here all fields must be converted to initial letter as upper case
        //e.g id,name,type to transformed to Id, Name, Type
        columnFields.map(element=>{
            let itemValue = element.charAt(0).toUpperCase()+ element.slice(1);
            this.items = [...this.items ,{label: itemValue, 
                                        fieldName: itemValue}];    
        });
        
        this.columns = this.items;
        console.log(this.columns);
        this.isRecordsVisible = true;
    }

    resetHandler(event){
        this.isRecordsVisible = false;
        this.columns = [];
        this.data = [];
    }
    handle_row_action(event)
    {
       this.recordId=event.target.value;
       console.log('record id'+this.recordId);
       const myCustomEventItem = new CustomEvent('myeventdemo',{
        detail: this.recordId
   });
   this.dispatchEvent(myCustomEventItem);
    }   
}