import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { HelloButton2Component } from './hello-button2.component';

describe('HelloButton2Component', () => {
  let component: HelloButton2Component;
  let fixture: ComponentFixture<HelloButton2Component>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ HelloButton2Component ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(HelloButton2Component);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
