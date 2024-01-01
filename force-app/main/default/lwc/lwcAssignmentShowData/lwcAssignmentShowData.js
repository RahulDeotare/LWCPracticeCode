import { LightningElement,wire,api,track } from 'lwc';
import allRecord from '@salesforce/apex/LWCAssignment2.allRecord';
import { NavigationMixin } from 'lightning/navigation'; 

export default class lwcAssignmentShowData extends NavigationMixin(LightningElement){
    @api selected;
    @api tableData=[];
    defaultSortDirection = 'asc';
    sortDirection = 'asc';
    sortedBy;
   @api columns;
    @api firstColumnAsRecordHyperLink; 
    connectedCallback(){
      let firstTimeEntry = false;
      let firstFieldAPI;
    }
    @wire (allRecord,{objectApiNames: '$selected',fieldsetName:'allData'}) retriveOppData({data,error}){
      if (data) {
        
        let objStr = JSON.parse(data);   
        console.log(objStr);
        /* retrieve listOfFields from the map,
         here order is reverse of the way it has been inserted in the map */
        let listOfFields= JSON.parse(Object.values(objStr)[1]);
        
        //retrieve listOfRecords from the map
        let listOfRecords = JSON.parse(Object.values(objStr)[0]);

        let items = []; //local array to prepare columns
        items.push({ type: 'action', typeAttributes: { rowActions:  [
            { title:'View Record',cellAttributes: { alignment: 'left',variant:'destrictive' }, label:'View', iconName: 'action:delete', name: 'viewRecord'},
            { title:'Update Record',cellAttributes: { alignment: 'left',variant:'success' }, label:'Update', iconName: 'action:new_note', name: 'updateRecord'},
            { title:'Delete Record',cellAttributes: { alignment: 'left',variant:'success' }, label:'Delete', iconName: 'action:new_note', name: 'deleteRecord'},
            { title:'New Record',cellAttributes: { alignment: 'left',variant:'success' }, label:'New', iconName: 'action:new_note', name: 'newRecord'},
         ] } });
        /*if user wants to display first column has hyperlink and clicking on the link it will
            naviagte to record detail page. Below code prepare the first column with type = url
        */
            
        listOfFields.map(element=>{
            //it will enter this if-block just once
            if(this.firstColumnAsRecordHyperLink !=null && this.firstColumnAsRecordHyperLink=='Yes'
                                                    && firstTimeEntry==false){
                firstFieldAPI  = element.fieldPath; 
                //perpare first column as hyperlink                                     
                items = [...items ,
                                {
                                    label: element.label, 
                                    fieldName: 'URLField',
                                    fixedWidth: 150,
                                    type: 'url', 
                                    typeAttributes: { 
                                        label: {
                                            fieldName: element.fieldPath
                                        },
                                        target: '_blank'
                                    },
                                    sortable: true 
                                }
                ];
                firstTimeEntry = true;
            } else {
                items = [...items ,{label: element.label, 
                    fieldName: element.fieldPath}];
            }   
        });
        //finally assigns item array to columns
        this.columns = JSON.parse(JSON.stringify(items)); 
           
        this.tableData =listOfRecords ;
        console.log('tabledtat',this.tableData);
        console.log('listOfRecords',listOfRecords);
        console.log(JSON.parse(JSON.stringify(items)));
        
        /*if user wants to display first column has hyperlink and clicking on the link it will
            naviagte to record detail page. Below code prepare the field value of first column
        */
        // if(this.firstColumnAsRecordHyperLink !=null && this.firstColumnAsRecordHyperLink=='Yes'){
        //     let URLField;
        //     //retrieve Id, create URL with Id and push it into the array
        //     this.tableData = listOfRecords.map(item=>{
        //         URLField = '/lightning/r/' + this.SFDCobjectApiName + '/' + item.Id + '/view';
        //         return {...item,URLField};                     
        //     });
            
        //     //now create final array excluding firstFieldAPI
        //     this.tableData = this.tableData.filter(item => item.fieldPath  != firstFieldAPI);
        // }

        // //assign values to display Object Name and Record Count on the screen
        // this.lblobjectName = this.SFDCobjectApiName;
        // this.recordCount = this.tableData.length;
        // this.error = undefined; 
        }else if(error){
        console.log('An error has occurred:');
        console.log(error);
        // handle your error.
    }
    
    
   }
   
   recordPageUrl;
   handleRowAction(event){
    alert('sdfsf');
    const actionName = event.detail.action.name;
    const row = event.detail.row;
    console.log('sdfsf');
    console.log(actionName);
    if(actionName == 'viewRecord'){
        

        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: row.Id,
                objectApiName: this.selected, // objectApiName is optional
                actionName: 'view',
            },
        });

        }
        if(actionName == 'newRecord'){
        

            this[NavigationMixin.Navigate]({
                type: 'standard__recordPage',
                attributes: {
                    recordId: row.Id,
                    objectApiName: this.selected, // objectApiName is optional
                    actionName: 'new',
                },
            });
        
            // Generate a URL to a User record page
            // this[NavigationMixin.GenerateUrl]({
            //     type: 'standard__recordPage',
            //     attributes: {
            //         recordId: row.Id,
            //         objectApiName: this.selected, // objectApiName is optional
            //         actionName: 'view',
            //     },
            // }).then((url) => {
            //     this.recordPageUrl = url;
            // });
        
    
    }
    if(actionName == 'updateRecord'){
        console.log('sdfsftest');
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: row.Id,
                objectApiName: this.selected, // objectApiName is optional
                actionName: 'edit',
            },
        });    
    }
   }
 }