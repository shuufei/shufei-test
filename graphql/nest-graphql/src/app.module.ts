import { MiddlewareConsumer, Module, NestModule, RequestMethod } from '@nestjs/common';
import { GraphQLModule } from '@nestjs/graphql';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { AuthorsResolver } from './authors/authors.resolver';
import { CatsModule } from './cats/cats.module';
import { LoggerMiddleware, logger } from './logger.middleware';
@Module({
  imports: [
    GraphQLModule.forRoot({
      autoSchemaFile: 'schema.gql'
    }),
    CatsModule,
  ],
  controllers: [AppController],
  providers: [AppService, AuthorsResolver],
})
export class AppModule implements NestModule {
  configure(consumer: MiddlewareConsumer): void {
    consumer.apply(
      // LoggerMiddleware
      logger
    ).forRoutes({
      path: 'cats',
      method: RequestMethod.GET
    });
  }
}
