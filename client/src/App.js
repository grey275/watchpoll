import React, { Component } from 'react';

import Nav from './Nav';
import Main from './Main';

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
        <Main gapi={this.props.gapi}/>
      </div>
 );
  }
}

export default App;
