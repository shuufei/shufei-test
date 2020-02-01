import { Component, OnInit } from '@angular/core';
import { BehaviorSubject } from 'rxjs';

import * as T from './types';
import { LifeCycle } from './life-cycle';

@Component({
  selector: 'app-pump',
  templateUrl: './pump.component.html',
  styleUrls: ['./pump.component.scss']
})
export class PumpComponent implements OnInit {

  Fuel = T.Fuel;

  private pump1Subject = new BehaviorSubject(T.UpDown.Down);
  private pump2Subject = new BehaviorSubject(T.UpDown.Down);
  private pump3Subject = new BehaviorSubject(T.UpDown.Down);
  private lc: LifeCycle;

  select = new BehaviorSubject('cat');

  constructor() {
    this.lc = new LifeCycle(this.pump1$, this.pump2$, this.pump3$);
    this.lc.start$.subscribe(v => console.log('--- start: ', v));
    this.lc.end$.subscribe(v => console.log('--- end: ', v));
    this.lc.fillActive$.subscribe(v => console.log('--- fillActive: ', v));
  }

  ngOnInit() {
    const selected: BehaviorSubject<string> = new BehaviorSubject('cat');
    this.select.subscribe((v) => selected.next(v));

    selected.subscribe(v => console.log(v));
  }

  get pump1$() { return this.pump1Subject.asObservable(); }
  get pump2$() { return this.pump2Subject.asObservable(); }
  get pump3$() { return this.pump3Subject.asObservable(); }

  onClicked(fuel: T.Fuel) {
    console.log('--- clicked fuel: ', fuel);
    switch (fuel) {
      case T.Fuel.ONE:
        this.pump1Subject.next(T.UpDown.UP);
        break;
      case T.Fuel.TWO:
        this.pump2Subject.next(T.UpDown.UP);
        break;
      case T.Fuel.THREE:
        this.pump3Subject.next(T.UpDown.UP);
        break;
      default:
        break;
    }
  }

}
