import { of, Subject, Observable } from 'rxjs';
import { pluck, share, last, shareReplay, tap, distinctUntilChanged } from 'rxjs/operators';

// const observable = of(1, 2, 3);
// observable.subscribe(v => console.log('--- v: ', v));

const routeEnd = new Subject<{data: any, url: string}>();
const lastUrl = routeEnd.pipe(
  tap(_ => console.log('executed')),
  distinctUntilChanged((p, q) => p.url === q.url),
  pluck('url'),
  // share()
  shareReplay(1)
);

const initialSubscriber = lastUrl.subscribe(console.log);

routeEnd.next({data: {}, url: 'my-path'});
const lateSubscriber = lastUrl.subscribe(console.log);

const lateSubscriber2 = lastUrl.subscribe(console.log);

routeEnd.next({data: {}, url: 'my-path'});

function distinctUntilChangedTest() {
  const subject = new Subject<number>();
  let observable = subject.pipe(
    distinctUntilChanged(),
  );

  observable.subscribe(console.log);

  subject.next(1);
  subject.next(1);
  subject.next(2);
  subject.next(1);
}

distinctUntilChangedTest();
