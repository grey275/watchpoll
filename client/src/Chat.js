import React from 'react';
import _ from 'lodash';

const Comment = (index) => (
  <div key={index}>
    <label>username:</label>
    I'm a comment that's a bit longer, lets see how this'll work out
  </div>
)

class Chat extends React.Component {
  constructor() {
    super();
    this.state = { someKey: 'someValue' };
  }

  render() {
    const comments = _.range(10).map(Comment)
    return (
      <section id="chat">
        {comments}
      </section>
    )
  }

  componentDidMount() {
    this.setState({ someKey: 'otherValue' });
  }
}

export default Chat;
