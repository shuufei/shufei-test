import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ScheduleComponent } from './schedule.component';
import { SchedulePageRoutingModule } from './schedule-routing.module';

@NgModule({
  declarations: [ScheduleComponent],
  imports: [CommonModule, SchedulePageRoutingModule],
})
export class ScheduleModule {}
