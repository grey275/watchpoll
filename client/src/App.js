import React, { Component } from 'react';

import { API_WS_ROOT } from './constants';
import Room from './Room';
import Nav from './Nav';

class App extends Component {
  constructor(props) {
    super(props)
    this.state = {
      message: 'Click the button to load data!'
    }
  }
  render() {
    return (
      <div id="app">
        <Nav/>
        <Room gapi={this.props.gapi}/>
      </div>
 );
  }
}

export default App;
