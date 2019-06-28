import React from 'react';
import { Tab, AccordionTitle } from 'semantic-ui-react';
import  ActionCable  from 'actioncable';
import _ from 'lodash';

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
    this.state = { standings: [], standings_with_details: [] };
  }

  render() {
    const { standings } = this.state
    return (
      <RoomPresenter gapi={this.props.gapi} {...this.state}/>
    );
  }

  getRoomData = async () => {
    const response = await Axios.get('http://localhost:3000/api/rooms/9')
    console.log('response: ', response.data)
    const { standings } = response.data
    const video_uids = standings.map(standing => standing.video_uid);
    const video_items = await this.getVideoItems(video_uids);
    const standings_with_details = _.zipWith(standings, video_items, (standings, item) => {
      return {...standings, ...item.snippet};
    })

    return standings_with_details;
  }

  getVideoItems = async (video_uids) => {
    await this.props.gapi.client.load("https://www.googleapis.com/discovery/v1/apis/youtube/v3/rest");
    const response = await this.props.gapi.client.youtube.videos.list({
      part: 'snippet',
      id: video_uids.join(),
    })
    return response.result.items;
  }

  componentDidMount() {
    this.getRoomData()
      .then(data => {
        console.log('data!')
        this.setState({standings_with_details: data});
      })
  }
}

const RoomPresenter = ({standings_with_details, standings_length, gapi}) => {
  return (
    <section id="room">
      <VideoPlayer gapi={gapi} />
      <Poll standings_with_details={standings_with_details} standings_length={standings_length} />
    </section>
  )
};

export default RoomContainer;
