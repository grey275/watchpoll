import React from 'react';

import VideoPlayer from './VideoPlayer';
import TagList from './TagList';
import Chat from './Chat';
import Poll from './Poll';
import { Tab } from 'semantic-ui-react';

class Room extends React.Component {
  constructor() {
    super();
    this.state = { someKey: 'someValue' };
  }

  render() {

    return (
      <section id="room">
        <VideoPlayer />
        <Poll />
      </section>
    )
  }

  componentDidMount() {
    this.setState({ someKey: 'otherValue' });
  }
}

export default Room;
