import { Body, Controller, Get, Header, HttpCode, NotFoundException, Param, ParseIntPipe, Post, UseFilters, UseGuards, UseInterceptors, UsePipes, ValidationPipe } from '@nestjs/common';
import * as Joi from 'joi';
import { Observable, timer } from 'rxjs';
import { auditTime, debounceTime, switchMap, take } from 'rxjs/operators';
import { HttpExceptionFilter } from 'src/http-exception.filter';
import { TimeoutInterceptor } from 'src/timeout.interceptor';
import { CatsService } from './cats.service';
import { CreateCatDto } from './dto/create-cat.dto';
import { Cat } from './interfaces/cat.interface';
import { JoiValidationPipe } from './joi-validation.pipe';
import { LoggingInterceptor } from './logging.interceptor';
import { RolesGuard } from './role.guard';
// import { ValidationPipe } from './validation.pipe';

const createCatSchema = Joi.object({
  name: Joi.string(),
  age: Joi.number(),
  breed: Joi.string(),
});

@Controller('cats')
@UseGuards(RolesGuard)
@UseInterceptors(LoggingInterceptor, TimeoutInterceptor)
export class CatsController {

  constructor(
    private catsService: CatsService
  ) {}

  @Get()
  @UseFilters(HttpExceptionFilter)
  findAll(): Observable<Cat[]> {
    // throw new NotFoundException();
    return timer(0).pipe(
      take(1),
      switchMap(() => this.catsService.findAll())
    );
  }

  @Get(':id')
  async findOne(@Param('id', ParseIntPipe) id: number): Promise<string> {
    return new Promise(resolve => {
      setTimeout(() => {
        console.log('--- params: ', typeof id);
        resolve(`this action returns a ${id} cat`);
      }, 0);
    })
  }

  @Post()
  @HttpCode(200)
  @Header('Cache-Control', 'none')
  // @UsePipes(new JoiValidationPipe(createCatSchema))
  create(@Body(new ValidationPipe()) createCatDto: CreateCatDto): Observable<void> {
    console.log('-- body: ', createCatDto);
    return this.catsService.create(createCatDto);
  }
}