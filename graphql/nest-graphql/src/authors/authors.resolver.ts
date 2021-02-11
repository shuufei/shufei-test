// import { Query } from "@nestjs/common";
import { Args, Int, Resolver, Query } from "@nestjs/graphql";
import { Author } from './models/author.models';

@Resolver(of => Author)
export class AuthorsResolver {
  @Query(returns => Author)
  async author(@Args('id', { type: () => Int }) id: number) {
    return {
      id,
      posts: []
    };
  }


}
