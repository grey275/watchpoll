import React from 'react';
import { Tab } from 'semantic-ui-react';
import  ActionCable  from 'actioncable';

import VideoPlayer from './VideoPlayer';
import TagList from './TagList';
import Chat from './Chat';
import Poll from './Poll'
import Axios from 'axios';

const { API_DOMAIN_NAME, SOCKET_ROUTE } = './constants';
const full_socket_route = 'ws:/${SOCKET_ROUTE}.{API_DOMAIN_NAME}'
console.log('socket_route: ', full_socket_route);
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
    const cable = ActionCable.createConsumer(full_socket_route);
    cable.subscriptions.create("poll")
  }
}

const RoomPresenter = () => (
  <section id="room">
    <VideoPlayer />
    <Poll />
  </section>
);

export default RoomContainer;
