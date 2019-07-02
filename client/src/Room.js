import React from 'react';
import  ActionCable  from 'actioncable';
import _ from 'lodash';

import VideoPlayer from './VideoPlayer';
import Poll from './Poll'
import Axios from 'axios';

import { DOMAIN_NAME, API_ROUTE, SOCKET_ROUTE } from './constants';

class RoomContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      standings: [],
      current_video_state: null,
      video_end_time: null,
      poll_video_snippets: [],
      preference_order_mapping: [],
      session_id: null,
      poll_id: null,
    };
  }

  getStandingsWithSnippets = (video_standings, video_snippets) => {
    console.log('getting candidate videos')
    return _.zipWith(video_standings, video_snippets, (standing, snippet) => {
      console.log('title: ', snippet.title)
      console.log('points: ', standing.points)
      return { ...snippet, ...standing }
     });
  }

  handleRoomBroadcast = async ({ standings, poll_id, current_video_state, current_sessions, }) => {
    console.log('standings: ', standings)
    console.log('poll_id: ', poll_id)
    console.log('video: ', current_video_state.title)
    standings = standings || []

    const to_set = {
      standings,
      current_sessions,
    };

    if ((poll_id && poll_id !== this.state.poll_id) || (this.state.snippets &&this.state.snippets.length === 0)) {
      console.log('setting snippets');
      to_set.snippets = await this.getVideoSnippets(standings);
      to_set.poll_id = poll_id;
      to_set.current_video_state = current_video_state
      console.log('snippets: ', to_set.snippets);
    }

    console.log('setting state')
    this.setState(to_set);
  }

  getSessionId = async () => {
    const response = await Axios.post(`http://${DOMAIN_NAME}/${API_ROUTE}/rooms/${this.props.room_id}/user_sessions`);
    console.log('session id', response.data.session_id)
    return response.data.session_id
  }

  subscribeToChannels = async () => {
    const cable = ActionCable.createConsumer(`http://${DOMAIN_NAME}/${SOCKET_ROUTE}`)
    console.log('room id: ', this.props.room_id);
    console.log(cable)
    global.cable = cable
    const rooms_channel = cable.subscriptions.create({
      channel: 'RoomsChannel',
      room_id: this.props.room_id,
    }, {
      connected: () => {
        rooms_channel.send({session_id: this.state.session_id});
        console.log('subbed!')
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
    console.log('items: ', response.result.items)
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
        console.log('snippet: ', snippet)
        console.log('standing: ', standing)
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
      current_video_state
    } = this.state;

    const standings_with_snippets = standings.length > 0 && snippets.length > 0
      ? this.getStandingsWithSnippets(standings, snippets)
      : [];

    return (
      <section id="room">
        <VideoPlayer
          gapi={gapi}
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
      </section>
    );
  }

}

export default RoomContainer;
