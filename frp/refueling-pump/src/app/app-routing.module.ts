import { NgModule } from '@angular/core';
import { Routes, RouterModule } from '@angular/router';
import { PumpComponent } from './pump/pump.component';


const routes: Routes = [
  { path: '', component: PumpComponent }
];

@NgModule({
  imports: [RouterModule.forRoot(routes)],
  exports: [RouterModule]
})
export class AppRoutingModule { }
