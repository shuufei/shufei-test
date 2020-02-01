
import * as T from './types';
import { Stream, Cell, CellLoop } from 'sodiumjs';

export class LifeCycle {
  public readonly sStart: Stream<T.Fuel>;
  public readonly sEnd: Stream<T.End>;
  public readonly fillActive: Cell<T.Fuel | null>;

  private static whenLifted(sNozzle: Stream<T.UpDown>, nozzleFuel: T.Fuel) {
    return sNozzle
      .filter(u => u === T.UpDown.UP)
      .map(u => nozzleFuel);
  }

  private static whenSetDown(
    sNozzle: Stream<T.UpDown>,
    nozzleFuel: T.Fuel,
    fillActive: Cell<T.Fuel | null>
  ) {
    return sNozzle.snapshot(fillActive, (u, f) => {
      return u === T.UpDown.Down && nozzleFuel === f ? T.End.END : null;
    }).filterNotNull() as Stream<T.End>;
  }

  constructor(
    sNozzle1: Stream<T.UpDown>,
    sNozzle2: Stream<T.UpDown>,
    sNozzle3: Stream<T.UpDown>,
  ) {
    const sLiftNozzle =
      LifeCycle.whenLifted(sNozzle1, T.Fuel.ONE).orElse(
      LifeCycle.whenLifted(sNozzle2, T.Fuel.TWO).orElse(
      LifeCycle.whenLifted(sNozzle3, T.Fuel.THREE)));

    const fillActive = new CellLoop<T.Fuel | null>();
    this.fillActive = fillActive;

    this.sStart = sLiftNozzle.snapshot(
      fillActive,
      (newFuel, _fillActive) => _fillActive != null ? null : newFuel
    ).filterNotNull() as Stream<T.Fuel>;

    this.sEnd =
      LifeCycle.whenSetDown(sNozzle1, T.Fuel.ONE, fillActive).orElse(
      LifeCycle.whenSetDown(sNozzle2, T.Fuel.TWO, fillActive).orElse(
      LifeCycle.whenSetDown(sNozzle3, T.Fuel.THREE, fillActive)));

    fillActive.loop(
      this.sEnd.map(e => null as (T.Fuel | null))
        .orElse(this.sStart.map(v => v as (T.Fuel | null)))
        .hold(null)
    );

  }
}
