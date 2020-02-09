import Layout from '../components/MyLayout';
import Link from 'next/link';
import useSWR from 'swr';

function fetcher(url) {
  return fetch(url).then(r => r.json());
}

const PostLink = props => (
  <li>
    <Link href="/p/[id]" as={`/p/${props.id}`}>
      <a>{props.id}</a>
    </Link>
  </li>
);

export default function Blog() {
  const {data, error} = useSWR('/api/randomQuoto', fetcher);
  console.log(data, error)
  return (
    <Layout>
      <h1>My Blog</h1>
      <ul>
        <PostLink id="hello-nextjs" />
        <PostLink id="learn-nextjs" />
        <PostLink id="deploy-nextjs" />
      </ul>
    </Layout>
  );
}