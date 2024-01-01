import { LightningElement } from 'lwc';

export default class TestLocationComponent extends LightningElement {

    handleClick() {
        checkUserLocation();
    } 
    checkUserLocation() {
        if ('geolocation' in navigator) {
            navigator.geolocation.getCurrentPosition(
                function(position) {
                    // User's current latitude and longitude
                    const userLat = position.coords.latitude;
                    const userLng = position.coords.longitude;
    
                    console.log('User location:', userLat, userLng);
    
                    // Coordinates of the allowed area (e.g., office location)
                    const allowedLat = 18.5421607;
                    const allowedLng = 73.8139574;
    
                    // Calculate distance between user and allowed location (in meters)
                    const distance = calculateDistance(userLat, userLng, allowedLat, allowedLng);
    
                    // Set a radius of 100 meters (adjust as needed)
                    const radius = 100;
                    console.log('Distance from allowed location:', distance, 'meters');
                    // Check if the user is within the allowed radius
                    if (distance <= radius) {
                        // User is within the allowed radius, allow login
                        console.log('User is within the allowed radius.');
                        // Proceed with login or perform necessary actions
                    } else {
                        // User is outside the allowed radius, restrict login
                        console.log('User is outside the allowed radius.');
                        // Show a message or prevent login
                    }
                },
                function(error) {
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
    function calculateDistance(lat1, lon1, lat2, lon2) {
        const R = 6371e3; // Earth's radius in meters
        const φ1 = toRadians(lat1);
        const φ2 = toRadians(lat2);
        const Δφ = toRadians(lat2 - lat1);
        const Δλ = toRadians(lon2 - lon1);
    
        const a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
            Math.cos(φ1) * Math.cos(φ2) *
            Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
        const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    
        return R * c; // Distance in meters
    }
    
    function toRadians(degrees) {
        return degrees * Math.PI / 180;
    }
    
    // Call the function to check user location when needed
    checkUserLocation();
    
}