import React from 'react';
import { Tab } from 'semantic-ui-react';
import { ActionCable } from 'actioncable';

import { API_WS_ROOT } from './constants';
import VideoPlayer from './VideoPlayer';
import TagList from './TagList';
import Chat from './Chat';

class RoomContainer extends React.Component {
  constructor() {
    super();
    this.state = { someKey: 'someValue' };
  }

  render() {
    return (
      <RoomPresenter />
    );
  }

  componentDidMount() {


    const cable = ActionCable.createConsumer(API_WS_ROOT);
    cable.subscriptions.create("")
  }
}

const RoomPresenter = () => (
  <section id="room">
    <VideoPlayer />
    <Poll />
  </section>
);

export default RoomContainer;
