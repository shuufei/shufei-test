import { Stream, Cell } from 'sodiumjs';

import * as T from './types';

export class Inputs {
  constructor(
    public readonly sNozzle1: Stream<T.UpDown>,
    public readonly sNozzle2: Stream<T.UpDown>,
    public readonly sNozzle3: Stream<T.UpDown>,
    public readonly sKeypad: Stream<T.Key>,
    public readonly fuelPulses: Cell<number>,
    public readonly calibration: Cell<number>,
    public readonly price1: Cell<number>,
    public readonly price2: Cell<number>,
    public readonly price3: Cell<number>,
    public readonly sClearSale$: Stream<undefined>,
  ) {}
}