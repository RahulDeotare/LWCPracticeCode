import { LightningElement, wire, api, track } from 'lwc';
import { getObjectInfo } from 'lightning/uiObjectInfoApi';
import { getPicklistValues } from 'lightning/uiObjectInfoApi';
import LocationFinder_OBJECT from '@salesforce/schema/Location_Finder__c';
import LocationName_FIELD from '@salesforce/schema/Location_Finder__c.Locations__c';
import SELECTSUBLOCATION_FIELD from '@salesforce/schema/Location_Finder__c.Sublocations__c';

export default class ParentInno extends LightningElement {
    LocationValue ='';
    Malls= '';
    Hotels = '';
    WaterPark = '';
    sublocations;
 
    // getting the default record type id, if you dont' then it will get master
 
    @wire(getObjectInfo, { objectApiName: LocationFinder_OBJECT })
 
    locationfinder;
 
    // now retriving the StageName picklist values of Opportunity
 
    @wire(getPicklistValues,{
            recordTypeId: '$locationfinder.data.defaultRecordTypeId',
            fieldApiName: LocationName_FIELD
        }
    )
    LocationPicklist;
 
    // display the selected picklist value
    @wire(getPicklistValues, {recordTypeId: '$locationfinder.data.defaultRecordTypeId', fieldApiName: SELECTSUBLOCATION_FIELD })
    subLocationInfo({ data, error }) {
    if (data){
        this.sublocations = data;
    } 
}
  
    handleChange(event) {
 
        this.LocationValue = event.detail.value;
        this.picklistVal = this.LocationValue;
       if(this.picklistVal === 'Malls'){
          this.Malls = this.LocationValue ;
       }else{
        this.Malls = '';
       }
 
       if(this.picklistVal === 'Hotels'){
         this.Hotels = this.LocationValue ;
       }else{
        this.Hotels = '';
       }
 
       if(this.picklistVal === 'WaterPark'){
          this.WaterPark = this.LocationValue ;
       }else{
        this.WaterPark = '';
       }
       let key = this.sublocations.controllerValues[event.target.value];
        this.sublocations = this.sublocations.values.filter(opt => opt.validFor.includes(key));
    
    }
    
}