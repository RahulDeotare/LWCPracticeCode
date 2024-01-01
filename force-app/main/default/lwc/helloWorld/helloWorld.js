import Address from '@salesforce/schema/Lead.Address';
import { LightningElement } from 'lwc';

export default class HelloWorld extends LightningElement {
    myName// undefined
    fName='Rahul'
    lName='Deo'
    showFlag=true
    num=254896

    Account={
        Name:'Eternus',
        Addr: 'Baner',
        PinCode:'411045'
    }
    myCustList=['abba','dabba','chabba']
}