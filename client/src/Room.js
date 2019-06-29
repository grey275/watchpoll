import React from 'react';
import  ActionCable  from 'actioncable';
import _ from 'lodash';

import VideoPlayer from './VideoPlayer';
import Poll from './Poll'
import Axios from 'axios';

import { DOMAIN_NAME, API_ROUTE, SOCKET_ROUTE, ROOM_ID } from './constants';

class RoomContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      standings: [],
      candidate_videos: [],
      current_video: null,
      preference_order_mapping: [],
      session_id: null,
      poll_id: [],
    };
  }

  getNewCandidateVideos = async (standings) => {
    const video_uids = standings.map(standing => standing.video_uid);
    const video_items = await this.getVideoItems(video_uids);
    return _.zipWith(standings, video_items, (standing, item) => (
      { ...standing.video_id, ...item.snippet }
    ));
  }

  handleRoomBroadcast = async ({ standings, poll_id }) => {
    console.log('standings: ', standings)
    console.log('poll_id: ', poll_id)
    if (this.state.poll_id !== poll_id) {
      this.setState({
        candidate_videos: await this.getNewCandidateVideos(standings),
        standings, poll_id
      })
    } else {
      this.setState({standings});
    }
  }

  getSessionId = async () => {
    const response = await Axios.post(`http://${DOMAIN_NAME}/${API_ROUTE}/rooms/${ROOM_ID}/user_sessions`);
    console.log('session id', response.data.session_id)
    return response.data.session_id
  }

  subscribeToChannels = async () => {
    const cable = ActionCable.createConsumer(`http://${DOMAIN_NAME}/${SOCKET_ROUTE}`)
    console.log('room id: ', ROOM_ID);
    console.log(cable)
    global.cable = cable
    const rooms_channel = cable.subscriptions.create({
      channel: 'RoomsChannel',
      room_id: ROOM_ID,
    }, {
      connected: () => {
        rooms_channel.send({session_id: this.state.session_id});
       },
      received: this.handleRoomBroadcast,
    })
    console.log('subbed!')
  }

  getVideoItems = async (video_uids) => {
    await this.props.gapi.client.load("https://www.googleapis.com/discovery/v1/apis/youtube/v3/rest");
    const response = await this.props.gapi.client.youtube.videos.list({
      part: 'snippet',
      id: video_uids.join(),
    })
    console.log('items: ', response.result.items)
    return response.result.items;
  }

  broadcastSetup = async () => {
    this.setState({session_id: await this.getSessionId()})
    this.subscribeToChannels()
  }

  componentDidMount() {
    this.broadcastSetup()
  }
  render() {
    const { gapi } = this.props;
    const { candidate_videos, standings, session_id, poll_id } = this.state;
    const candidate_videos_with_points = _.zipWith(
      candidate_videos, standings,
      (video, standing) => ({
      ...video ,...standing,
    }))
    return (
      <section id="room">
        <VideoPlayer gapi={gapi} />
        <Poll
          candidate_videos_with_points={candidate_videos_with_points}
          onSortEnd={this.onSortEnd}
          standings={standings}
          session_id={session_id}
          poll_id={poll_id}
        />
      </section>
    );
  }

}


export default RoomContainer;
