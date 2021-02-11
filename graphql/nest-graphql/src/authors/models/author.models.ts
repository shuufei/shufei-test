import { Field, ObjectType, Int } from '@nestjs/graphql';
import { Post } from '../../posts/models/post.module';

@ObjectType()
export class Author {
  @Field(type => Int)
  id: number;

  @Field({ nullable: true })
  firstName?: string;

  @Field({ nullable: true })
  lastName?: string;

  @Field(type => [Post])
  posts: Post[];
}
