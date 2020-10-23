import { Component, Injector } from '@angular/core';
import { createCustomElement } from '@angular/elements';
import { HelloButtonComponent } from './hello-button/hello-button.component';
import { HelloButton2Component } from './hello-button2/hello-button2.component';

@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.scss']
})
export class AppComponent {
  title = 'angular-elements-test';

  constructor(private injector: Injector) {
    const HelloButtonElement = createCustomElement(HelloButtonComponent, { injector: this.injector });
    customElements.define('app-hello-button', HelloButtonElement);

    const HelloButton2Element = createCustomElement(HelloButton2Component, { injector: this.injector });
    customElements.define('app-hello-button2', HelloButton2Element);
  }

}
