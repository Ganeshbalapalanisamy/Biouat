import { LightningElement,api } from 'lwc';

export default class HelloWorldy extends LightningElement {

    clickedButtonLabel;

    handleClick(event) {
        this.clickedButtonLabel = event.target.label;
        alert('Enter Value is :' + this.clickedButtonLabel )
    }

}