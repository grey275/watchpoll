import React, { Component } from 'react';

import Nav from './Nav';
import RoomIndex  from './RoomIndex';
import About  from './About';
import New  from './New';
import { Switch, Route, Redirect } from 'react-router-dom'

class App extends Component {
  render() {
    const { gapi } = this.props;
    return (
      <div id="app">
        <Nav/>
        <Switch>
          <Route exact path='/' render={() => (
            <Redirect to="/rooms" />
          )} />
          <Route path='/about' component={About}/>
          <Route path='/new' component={New}/>
          <Route path='/rooms' render={() => (
            <RoomIndex gapi={gapi} />
          )}/>

        </Switch>
      </div>
 );
  }
}

export default App;
