import React from 'react';
import { Card, Icon, Image } from 'semantic-ui-react'
import { Link } from 'react-router-dom';

const LinkedCard = ({room_id, card}) => (
  <Link to={`/rooms/${room_id}`}>
    {card}
  </Link>
)

const RoomCard = ({playlist_title, thumbnail, room_name, room_id}) => {
  return (
    <Card>
      <img src={thumbnail.url} alt=""/>
      <Card.Content>
        <Card.Header>{room_name}</Card.Header>
      </Card.Content>
      <Card.Content extra>
        <a>
          <Icon name='video' />
          {playlist_title}
        </a>
      </Card.Content>
    </Card>
  )
}

export default props => (
  <LinkedCard
    room_id={props.room_id}
    card={<RoomCard{...props} />}
    />
)

// const RoomCard = ({room}) => {
//   return (
//     <React.Fragment>
//       <Link
//         to={`/rooms/${room.room_id}`}
//       >
//         {room.room_name}
//       </Link>
//         <p>Playlist: {room.playlist_uid}</p>
//     </React.Fragment>
// //   )
// // }
// import React from 'react'
// import { Card, Icon, Image } from 'semantic-ui-react'

// const CardExampleCard = () => (
//   <Card>
//     <Image src='/images/avatar/large/matthew.png' wrapped ui={false} />
//     <Card.Content>
//       <Card.Header>Matthew</Card.Header>
//       <Card.Meta>
//         <span className='date'>Joined in 2015</span>
//       </Card.Meta>
//       <Card.Description>
//         Matthew is a musician living in Nashville.
//       </Card.Description>
//     </Card.Content>
//     <Card.Content extra>
//       <a>
//         <Icon name='user' />
//         22 Friends
//       </a>
//     </Card.Content>
//   </Card>
// )

// export default CardExampleCard