'use strict';

const e = React.createElement;

class LikeButton extends React.Component {
  constructor(props) {
    super(props);
    this.state = { liked: false };
  }

  render() {
    if (this.state.liked) {
      return 'You liked comment number ' + this.props.commentID;
    }

    return (
      <button onClick={() => this.setState({ liked: true })}>
        Like
      </button>
    )
  }
}

const domContainerList = document.querySelectorAll('.like_button_container');
domContainerList.forEach(d => {
  const commentId = parseInt(d.dataset.commentid, 10);
  ReactDOM.render(
    <LikeButton commentID={commentId} />,
    d
  )
})
