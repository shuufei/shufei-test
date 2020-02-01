import { Observable } from 'rxjs';

import * as T from './types';

export class Inputs {
  constructor(
    public readonly nozzle1$: Observable<T.UpDown>,
    public readonly nozzle2$: Observable<T.UpDown>,
    public readonly nozzle3$: Observable<T.UpDown>,
    public readonly keypad$: Observable<T.Key>,
    public readonly fuelPulses$: Observable<number>,
    public readonly calibration$: Observable<number>,
    public readonly price1$: Observable<number>,
    public readonly price2$: Observable<number>,
    public readonly price3$: Observable<number>,
    public readonly clearSale$: Observable<undefined>,
  ) {}
}
