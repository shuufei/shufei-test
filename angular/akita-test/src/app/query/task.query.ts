import { Injectable } from '@angular/core';
import { Query } from '@datorama/akita';
import { TaskState, TaskStore } from '../store/task.store';

@Injectable()
export class TaskQuery extends Query<TaskState> {
  readonly state$ = this.select();

  constructor(protected store: TaskStore) {
    super(store);
  }
}
