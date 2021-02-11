// import { Query } from "@nestjs/common";
import { Args, Int, Resolver, Query, Mutation, ArgsType, Field, InputType, ResolveField, Parent } from "@nestjs/graphql";
import { Post } from "src/posts/models/post.models";
import { Author, CreateAuthorInput, UpdateAuthorInput } from './models/author.models';

// @ArgsType()
@InputType()
class UpvotePostArgs {
  @Field(returns => Int)
  postId: number;

  @Field({nullable: true})
  title: string;
}

@Resolver(of => Author)
export class AuthorsResolver {
  @Query(returns => [Author])
  async authors(): Promise<Author[]> {
    return [
      {
        id: 99,
        posts: []
      },
      {
        id: 88,
        posts: []
      },
      {
        id: 77,
        posts: []
      },
    ]
  }

  @Query(returns => Author)
  async author(@Args('id', { type: () => Int }) id: number): Promise<Author> {
    return {
      id,
      posts: []
    };
  }

  @ResolveField('posts', returns => [Post])
  async getPosts(@Parent() author: Author): Promise<Post[]> {
    console.log('--- get posts: ', author);
    const { id } = author;
    // return this.postsService.findAll({ authorId: id });
    return [
      {
        id: 11,
        title: 'post-11'
      },
      {
        id: 22,
        title: 'post-22'
      },
      {
        id: 33,
        title: 'post-33'
      }
    ];
  }

  @Mutation(returns => Author)
  async createAuthor(@Args('params') params: CreateAuthorInput): Promise<Author> {
    console.log('--- create params: ', params);
    return {
      id: 99,
      firstName: params.firstName,
      lastName: params.lastName,
      posts: []
    };
  }

  @Mutation(returns => Author)
  async updateAuthor(@Args('params') params: UpdateAuthorInput): Promise<Author> {
    console.log('--- update params: ', params);
    return {
      id: 88,
      firstName: params.firstName,
      lastName: params.lastName,
      posts: []
    }
  }

  @Mutation(returns => Post)
  async upvotePost(@Args('upvotePostData') args: UpvotePostArgs): Promise<Post> {
    // return this.postsService.upvoteById({ id: postId });
    console.log('---- postid: ', args.postId);
    return {
      id: 0,
      title: 'ttiel',
      votes: 1
    };
  }

}
