import { ReportPage } from './report.po';

describe('workspace-project Report', () => {
  let page: ReportPage;

  beforeEach(async() => {
    page = new ReportPage();
    await page.navigateTo();
  });

  it('should display page title', async () => {
    expect(await page.getTitleText()).toEqual('report works!');
  });

  it('should display count', async () => {
    expect(await page.getCount()).toEqual('0');
  });

  it('should display incremental count', async () => {
    await page.increment();
    expect(await page.getCount()).toEqual('1');
  });
});
