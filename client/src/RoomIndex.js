import React from 'react'
import Axios from 'axios'
import { Link } from 'react-router-dom';


class RoomIndex extends React.Component {
  constructor(props){
      super(props)
      this.state = { rooms: []}
  }
  getRooms(){
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
      return(
        <div>
            <div>
                <Link to='/'>Return to Room</Link>
            </div>

            <div className="roomWrapper">
                <ul className="roomList">
                    {this.state.rooms.map((room) => {
                        return(
                            <React.Fragment>

                            <p><Link to='/'>{room.room_name}</Link></p>
                            <p>Playlist: {room.playlist_uid}</p> 

                            </React.Fragment>
                        );
                    })}
                </ul>

            </div>
        </div>
      )
  }
}

export default RoomIndex