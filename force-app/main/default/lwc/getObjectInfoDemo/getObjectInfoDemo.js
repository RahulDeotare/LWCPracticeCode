import { getObjectInfo, getObjectInfos } from 'lightning/uiObjectInfoApi';
import { LightningElement, wire } from 'lwc';
import ACCOUNT_OBJECT from '@salesforce/schema/Account'
import OPPORTUNITY_OBJECT  from '@salesforce/schema/Opportunity'

export default class GetObjectInfoDemo extends LightningElement {

    defaultRecordTypeId
    @wire(getObjectInfo,{objectApiName:ACCOUNT_OBJECT})
    objectInfo({data,error}){
        if(data){
            console.log(data)
            this.defaultRecordTypeId=data.defaultRecordTypeId
        }
        if(error){
            console.log(error)
        }
    }
    objectApiNames=[ACCOUNT_OBJECT,OPPORTUNITY_OBJECT]
    wireData
    @wire(getObjectInfos,{objectApiNames:'$objectApiNames'})
    objectData({data,error}){
        if(data){
            this.wireData=data
        }
    }
}