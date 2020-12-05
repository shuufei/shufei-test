import { ChangeDetectionStrategy, Component, Input, OnInit } from '@angular/core';

type LocalState = {
  title: string;
  isCompleted: boolean;
};
@Component({
  selector: 'app-todo-item',
  templateUrl: './todo-item.component.html',
  styleUrls: ['./todo-item.component.scss'],
  changeDetection: ChangeDetectionStrategy.OnPush
})
export class TodoItemComponent implements OnInit {
  @Input()
  set title(value: LocalState['title']) {
    this.state.title = value;
  }
  get title(): LocalState['title'] {
    return this.state.title;
  }

  @Input()
  set isCompleted(value: LocalState['isCompleted']) {
    this.state.isCompleted = value;
  }
  get isCompleted(): LocalState['isCompleted'] {
    return this.state.isCompleted;
  }

  private state: LocalState = {
    title: '',
    isCompleted: false
  };

  constructor() { }

  ngOnInit(): void {
  }

  toggle(): void {
    this.state.isCompleted = !this.state.isCompleted;
  }

}
