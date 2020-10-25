import { Component, OnInit } from '@angular/core';
import { TaskService } from '../../service/task.service';
import { TaskQuery } from '../../query/task.query';

@Component({
  selector: 'app-project',
  templateUrl: './project.component.html',
  styleUrls: ['./project.component.scss'],
})
export class ProjectComponent implements OnInit {
  readonly state$ = this.taskQuery.state$;

  constructor(private taskService: TaskService, private taskQuery: TaskQuery) {}

  ngOnInit(): void {
    this.taskService.loadTask();
    const value = this.taskQuery.getValue();
  }
}
