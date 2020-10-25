import { NgModule } from '@angular/core';
import { CommonModule } from '@angular/common';
import { ScheduleComponent } from './schedule.component';
import { SchedulePageRoutingModule } from './schedule-routing.module';
import { TaskStore } from '../../store/task.store';
import { TaskService } from '../../service/task.service';
import { TaskQuery } from '../../query/task.query';

const store = new TaskStore();
const service = new TaskService(store);
const query = new TaskQuery(store);

@NgModule({
  declarations: [ScheduleComponent],
  imports: [CommonModule, SchedulePageRoutingModule],
  providers: [
    { provide: TaskStore, useValue: store },
    { provide: TaskService, useValue: service },
    { provide: TaskQuery, useValue: query },
  ],
})
export class ScheduleModule {}
