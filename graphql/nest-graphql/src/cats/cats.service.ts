import { Injectable } from '@nestjs/common';
import { Cat } from './interfaces/cat.interface';
import { Observable, of } from 'rxjs';

@Injectable()
export class CatsService {
  private readonly cats: Cat[] = [];

  create(cat: Cat): Observable<void> {
    this.cats.push(cat);
    return of(undefined);
  }

  findAll(): Observable<Cat[]> {
    return of(this.cats);
  }

}
