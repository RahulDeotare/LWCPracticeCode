import { LightningElement } from 'lwc';

export default class MyCalculataor extends LightningElement {
    currentResult
    firstNum
    secondNum
    previousList=[];
    numHandler(event){
       const inputBox= event.target.name
       if(inputBox==='firstNumber'){
        this.firstNum=event.target.value
       }
       if(inputBox==='secondNumber'){
        this.secondNum=event.target.value
        }
    }
    addHandler(){
        this.fno = parseInt(this.firstNum);
        this.sno = parseInt(this.secondNum);
        this.currentResult = `Result of ${this.fno} + ${this.sno}  is = ${this.fno+this.sno}`;
        this.previousList.push(this.currentResult);
    }
    subHandler(){
        this.fno=parseInt(this.firstNum)
        this.sno=parseInt(this.secondNum)
        this.currentResult=`Result of ${this.fno} - ${this.sno} is = ${this.fno-this.sno}`
        this.previousList.push(this.currentResult)
    }
    mulHandler(){
        this.fno=parseInt(this.firstNum)
        this.sno=parseInt(this.secondNum)
        this.currentResult=`Result of ${this.fno} * ${this.sno} is = ${this.fno*this.sno}`
        this.previousList.push(this.currentResult)
    }
    divHandler(){
        this.fno=parseInt(this.firstNum)
        this.sno=parseInt(this.secondNum)
        this.currentResult=`Result of ${this.fno} / ${this.sno} is = ${this.fno/this.sno}`
        this.previousList.push(this.currentResult)
    }
    showPrevFlag=false
    showPrevResult(){
        this.showPrevFlag=true
    }
}