import { Options } from "cypress-image-snapshot";

declare namespace Cypress {
  interface Chainable {
    matchImageSnapshot(nameOrOption: string | Options): void;
  }
}