import React, { Component } from 'react';
import axios from 'axios';

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
        <Room/>
      </div>
 );
  }
}

export default App;
