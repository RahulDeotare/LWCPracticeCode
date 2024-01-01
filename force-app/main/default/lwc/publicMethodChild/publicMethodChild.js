import { LightningElement, track, api} from 'lwc';

export default class PublicMethodChild extends LightningElement {
    @track value=['red'];

    options=[
        {label: 'Red Label', value:'red'},
        {label: 'Green Label', value:'green'},
        {label: 'Blue Label', value:'blue'},
        {label: 'Black Label', value:'black'},

    ];
    @api
    selectCheckbox(checkboxValue){
        const selectedCheckbox= this.options.find( checkbox=>{
            return checkboxValue= checkbox.value;
        })
        if(selectedCheckbox){
            this.value=selectedCheckbox.value;
            return 'Successfully Checked';
        }
        return 'No checkbox found';
    }

}