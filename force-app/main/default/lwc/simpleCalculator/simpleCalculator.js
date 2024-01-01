import { LightningElement,track } from 'lwc';

export default class SimpleCalculator extends LightningElement {
    @track currentResult;
    @track previousResultsArray=[];
    @track showPreResults=false;
    
    firstNumber;
    secondNumber;

    numberChangeHandler(event){
        const inputBoxNum=event.target.name;
        if(inputBoxNum==='firstNumber'){
            this.firstNumber=event.target.value;
        }
        else if(inputBoxNum==='secondNumber'){
            this.secondNumber=event.target.value;
        }
    }
    addHandler(){
            const firstN=parseInt(this.firstNumber);
            const secondN=parseInt(this.secondNumber);

            this.currentResult=`Result of ${firstN} + ${secondN} is ${firstN+secondN}`;
            this.previousResultsArray.push(this.currentResult);
    }
    subtractHandler(){
        const firstN=parseInt(this.firstNumber);
        const secondN=parseInt(this.secondNumber);

        this.currentResult=`Result of ${firstN} - ${secondN} is ${firstN-secondN}`;
        this.previousResultsArray.push(this.currentResult);
    }
    multiplyHandler(){
        const firstN=parseInt(this.firstNumber);
            const secondN=parseInt(this.secondNumber);

            this.currentResult=`Result of ${firstN} * ${secondN} is ${firstN*secondN}`;
            this.previousResultsArray.push(this.currentResult);
    }
    divideHandler(){
        const firstN=parseInt(this.firstNumber);
            const secondN=parseInt(this.secondNumber);

            this.currentResult=`Result of ${firstN} / ${secondN} is ${firstN/secondN}`;
            this.previousResultsArray.push(this.currentResult);
    }
    showPreviousResults(event){
        this.showPreResults=event.target.checked;
    }
}