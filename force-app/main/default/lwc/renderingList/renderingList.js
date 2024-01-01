import { LightningElement } from 'lwc';

export default class RenderingList extends LightningElement {

    contacts=[
        {
            Id: 1,
            LastName:'Deo',
            LeadSource:'web'
    },
    {
        Id: 2,
        LastName:'Pat',
        LeadSource:'phone'
}
]
}