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
      preference_order_mapping: [],
    };
  }
  initPreferenceOrderMapping = length => (
    _.shuffle( _.range(length))
      .map(index => ({origin_index: index}))
 )

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
        this.setState({
          standings_with_details: data,
          preference_order_mapping: this.initPreferenceOrderMapping(data.length),
        });
      })
  }

  get_ordered_standings() {
    const { standings_with_details, preference_order_mapping } = this.state;
    console.log(preference_order_mapping)
    return preference_order_mapping.map(preference => standings_with_details[preference.origin_index])
  }

  onSortEnd = ({oldIndex, newIndex}) => {
    console.log('sort end!');
    this.setState(({preference_order_mapping}) => {
      const new_preference_order_mapping = arrayMove(preference_order_mapping, oldIndex, newIndex);
      new_preference_order_mapping[newIndex].moved = true;
      return {preference_order_mapping: new_preference_order_mapping};
    });
  };


  render() {
    const { gapi } = this.props;
    const { standings_length } = this.state;
    const ordered_standings = this.get_ordered_standings();
    console.log(ordered_standings)
    return (
      <section id="room">
        <VideoPlayer gapi={gapi} />
        <Poll standings={ordered_standings} standings_length={standings_length} onSortEnd={this.onSortEnd}/>
      </section>
    );
  }

}

const RoomPresenter = ({standings, standings_length, onSortEnd, gapi}) => {
  return (
    <section id="room">
    </section>
  )
};
      // <VideoPlayer gapi={gapi} />
      // <Poll standings={standings} standings_length={standings_length} onSortEnd={onSortEnd}/>

export default RoomContainer;
