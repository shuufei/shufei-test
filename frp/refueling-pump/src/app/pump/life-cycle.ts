import { Observable, merge, of } from 'rxjs';

import * as T from './types';
import { filter, map, switchMap, take, startWith, last, withLatestFrom } from 'rxjs/operators';

export class LifeCycle {
  private start: T.Fuel | undefined;
  private fillActive: T.Fuel | undefined;

  public readonly start$: Observable<T.Fuel | undefined>;
  public readonly end$: Observable<T.End>;
  public readonly fillActive$: Observable<T.Fuel | undefined>;

  private static whenLifted(
    nozzle$: Observable<T.UpDown>,
    nozzleFuel: T.Fuel
  ) {
    return nozzle$.pipe(
      filter(v => v === T.UpDown.UP),
      map(v => nozzleFuel)
    );
  }

  private static whenSetDown(
    nozzle$: Observable<T.UpDown>,
    nozzleFuel: T.Fuel,
    fillActive$: Observable<T.Fuel | undefined>
  ) {
    return nozzle$.pipe(
      withLatestFrom(fillActive$),
      // switchMap(nozzleState => {
      //   return fillActive$.pipe(
      //     take(1),
      //     map(fillActive => {
      //       return [nozzleState, fillActive] as [T.UpDown, T.Fuel | undefined];
      //     })
      //   );
      // }),
      filter(([nozzleState, fillActive]) =>
        nozzleState === T.UpDown.Down && fillActive === nozzleFuel
      ),
      map(v => T.End.END)
    );
  }

  constructor(
    nozzle1$: Observable<T.UpDown>,
    nozzle2$: Observable<T.UpDown>,
    nozzle3$: Observable<T.UpDown>,
  ) {
    this.start$ = new Observable<T.Fuel | undefined>().pipe(startWith(undefined));
    this.end$ = new Observable();
    this.fillActive$ = new Observable<T.Fuel | undefined>().pipe(startWith(undefined));

    const liftNozzle$ = merge(
      LifeCycle.whenLifted(nozzle1$, T.Fuel.ONE),
      LifeCycle.whenLifted(nozzle2$, T.Fuel.TWO),
      LifeCycle.whenLifted(nozzle3$, T.Fuel.THREE),
    );

    this.start$ = liftNozzle$.pipe(
      withLatestFrom(this.fillActive$),
      filter(([_, fillActive]) => {
        return fillActive == null ? true : false;
      }),
      map(([newFuel, _]) => newFuel)
    );

    this.end$ = merge(
      LifeCycle.whenSetDown(nozzle1$, T.Fuel.ONE, this.fillActive$),
      LifeCycle.whenSetDown(nozzle2$, T.Fuel.TWO, this.fillActive$),
      LifeCycle.whenSetDown(nozzle3$, T.Fuel.THREE, this.fillActive$)
    );

    this.fillActive$ = merge(
      this.end$,
      this.start$
    ).pipe(
      map(v => {
        if (v === T.End.END) { return undefined; }
        return v;
      })
    );

    this.start$.subscribe(v => this.start = v);
    this.fillActive$.subscribe(v => this.fillActive = v);
  }
}
