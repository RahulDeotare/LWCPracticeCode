import { api, LightningElement,wire } from 'lwc';
import { getListUi } from 'lightning/uiListApi'
import ORDERITEM_OBJECT from '@salesforce/schema/OrderItem'
import PRODUCTNAME_FIELD from '@salesforce/schema/OrderItem.Product2Id'

export default class OrderLwcCompo extends LightningElement {
    //@api recordId
    orderItems=[]
    pageToken = null

    
    @wire(getListUi, {
        objectApiName:ORDERITEM_OBJECT,
        listViewApiName:'AllOrderItems',
        pageSize:10,
        sortBy:PRODUCTNAME_FIELD,
        pageToken:'$pageToken'
    })
    listViewHandler({data, error}){
        if(data){
            console.log(data)
            this.orderItems = data.records.records
            console.log(this.orderItems)
        }
        if(error){
            console.error(error)
        }
    }
    handleEdit(){

    }
    handleDelete(event){

    }
}