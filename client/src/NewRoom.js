import React from 'react';
import Axios from 'axios';
import { Form, Button, Segment, Grid, Header } from 'semantic-ui-react';
import parse from 'url-parse';
import { Redirect, } from 'react-router-dom';


const NewRoom = () => (
  <Grid textAlign='center' style={{ height: '95vh' }} verticalAlign='middle'>
    <Grid.Column style={{ maxWidth: 450 }}>
      <Segment stacked>
        <Header as="h2">Create a Room</Header>
        <NewRoomForm />
      </Segment>
    </Grid.Column>
  </Grid>
)

class NewRoomForm extends React.Component {
  state = { name: "", playlist_url: '', runtime: 15, room_id:null }

  parsePlaylistUrl = () => {
  }

  postRoom = async () => {
    const { name, playlist_url, runtime } = this.state;
    const playlist_uid = parse(playlist_url, true).query.list
    return await Axios.post('/api/rooms', {name, playlist_uid, runtime})
  }

  onChange = event => {
    const { value, name } = event.target;
    this.setState({ [name]: value })
  }

  onSubmit = async () => {
    const { room_id } = (await this.postRoom()).data;
    console.log('room id',room_id );
    this.setState({room_id})
  }

  render() {
    const { name, playlist_url, room_id, runtime } = this.state;
    if (room_id) {
      return <Redirect to={`/rooms/${room_id}`} />
    }
    return (
      <Form size="large" onSubmit={this.onSubmit}>
        <Form.Field required>
          <label>Name</label>
          <input placeholder='Playlist Name' name="name" value={name} onChange={this.onChange} />
        </Form.Field>
        <Form.Field>
          <label>Playlist Url</label>
          <input placeholder='Playlist Link' name="playlist_url" value={playlist_url} onChange={this.onChange} />
        </Form.Field>
        <Form.Field required>
          <label>Video Runtime</label>
          <input name="runtime" value={runtime} onChange={this.onChange} />
        </Form.Field>
        <Button type='submit'>Submit</Button>
      </Form>
    )
  }
}

export default NewRoom;