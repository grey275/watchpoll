import React from 'react';
import  ActionCable  from 'actioncable';
import _ from 'lodash';
import arrayMove from 'array-move';

import VideoPlayer from './VideoPlayer';
import Poll from './Poll'
import Axios from 'axios';

import { DOMAIN_NAME, API_ROUTE, ROOM_ID } from './constants';
const full_socket_route = 'ws:/${SOCKET_ROUTE}.{API_DOMAIN_NAME}'
console.log('socket_route: ', full_socket_route);
class RoomContainer extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      standings: [],
      standings_with_details: [],
      current_video: null,
      preference_order_mapping: [],
    };
  }
  initPreferenceOrderMapping = length => (
    _.shuffle( _.range(length))
      .map(index => ({origin_index: index}))
 )

  getRoomData = async () => {
    const response = await Axios.get('http://localhost:3000/api/rooms/26')
    console.log('response: ', response.data)
    const { standings, current_video  } = response.data

    const video_uids = standings.map(standing => standing.video_uid);
    const video_items = await this.getVideoItems(video_uids);
    const standings_with_details = _.zipWith(standings, video_items, (standings, item) => {
      return {...standings, ...item.snippet};
    })

    return {standings_with_details, current_video};
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
        console.log('data', data);
        this.setState({
          ...data,
          preference_order_mapping: this.initPreferenceOrderMapping(data.standings_with_details.length),
        });
      })
  }

  get_ordered_standings() {
    const { standings_with_details, preference_order_mapping } = this.state;
    console.log(preference_order_mapping)
    return preference_order_mapping.map(preference => standings_with_details[preference.origin_index])
  }

  onSortEnd = ({oldIndex, newIndex}) => {
    this.setState(({preference_order_mapping}) => {
      console.log(this.getPreferenceOrder());
      const new_preference_order_mapping = arrayMove(preference_order_mapping, oldIndex, newIndex);
      new_preference_order_mapping[newIndex].moved = true;
      return {preference_order_mapping: new_preference_order_mapping};
    });
  };

  getPreferenceOrder = () => {
    const { preference_order_mapping, standings_with_details } = this.state;
    const order =  preference_order_mapping.map(mapping => (
      standings_with_details[mapping.origin_index].video_id
    ));
    return order;
  }

  render() {
    const { gapi } = this.props;
    const { standings_length } = this.state;
    const ordered_standings = this.get_ordered_standings();
    return (
      <section id="room">
        <VideoPlayer gapi={gapi} />
        <Poll ordered_standings={ordered_standings} standings_length={standings_length} onSortEnd={this.onSortEnd}/>
      </section>
    );
  }

}


export default RoomContainer;
