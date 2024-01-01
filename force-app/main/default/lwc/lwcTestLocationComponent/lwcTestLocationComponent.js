import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

import FORM_FACTOR from '@salesforce/client/formFactor';
import mobilePage from './lwcTestLocationComponentMobile.html';
import desktopPage from './lwcTestLocationComponent.html';

import CreateRecord from '@salesforce/apex/CreateAttendenceRecord.createNewEntry';

export default class LwcTestLocationComponent extends LightningElement {

    @track ipAddress;
    showInputDetails = false;
    @track firstName = '';
    @track lastName = '';
    @track email = '';
    @track employeeId = '';
    @track attdId = '';
    //showToast=false;
    showLoginButton=false;
    isLoading = false;
    @track boolVisible=true;
    @track negativeBoolFlag=true;

    handleClick() {
        this.checkUserLocation();
        this.getIpAddress();
        this.isLoading = true;
    } 
    checkUserLocation() {
        if ('geolocation' in navigator) {
            navigator.geolocation.getCurrentPosition(
                (position)=> {

                    //for Ip address
                    // fetch('https://api.ipify.org?format=json')
                    // .then(response => response.json())
                    // .then(data => console.log(data));


                    // User's current latitude and longitude
                    const userLat = position.coords.latitude;
                    const userLng = position.coords.longitude;
    
                    console.log('User location:', userLat, userLng);
    
                    // Coordinates of the allowed area (e.g., office location)
                    const allowedLat = 18.5421511;
                    const allowedLng = 73.8038246;
                    
                    console.log('office location:', allowedLat, allowedLng);
                    // Calculate distance between user and allowed location (in meters)
                    const distance = this.calculateDistance(userLat, userLng, allowedLat, allowedLng);
    
                    // Set a radius of 100 meters (adjust as needed)
                    const radius = 2000;
                    console.log('Distance from allowed location:', distance, 'meters');
                    // Check if the user is within the allowed radius
                    if (distance <= radius) {
                        // User is within the allowed radius, allow login
                        console.log('User is within the allowed radius.');
                        this.isLoading = false;
                        this.showInputDetails = true;
                        this.showLoginButton=true;
                        // Proceed with login or perform necessary actions
                    } else {
                        // User is outside the allowed radius, restrict login
                        console.log('User is outside the allowed radius.');
                        // Show a message or prevent login
                        this.showInputDetails = false;
                        console.log('1st',this.negativeBoolFlag);
                        console.log('2nd',this.negativeBoolFlag);
                        this.showToast('error', 'Error','You are authorised to login only from office location');
                        this.boolVisible=false;
                        this.negativeBoolFlag = false;
                    }
                },
                (error)=> {
                    console.error('Error getting user location:', error);
                    // Handle error retrieving user location
                }
            );
        } else {
            console.error('Geolocation is not supported by this browser.');
            // Handle if geolocation is not supported
        }
    }
    
    // Function to calculate distance between two coordinates using Haversine formula
    calculateDistance(lat1, lon1, lat2, lon2) {
        const R = 6371e3; // Earth's radius in meters
        const φ1 = this.toRadians(lat1);
        const φ2 = this.toRadians(lat2);
        const Δφ = this.toRadians(lat2 - lat1);
        const Δλ = this.toRadians(lon2 - lon1);
    
        const a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
            Math.cos(φ1) * Math.cos(φ2) *
            Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    
        return R * c; // Distance in meters
    }
    
    toRadians(degrees) {
        return degrees * Math.PI / 180;
    }
    
    getIpAddress() {
        fetch('https://api.ipify.org?format=json')
            .then(response => response.json())
            .then(data => {
                this.ipAddress = data.ip; // Set the IP address to the tracked property
                console.log('IP Address:', this.ipAddress);
            })
            .catch(error => {
                console.error('Error fetching IP:', error);
                this.ipAddress = 'Failed to fetch'; // Set a default value or handle the error
            });
    }
    
    handleFirstNameChange(event) {
        this.firstName = event.target.value;
    }
    handleLastNameChange(event) {
        this.lastName = event.target.value;
    }
    handleEmailChange(event) {
        this.email = event.target.value;
    }
    handleEmloyeeIdChange(event) {
        this.employeeId = event.target.value;
    }

    CreateAttendance(){

            CreateRecord({firstName :this.firstName,lastName :this.lastName,email :this.email,employeeId :this.employeeId,ipAddress :this.ipAddress})
            .then((result) => {
                console.log('inside then result : '+result);
                this.attdId = result;
                console.log("attdId : " +this.attdId);
                console.log('inside Attendance created');
                this.boolVisible=false;
                console.log('3rd',this.negativeBoolFlag);
                this.negativeBoolFlag = true;
                console.log('4th',this.negativeBoolFlag);
                this.showToast('success', 'Success','Registration Completed!!');                  
            })
            .catch((error) => {
                console.log('JSON err : '+JSON.stringify(error));
                let statuscode=JSON.stringify(error.body.pageErrors[0].statusCode);
                statuscode = statuscode.substring(0,statuscode.length - 1);
                statuscode = statuscode.substring(1,statuscode.length);
                console.log('statuscode'+statuscode.substring(0,statuscode.length - 1));
                if(statuscode==='DUPLICATES_DETECTED'){
                    this.showToast('error', 'Error','Attendee already registered');
                }
                else{
                    console.log('5th',this.negativeBoolFlag);
                    this.showToast('error', 'Error','Attendee already registered');
                    this.boolVisible=false;
                    this.negativeBoolFlag = false;
                    console.log('6th',this.negativeBoolFlag);
                console.error('Error registration:', error);
                }
                
            });
    }
    showToast(variant, title, message) {
        const event = new ShowToastEvent({
            variant: variant,
            title: title,
            message: message,
        });
        this.dispatchEvent(event);
    }
    
    render() {
        return FORM_FACTOR === 'Small' ? mobilePage : desktopPage;
    }
}
