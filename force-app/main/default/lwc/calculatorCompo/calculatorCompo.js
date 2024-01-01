import { LightningElement } from 'lwc';

export default class CalculatorCompo extends LightningElement {
    currentResult;
    firstNo;
    secondNo;
    previousList = [];
    numHandler(event)
    {
        const inputBoxName = event.target.name;
        if(inputBoxName === 'First Number')
        {
            this.firstNo = event.target.value;
        }
        else if(inputBoxName === 'Second Number')
        {
            this.secondNo = event.target.value;
        }
    }

    addHandler()
    {
        this.fno = parseInt(this.firstNo);
        this.sno = parseInt(this.secondNo);
        this.currentResult = `Result of ${this.fno} + ${this.sno}  is = ${this.fno+this.sno}`;
        this.previousList.push(this.currentResult);
    }

    subHandler()
    {
        this.fno = parseInt(this.firstNo);
        this.sno = parseInt(this.secondNo);
        this.currentResult = `Result of ${this.fno} - ${this.sno}  is = ${this.fno-this.sno}`;
        this.previousList.push(this.currentResult);
    }

    mulHandler()
    {
        this.fno = parseInt(this.firstNo);
        this.sno = parseInt(this.secondNo);
        this.currentResult = `Result of ${this.fno} * ${this.sno}  is = ${this.fno*this.sno}`;
        this.previousList.push(this.currentResult);
    }

    divHandler()
    {
        this.fno = parseInt(this.firstNo);
        this.sno = parseInt(this.secondNo);
        this.currentResult = `Result of ${this.fno} / ${this.sno}  is = ${this.fno/this.sno}`;
        this.previousList.push(this.currentResult);
    }

    pervShow = false;
    showPrevResult()
    {
        this.pervShow=true;
    }
}