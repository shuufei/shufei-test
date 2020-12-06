import { browser, $, by, element } from 'protractor';
export class ReportPage {
  async navigateTo(): Promise<unknown> {
    return browser.get(`${browser.baseUrl}/report`);
  }

  async getTitleText(): Promise<string> {
    return $('app-root .page-title').getText();
  }

  async getCount(): Promise<string> {
    return $(`[data-test="count"]`).getText();
  }

  async increment(): Promise<void> {
    await element(by.buttonText('increment')).click();
  }
}
