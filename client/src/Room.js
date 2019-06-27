import React from 'react';
import { Tab } from 'semantic-ui-react';
import  ActionCable  from 'actioncable';

import VideoPlayer from './VideoPlayer';
import TagList from './TagList';
import Chat from './Chat';
import Poll from './Poll'
import Axios from 'axios';

import { DOMAIN_NAME, API_ROUTE, ROOM_ID } from './constants';
const full_socket_route = 'ws:/${SOCKET_ROUTE}.{API_DOMAIN_NAME}'
console.log('socket_route: ', full_socket_route);
class RoomContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = { standings: [] };
  }

  render() {
    const { standings } = this.state
    return (
      <RoomPresenter gapi={this.props.gapi} standings={standings}/>
    );
  }

  async getVideosInfo(video_uids) {
    await this.props.gapi.client.load("https://www.googleapis.com/discovery/v1/apis/youtube/v3/rest");
    const response = await this.props.gapi.client.youtube.videos.list({
      part: 'snippet,contentDetails',
      id: video_uids.join(),
    })
    console.log('response: ', response);
  }

  componentDidMount() {
    Axios.get('http://localhost:3000/api/rooms/9')
    .then(res => {

    })
    .then(res => {
      this.setState({standings: res.data.standings})
    })
    // console.log(await Axios.get(`http://${DOMAIN_NAME}/${API_ROUTE}${ROOM_ID}`));
  }
}

const RoomPresenter = ({standings, gapi}) => {
  return (
    <section id="room">
      <VideoPlayer gapi={gapi} />
      <Poll standings={standings} gapi={gapi}/>
    </section>
  )
};

export default RoomContainer;
