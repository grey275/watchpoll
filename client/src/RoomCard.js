import React from 'react';
import { Card, Icon, Image, Button } from 'semantic-ui-react'
import { Link } from 'react-router-dom';

const LinkedCard = ({room_id, card}) => (
  <Link to={`/rooms/${room_id}`}>
    {card}
  </Link>
)

const RoomCard = ({playlist_title, thumbnail, room_name, room_id}) => {
  return (
    <Card  className="room-card">
      <img src={thumbnail.url} alt=""/>
      <Card.Content>
        <Card.Header>{room_name}</Card.Header>
      </Card.Content>
      <Card.Content extra>
        <Icon name='video' />
        {playlist_title}
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