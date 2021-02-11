import { Field, ObjectType, Int, registerEnumType, InputType, PartialType, OmitType, PickType } from '@nestjs/graphql';
import { Post } from '../../posts/models/post.models';
import { FieldMiddleware, MiddlewareContext, NextFn } from '@nestjs/graphql';

const loggerMiddleware: FieldMiddleware = async (
  ctx: MiddlewareContext,
  next: NextFn,
) => {
  const value = await next();
  console.log(value);
  return value;
};

export enum RoleType {
  System,
  Company,
}

registerEnumType(RoleType, {
  name: 'RoleType'
})

@ObjectType()
export class Author {
  @Field(type => Int, {
    middleware: [loggerMiddleware]
  })
  id: number;

  @Field({ nullable: true })
  firstName?: string;

  @Field({ nullable: true })
  lastName?: string;

  @Field(type => [Post], {nullable: 'itemsAndList'})
  posts: Post[];

  @Field(types => RoleType, {nullable: true})
  roleType?: RoleType
}

@InputType()
export class CreateAuthorInput {
  @Field({nullable: true})
  firstName?: string;

  @Field({nullable: true})
  lastName?: string;
}

@InputType()
export class UpdateAuthorInput extends CreateAuthorInput {}
