export enum UpDown {
  UP,
  Down,
}

export enum Key {
  ZERO, ONE, TWO, THREE, FOUR, FIVE,
  SIX, SEVEN, EIGHT, NINE, CLEAR
}

export enum Delivery {
  OFF, SLOW1, FAST1, SLOW2, FAST2, SLOW3, FAST3,
}

export enum Fuel {
  ONE, TWO, THREE
}

export enum End {
  END
}

export class Sale {
  constructor(
    public readonly fuel: Fuel,
    public readonly price: number,
    public readonly cost: number,
    public readonly quantity: number,
  ) {}
}
