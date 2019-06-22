import React from 'react';

import VideoPlayer from './VideoPlayer';
import Chat from './Chat';
import Poll from './Poll';

class Room extends React.Component {
  constructor() {
    super();
    this.state = { someKey: 'someValue' };
  }

  render() {
    return (
      <section id="room">
        <VideoPlayer />
        <Chat />
        <Poll />
      </section>
    )
  }

  componentDidMount() {
    this.setState({ someKey: 'otherValue' });
  }
}

export default Room;
