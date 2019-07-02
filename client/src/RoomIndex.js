import React from 'react'
import Axios from 'axios'
import { Link, Switch, Route, } from 'react-router-dom';

import Room from './Room'
// import { API_ROUTE } from 'constants';


const RoomCard = ({room}) => {
  return (
    <React.Fragment>
      <Link
        to={`/rooms/${room.room_id}`}
      >
        {room.room_name}
      </Link>
        <p>Playlist: {room.playlist_uid}</p>
    </React.Fragment>
  )
}


class RoomIndex extends React.Component {
  constructor(props){
    super(props)
    this.state = { 
      rooms: [],
      playlist: []
    }
  }
  getRooms() {
    return Axios.get('/api/rooms')
    // Axios.get('/api/rooms')
    // .then(response => {
    //   this.setState({rooms: response.data})
    // })
    // .catch(error => console.log(error))
  }
  
  getRoomVideoDetail = async(current_video_ids) => {
    //console.log('call to getRoomVideoDetail ');
    await this.props.gapi.client.load("https://www.googleapis.com/discovery/v1/apis/youtube/v3/rest");
    //const current_video_ids = this.state.rooms.map(room => room.current_video_id);
    const response = await this.props.gapi.client.youtube.videos.list({
      part: 'snippet',
      id: current_video_ids.join(),
    })
    
    
    console.log('items: ', response.result.items)
    return response.result.items.map(item => item.snippet);
  }
  
  
  
  componentDidMount(){
    this.getRooms()
    .then(response => {
      console.log(response)
      const current_video_ids = response.data.map(room => room.current_video_id);
      console.log("Testing curr video ",  current_video_ids.length);
      this.getRoomVideoDetail(current_video_ids)  
       .then(playlist_items => {
         console.log(playlist_items)
      //    this.setState({playlist:  response.data, })
      })
      this.setState({rooms: response.data, })

    })
    .catch(error => console.log(error))
  }

  render(){
    const { rooms } = this.state;
    const { gapi } = this.props;

    // const current_video_ids = rooms.map(room => room.current_video_id);
    // console.log(current_video_ids.length);
    // const playlist_items = this.getRoomVideoDetail(current_video_ids);
    

    console.log('gapi: ', gapi)
    const room_links = rooms.map((room) => {
      console.log('room: ', room);

      // let hi = <getRoomVideoDetail video_id={room.current_video_id} />
      // console.log('hi = ', hi);
      
      return(
        <React.Fragment>
        <Link
          to={`/rooms/${room.room_id}`}
          key={room.room_id}
        >
          {room.room_name}
        </Link>
        <p>Playlist: {room.playlist_uid}</p>
        <p>Current Video Id: {room.current_video_id}</p> 
        </React.Fragment>
      )
  })
    console.log('components', room_links)
    return(
      <div>
        <section className="roomWrapper">
          <Switch>
            <Route
              exact
              path={'/rooms'}
            >
              {room_links}
            </Route>
            <Route
              path="/rooms/:room_id"
              render={({match}) => {
                console.log('match: ', match);
                return (
                  <Room
                    room_id={match.params.room_id}
                    gapi={gapi}
                  >
                  </Room>
                )
              }}
            >
            </Route>
          </Switch>
        </section>
      </div>
        )
      }
    }

    export default RoomIndex