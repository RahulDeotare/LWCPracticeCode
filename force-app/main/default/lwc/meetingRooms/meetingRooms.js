import { LightningElement } from 'lwc';

export default class MeetingRooms extends LightningElement {

    ifRoomsAvailable=false;
    meetingRoomsInfo=[
        {roomName:'A-101',roomSize:'10'},
        {roomName:'A-102',roomSize:'12'},
        {roomName:'A-103',roomSize:'14'},
        {roomName:'B-101',roomSize:'18'},
        {roomName:'B-102',roomSize:'6'},
        {roomName:'B-103',roomSize:'4'}
    ];

    showAvailableRooms(event){
        this.ifRoomsAvailable=event.target.checked;
    }
}