import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-hello-button2',
  templateUrl: './hello-button2.component.html',
  styleUrls: ['./hello-button2.component.scss']
})
export class HelloButton2Component implements OnInit {
  @Input() value: string;

  displayValue = '';

  constructor() {
    this.value = 'hello';
  }

  ngOnInit() {
  }

  onClicked() {
    this.displayValue = `2-Clicked: ${this.value}`;
  }

}
