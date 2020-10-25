import { Store, StoreConfig } from '@datorama/akita';

export class Task {
  constructor(
    public id: number,
    public title: string,
    public description: string
  ) {}
}

export type TaskState = {
  task?: Task;
};

export function createInitialState(): TaskState {
  return {};
}

@StoreConfig({ name: 'task' })
export class TaskStore extends Store<TaskState> {
  constructor() {
    super(createInitialState());
  }
}
