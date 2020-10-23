import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';

import { AppComponent } from './app.component';
import { HelloButtonComponent } from './hello-button/hello-button.component';
import { HelloButton2Component } from './hello-button2/hello-button2.component';

@NgModule({
  declarations: [
    AppComponent,
    HelloButtonComponent,
    HelloButton2Component
  ],
  imports: [
    BrowserModule,
    FormsModule
  ],
  providers: [],
  bootstrap: [AppComponent],
  entryComponents: [HelloButtonComponent, HelloButton2Component]
})
export class AppModule { }
