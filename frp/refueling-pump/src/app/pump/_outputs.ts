import { Cell, Stream } from 'sodiumjs';

import * as T from './types';

export class Outputs {

  public readonly delivery = new Cell<T.Delivery>(T.Delivery.OFF);
  public readonly presetLCD = new Cell<string>('');
  public readonly saleCostLCD = new Cell<string>('');
  public readonly saleQuantityLCD = new Cell<string>('');
  public readonly priceLCD1 = new Cell<string>('');
  public readonly priceLCD2 = new Cell<string>('');
  public readonly priceLCD3 = new Cell<string>('');
  public readonly sBeep = new Stream<undefined>();
  public readonly sSaleComplete = new Stream<T.Sale>();

  constructor(
    delivery: Cell<T.Delivery>,
    presetLCD: Cell<string>,
    saleCostLCD: Cell<string>,
    saleQuantityLCD: Cell<string>,
    priceLCD1: Cell<string>,
    priceLCD2: Cell<string>,
    priceLCD3: Cell<string>,
    sBeep: Stream<undefined>,
    sSaleComplete: Stream<T.Sale>,
  ) {
    this.delivery = delivery;
    this.presetLCD = presetLCD;
    this.saleCostLCD = saleCostLCD;
    this.saleQuantityLCD = saleQuantityLCD;
    this.priceLCD1 = priceLCD1;
    this.priceLCD2 = priceLCD2;
    this.priceLCD3 = priceLCD3;
    this.sBeep = sBeep;
    this.sSaleComplete = sSaleComplete;
  }

  public setDelivery(delivery: Cell<T.Delivery>) {
    return new Outputs(
      delivery,
      this.presetLCD,
      this.saleCostLCD,
      this.saleQuantityLCD,
      this.priceLCD1,
      this.priceLCD2,
      this.priceLCD3,
      this.sBeep,
      this.sSaleComplete,
    );
  }

  public setPresetLCD(presetLCD: Cell<string>) {
    return new Outputs(
      this.delivery,
      presetLCD,
      this.saleCostLCD,
      this.saleQuantityLCD,
      this.priceLCD1,
      this.priceLCD2,
      this.priceLCD3,
      this.sBeep,
      this.sSaleComplete,
    );
  }

  public setSaleCostLCD(saleCostLCD: Cell<string>) {
    return new Outputs(
      this.delivery,
      this.presetLCD,
      saleCostLCD,
      this.saleQuantityLCD,
      this.priceLCD1,
      this.priceLCD2,
      this.priceLCD3,
      this.sBeep,
      this.sSaleComplete,
    );
  }

  public setSaleQuantityLCD(saleQuantityLCD: Cell<string>) {
    return new Outputs(
      this.delivery,
      this.presetLCD,
      this.saleCostLCD,
      saleQuantityLCD,
      this.priceLCD1,
      this.priceLCD2,
      this.priceLCD3,
      this.sBeep,
      this.sSaleComplete,
    );
  }

  public setPriceLCD1(priceLCD1: Cell<string>) {
    return new Outputs(
      this.delivery,
      this.presetLCD,
      this.saleCostLCD,
      this.saleQuantityLCD,
      priceLCD1,
      this.priceLCD2,
      this.priceLCD3,
      this.sBeep,
      this.sSaleComplete,
    );
  }

  public setPriceLCD2(priceLCD2: Cell<string>) {
    return new Outputs(
      this.delivery,
      this.presetLCD,
      this.saleCostLCD,
      this.saleQuantityLCD,
      this.priceLCD1,
      priceLCD2,
      this.priceLCD3,
      this.sBeep,
      this.sSaleComplete,
    );
  }

  public setPriceLCD3(priceLCD3: Cell<string>) {
    return new Outputs(
      this.delivery,
      this.presetLCD,
      this.saleCostLCD,
      this.saleQuantityLCD,
      this.priceLCD1,
      this.priceLCD2,
      priceLCD3,
      this.sBeep,
      this.sSaleComplete,
    );
  }

  public setBeep(sBeep: Stream<undefined>) {
    return new Outputs(
      this.delivery,
      this.presetLCD,
      this.saleCostLCD,
      this.saleQuantityLCD,
      this.priceLCD1,
      this.priceLCD2,
      this.priceLCD3,
      sBeep,
      this.sSaleComplete,
    );
  }

  public setSaleComplete(sSaleComplete: Stream<T.Sale>) {
    return new Outputs(
      this.delivery,
      this.presetLCD,
      this.saleCostLCD,
      this.saleQuantityLCD,
      this.priceLCD1,
      this.priceLCD2,
      this.priceLCD3,
      this.sBeep,
      sSaleComplete,
    );
  }

}
