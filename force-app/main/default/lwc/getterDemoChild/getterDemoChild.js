import { api, LightningElement } from 'lwc';

export default class GetterDemoChild extends LightningElement {
    userdetail
    @api 
    get detail(){
        return this.userdetail
    }
    set detail(data){
        let newAge=data.age*2
        this.userdetail={...data, age:newAge,"location":"Melbourne"}
    }
}