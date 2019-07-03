import React from 'react';
import  ActionCable  from 'actioncable';
import _ from 'lodash';

import VideoPlayer from './VideoPlayer';
import ControlPanel from './ControlPanel';
import Poll from './Poll'
import Axios from 'axios';

import { DOMAIN_NAME, API_ROUTE, SOCKET_ROUTE } from './constants';

const timeFromString = (str) => (new Date(str).getTime());
class RoomContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      standings: [],
      current_video_state: null,
      poll_video_snippets: [],
      preference_order_mapping: [],
      session_id: null,
      poll_id: null,
      onSyncClick: null,
      current_video_time: null,
    };
  }

  onPlay = (event) => {
    const { current_video_time } = this.state;
    const current_video_seconds = current_video_time / 1000
    console.log('event: ', event)
    if (current_video_time === null) {
      throw 'current_video_time not set'
    }
    console.log('playing')
    this.setState({
      onSyncClick: () => {
        event.target.seekTo(current_video_seconds);
      }
    })
  }


  getStandingsWithSnippets = (video_standings, video_snippets) => {
    return _.zipWith(video_standings, video_snippets, (standing, snippet) => {
      return { ...snippet, ...standing }
     });
  }

  getCurrentVideoTime = (start_time) => (
    (new Date().getTime() - new Date(start_time).getTime())
  )

  handleRoomBroadcast = async ({ standings, poll_id, current_video_state, num_of_users, }) => {
    standings = standings || []

    const to_set = {
      standings,
      num_of_users,
      next_video_time: current_video_state.end_time,
      current_video_time: this.getCurrentVideoTime(current_video_state.start_time),
    };
    console.log('current video time', to_set.current_video_time)

    if ((poll_id && poll_id !== this.state.poll_id) || (this.state.snippets && this.state.snippets.length === 0)) {
      to_set.snippets = await this.getVideoSnippets(standings);
      to_set.poll_id = poll_id;
      to_set.current_video_state = current_video_state
    }

    this.setState(to_set);
  }

  getSessionId = async () => {
    const response = await Axios.post(`http://${DOMAIN_NAME}/${API_ROUTE}/rooms/${this.props.room_id}/user_sessions`);
    return response.data.session_id
  }

  subscribeToChannels = async () => {
    const cable = ActionCable.createConsumer(`http://${DOMAIN_NAME}/${SOCKET_ROUTE}`)
    global.cable = cable
    const rooms_channel = cable.subscriptions.create({
      channel: 'RoomsChannel',
      room_id: this.props.room_id,
    }, {
      connected: () => {
        rooms_channel.send({session_id: this.state.session_id});
       },
      received: this.handleRoomBroadcast,
    })
  }

  getVideoSnippets = async (standings) => {
    const video_uids = standings.map(standing => standing.video_uid);
    await this.props.gapi.client.load("https://www.googleapis.com/discovery/v1/apis/youtube/v3/rest");
    const response = await this.props.gapi.client.youtube.videos.list({
      part: 'snippet',
      id: video_uids.join(),
    })
    return response.result.items.map(item => item.snippet)
  }

  broadcastSetup = async () => {
    this.setState({session_id: await this.getSessionId()})
    this.subscribeToChannels()
  }

  componentDidMount() {
    this.broadcastSetup()
  }

  getCandidateVideosWithPoints = (standings, candidate_videos) => (
    _.zipWith(
      candidate_videos, standings,
      (snippet, standing) => {
        return { ...snippet, ...standing,  }
      }
    )
  )

  render() {
    const { gapi, room_id } = this.props;
    const {
      snippets,
      standings,
      session_id,
      poll_id,
      current_video_state,
      num_of_users,
      next_video_time,
      onSyncClick,
    } = this.state;
    const standings_with_snippets = standings.length > 0 && snippets.length > 0
      ? this.getStandingsWithSnippets(standings, snippets)
      : [];

    return (
      <section id="room">
        <VideoPlayer
          gapi={gapi}
          onPlay={this.onPlay}
          {...current_video_state}
        />
        <Poll
          standings_with_snippets={standings_with_snippets}
          onSortEnd={this.onSortEnd}
          standings={standings}
          session_id={session_id}
          poll_id={poll_id}
          room_id={room_id}
        />
        <ControlPanel
          num_of_users={num_of_users}
          next_video_time={next_video_time}
          onSyncClick={onSyncClick}
        />
      </section>
    );
  }

}

export default RoomContainer;
