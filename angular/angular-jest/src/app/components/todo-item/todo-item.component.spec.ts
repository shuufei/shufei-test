import { ComponentFixture, TestBed } from '@angular/core/testing';
import { By } from '@angular/platform-browser';
import { runChangeDetection } from 'src/tests/changeDetectionForOnPush';

import { TodoItemComponent } from './todo-item.component';

describe('TodoItemComponent', () => {
  let component: TodoItemComponent;
  let fixture: ComponentFixture<TodoItemComponent>;

  beforeEach(async () => {
    await TestBed.configureTestingModule({
      declarations: [ TodoItemComponent ]
    })
    .compileComponents();
  });

  beforeEach(() => {
    fixture = TestBed.createComponent(TodoItemComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  test('should create', () => {
    expect(component).toBeTruthy();
  });

  test('コンポーネントに指定したタイトルが表示される', async () => {
    const title = 'hanashiro';
    component.title = title;
    await runChangeDetection(fixture);
    expect(fixture).toMatchSnapshot();
  });

  test(`コンポーネントのisCompletedにfalseを指定したとき、状態表示部分に 'todo' が表示される`, async () => {
    component.isCompleted = false;
    await runChangeDetection(fixture);
    expect(fixture).toMatchSnapshot();
  });

  test(`コンポーネントのisCompletedにtrueを指定したとき、状態表示部分に 'completed' が表示される`, async () => {
    component.isCompleted = true;
    await runChangeDetection(fixture);
    expect(fixture).toMatchSnapshot();
  });

  test(`isCompletedがtrueの状態でtoggleボタンを押下したとき、状態表示部分に 'todo' が表示される`, async () => {
    component.isCompleted = true;
    await runChangeDetection(fixture);
    const buttonDebugEl = fixture.debugElement.query(By.css('.toggle-button'));
    (buttonDebugEl.nativeElement as HTMLButtonElement).click();
    await runChangeDetection(fixture);
    expect(fixture).toMatchSnapshot();
  });

  test(`isCompletedがfalseの状態でtoggleボタンを押下したとき、状態表示部分に 'completed' が表示される`, async () => {
    component.isCompleted = false;
    await runChangeDetection(fixture);
    const buttonDebugEl = fixture.debugElement.query(By.css('.toggle-button'));
    (buttonDebugEl.nativeElement as HTMLButtonElement).click();
    await runChangeDetection(fixture);
    expect(fixture).toMatchSnapshot();
  });

});
