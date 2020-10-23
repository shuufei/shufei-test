import { Component, OnInit, Input } from '@angular/core';

@Component({
  selector: 'app-hello-button',
  templateUrl: './hello-button.component.html',
  styleUrls: ['./hello-button.component.scss']
})
export class HelloButtonComponent implements OnInit {
  @Input() value: string;

  displayValue = '';

  constructor() {
    this.value = 'hello';
  }

  ngOnInit() {
  }

  onClicked() {
    this.displayValue = `Clicked: ${this.value}`;
  }

}
