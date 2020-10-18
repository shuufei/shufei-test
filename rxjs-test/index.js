"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const rxjs_1 = require("rxjs");
const operators_1 = require("rxjs/operators");
// const observable = of(1, 2, 3);
// observable.subscribe(v => console.log('--- v: ', v));
const routeEnd = new rxjs_1.Subject();
const lastUrl = routeEnd.pipe(operators_1.tap(_ => console.log('executed')), operators_1.distinctUntilChanged((p, q) => p.url === q.url), operators_1.pluck('url'), 
// share()
operators_1.shareReplay(1));
const initialSubscriber = lastUrl.subscribe(console.log);
routeEnd.next({ data: {}, url: 'my-path' });
const lateSubscriber = lastUrl.subscribe(console.log);
const lateSubscriber2 = lastUrl.subscribe(console.log);
routeEnd.next({ data: {}, url: 'my-path' });
function distinctUntilChangedTest() {
    const subject = new rxjs_1.Subject();
    let observable = subject.pipe(operators_1.distinctUntilChanged());
    observable.subscribe(console.log);
    subject.next(1);
    subject.next(1);
    subject.next(2);
    subject.next(1);
}
distinctUntilChangedTest();
//# sourceMappingURL=index.js.map