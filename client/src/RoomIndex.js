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
    this.state = { rooms: []}
  }
  getRooms() {
    Axios.get('/api/rooms')
    .then(response => {
      this.setState({rooms: response.data})
    })
    .catch(error => console.log(error))
  }

  componentDidMount(){
    this.getRooms()
  }

  render(){
    const { rooms } = this.state;
    const { gapi } = this.props;
    console.log('gapi: ', gapi)
    const room_links = rooms.map((room) => {
      console.log('room: ', room)
      return(
        <Link
          to={`/rooms/${room.room_id}`}
          key={room.room_id}
        >
          room link
        </Link>
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