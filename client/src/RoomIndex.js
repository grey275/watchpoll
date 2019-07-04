import React from 'react'
import Axios from 'axios'
import _ from 'lodash';
import { Link, Switch, Route, } from 'react-router-dom';
import { Placeholder, Container, Grid } from 'semantic-ui-react';


import { API_ROUTE, DOMAIN_NAME } from './constants';
import Room from './Room'
import RoomCard from './RoomCard';


class RoomIndex extends React.Component {
  constructor(props){
    super(props)
    this.state = {
      card_data: [],
    }
  }

  getRooms = async () => (
    (await Axios.get(`/${API_ROUTE}/rooms`)).data
  )

  getCurrentVideoThumbnails = async (current_video_uids) => {
    await this.props.gapi.client.load("https://www.googleapis.com/discovery/v1/apis/youtube/v3/rest");
    const response = await this.props.gapi.client.youtube.videos.list({
      part: 'snippet',
      id: current_video_uids.join(),
    })
    console.log(response)
    return response.result.items.map(item => item.snippet.thumbnails.medium)
  }

  getCardData = async () => {
    const { gapi } = this.props;
    const rooms = await this.getRooms();
    console.log('rooms: ', rooms)
    const current_video_uids = rooms.map(room => room.current_video_uid);
    const thumbnails = await this.getCurrentVideoThumbnails(current_video_uids);
    console.log('thumbnails, ', thumbnails)
    return (_.zipWith(
      rooms, thumbnails,
      ({playlist_title, room_id, room_name}, thumbnail) => ({
        playlist_title, room_id, room_name, thumbnail,
    }))
    )
  }

  componentDidMount(){
    console.log('mounted')
    this.getCardData()
      .then(card_data => {
        this.setState({card_data})
      })
  }

  build_cards = card_data => (
    card_data.map(data => (
      <RoomCard {...data} key={data.room_id} />
    ))
    .sort((a, b) => (a.room_id - b.room_id))
  )

  render(){
    const { card_data } = this.state;
    console.log('data at render', card_data);
    const cards = card_data
      ? this.build_cards(card_data)
      : <Placeholder />

    return(
      <Grid fluid textAlign="center" id="room-cards" >
        {cards}
      </Grid>
    )
  }

}

export default RoomIndex