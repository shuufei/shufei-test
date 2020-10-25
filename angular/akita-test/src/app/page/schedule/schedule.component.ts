import { Component, OnInit } from '@angular/core';
import { TaskService } from '../../service/task.service';
import { TaskQuery } from '../../query/task.query';

@Component({
  selector: 'app-schedule',
  templateUrl: './schedule.component.html',
  styleUrls: ['./schedule.component.scss'],
})
export class ScheduleComponent implements OnInit {
  readonly state$ = this.taskQuery.state$;
  constructor(private taskService: TaskService, private taskQuery: TaskQuery) {}

  ngOnInit(): void {
    this.taskService.loadTask();
    console.log('schedule: ', this.taskQuery.getValue());
  }
}
