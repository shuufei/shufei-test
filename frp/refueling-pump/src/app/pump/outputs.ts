import { Observable } from 'rxjs';
import { startWith } from 'rxjs/operators';

import * as T from './types';

export class Outputs {

  public readonly delivery$ = new Observable<T.Delivery>().pipe(startWith(T.Delivery.OFF));
  public readonly presetLCD$ = new Observable<string>().pipe(startWith(''));
  public readonly saleCostLCD$ = new Observable<string>().pipe(startWith(''));
  public readonly saleQuantity$ = new Observable<string>().pipe(startWith(''));
  public readonly priceLCD1$ = new Observable<string>().pipe(startWith(''));
  public readonly priceLCD2$ = new Observable<string>().pipe(startWith(''));
  public readonly priceLCD3$ = new Observable<string>().pipe(startWith(''));
  public readonly beep$ = new Observable<undefined>();
  public readonly saleComplete$ = new Observable<T.Sale>();

  constructor(
    delivery$: Observable<T.Delivery>,
    presetLCD$: Observable<string>,
    saleCostLCD$: Observable<string>,
    saleQuantity$: Observable<string>,
    priceLCD1$: Observable<string>,
    priceLCD2$: Observable<string>,
    priceLCD3$: Observable<string>,
    beep$: Observable<undefined>,
    saleComplete$: Observable<T.Sale>,
  ) {
    this.delivery$ = delivery$;
    this.presetLCD$ = presetLCD$;
    this.saleCostLCD$ = saleCostLCD$;
    this.saleQuantity$ = saleQuantity$;
    this.priceLCD1$ = priceLCD1$;
    this.priceLCD2$ = priceLCD2$;
    this.priceLCD3$ = priceLCD3$;
    this.beep$ = beep$;
    this.saleComplete$ = saleComplete$;
  }

  setDelivery(delivery$: Observable<T.Delivery>) {
    return new Outputs(
      delivery$,
      this.presetLCD$,
      this.saleCostLCD$,
      this.saleQuantity$,
      this.priceLCD1$,
      this.priceLCD2$,
      this.priceLCD3$,
      this.beep$,
      this.saleComplete$,
    );
  }

  setPresetLCD(presetLCD$: Observable<string>) {
    return new Outputs(
      this.delivery$,
      presetLCD$,
      this.saleCostLCD$,
      this.saleQuantity$,
      this.priceLCD1$,
      this.priceLCD2$,
      this.priceLCD3$,
      this.beep$,
      this.saleComplete$,
    );
  }

  setSaleCostLCD(saleCostLCD$: Observable<string>) {
    return new Outputs(
      this.delivery$,
      this.presetLCD$,
      saleCostLCD$,
      this.saleQuantity$,
      this.priceLCD1$,
      this.priceLCD2$,
      this.priceLCD3$,
      this.beep$,
      this.saleComplete$,
    );
  }

  setSaleQuantity(saleQuantity$: Observable<string>) {
    return new Outputs(
      this.delivery$,
      this.presetLCD$,
      this.saleCostLCD$,
      saleQuantity$,
      this.priceLCD1$,
      this.priceLCD2$,
      this.priceLCD3$,
      this.beep$,
      this.saleComplete$,
    );
  }

  setPriceLCD1(priceLCD1$: Observable<string>) {
    return new Outputs(
      this.delivery$,
      this.presetLCD$,
      this.saleCostLCD$,
      this.saleQuantity$,
      priceLCD1$,
      this.priceLCD2$,
      this.priceLCD3$,
      this.beep$,
      this.saleComplete$,
    );
  }

  setPriceLCD2(priceLCD2$: Observable<string>) {
    return new Outputs(
      this.delivery$,
      this.presetLCD$,
      this.saleCostLCD$,
      this.saleQuantity$,
      this.priceLCD1$,
      priceLCD2$,
      this.priceLCD3$,
      this.beep$,
      this.saleComplete$,
    );
  }

  setPriceLCD3(priceLCD3$: Observable<string>) {
    return new Outputs(
      this.delivery$,
      this.presetLCD$,
      this.saleCostLCD$,
      this.saleQuantity$,
      this.priceLCD1$,
      this.priceLCD2$,
      priceLCD3$,
      this.beep$,
      this.saleComplete$,
    );
  }

  setBeep(beep$: Observable<undefined>) {
    return new Outputs(
      this.delivery$,
      this.presetLCD$,
      this.saleCostLCD$,
      this.saleQuantity$,
      this.priceLCD1$,
      this.priceLCD2$,
      this.priceLCD3$,
      beep$,
      this.saleComplete$,
    );
  }

  setSaleComplete(saleComplete$: Observable<T.Sale>) {
    return new Outputs(
      this.delivery$,
      this.presetLCD$,
      this.saleCostLCD$,
      this.saleQuantity$,
      this.priceLCD1$,
      this.priceLCD2$,
      this.priceLCD3$,
      this.beep$,
      saleComplete$,
    );
  }
}
