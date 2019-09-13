import React from 'react';
import _ from 'lodash';

import { Feed, Icon, Comment } from 'semantic-ui-react';

const CommentEvent = () => {
  const c = <Comment>
    {/* <Comment.Avatar src='https://react.semantic-ui.com/images/avatar/small/matt.jpg' /> */}
      <Comment.Content>
        <Comment.Author as='a'>Matt</Comment.Author>
        <Comment.Metadata>
          <div>Today at 5:42PM</div>
        </Comment.Metadata>
        <Comment.Text>loreMagna et culpa magna deserunt ea fugiat nisi sunt magna culpa.m
        </Comment.Text>
    </Comment.Content>
  </Comment>
  return c
};

class Chat extends React.Component {
  constructor() {
    super();
    this.state = { someKey: 'someValue' };
  }

  render() {
    const comments = _.range(10).map(() => <CommentEvent />)
    return (
      <Comment.Group id="chat">
        {comments}
      </Comment.Group>
    )
  }

  componentDidMount() {
    this.setState({ someKey: 'otherValue' });
  }
}

export default Chat;
