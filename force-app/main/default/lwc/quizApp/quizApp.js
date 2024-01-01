import { LightningElement } from 'lwc';

export default class QuizApp extends LightningElement {

    selected={};
    correctAns=0;
    isSubmitted=false;
    myQuestions=[
        {
            id:'Question 1',
            question:'What is the capital of India?',
            answers:{
                a:'Nagpur',
                b:'Mumbai',
                c:'Delhi',
                d:'None of the above'
            },
            correctAnswer:'c'
        },
        {
            id:'Question 2',
            question:'What is the capital of Maharashtra?',
            answers:{
                a:'Nagpur',
                b:'Mumbai',
                c:'PUNE',
                d:'None of the above'
            },
            correctAnswer:'b'
        },
        {
            id:'Question 3',
            question:'What is the capital of USA?',
            answers:{
                a:'WASHIGTON dc',
                b:'New York',
                c:'Michigan',
                d:'Florida'
            },
            correctAnswer:'a'
        }
]
    changeHandle(event){
        console.log('name', event.target.name);
        console.log('value', event.target.value);
        const {name, value}=event.target;
        this.selected={...this.selected, [name]:value}

    }
    submitHandler(event){
        event.preventDefault()
        let correct=this.myQuestions.filter(item=>this.selected[item.id]===item.correctAnswer)
        this.correctAns=correct.length;
        this.isSubmitted=true;
        console.log('this.correctAns',this.correctAns)
    }
    resetHandler(){
        this.selected={}
        this.correctAns=0
        this.isSubmitted=false
    }
    get allNotSelected(){
        return !(Object.keys(this.selected).length===this.myQuestions.length)
    }
    get isScoredFull(){
        return `slds-text-heading_large ${this.myQuestions.length===this.correctAns?
        'slds-text-color_success':'slds-text-color_error'}`
    }
}