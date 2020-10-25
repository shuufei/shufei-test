import { Injectable } from '@angular/core';
import { TaskStore, Task } from '../store/task.store';

@Injectable()
export class TaskService {
  constructor(private store: TaskStore) {}

  loadTask(): void {
    const task: Task = {
      id: 1,
      title: 'title1',
      description: 'description',
    };
    this.store.setLoading(true);
    this.updateTask(task);
    this.store.setLoading(false);
  }

  private updateTask(task: Task): void {
    this.store.update({ task });
  }
}
