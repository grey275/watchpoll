import React from 'react';
import { Menu, Header } from 'semantic-ui-react';
import { Link } from 'react-router-dom';

class Nav extends React.Component {
  constructor() {
    super();
    this.state = { someKey: 'someValue' };
  }

  render() {
    return (
      <Menu as="nav" id="nav">
        <Menu.Item
          as={Header}
        >
          {/* WatchPoll */}
          <Link to='/'>WatchPoll</Link>
        </Menu.Item>
        <Menu.Menu
          position="right"
        >
          <Menu.Item>
            {/* About */}
            <Link to='/about'>About</Link>
          </Menu.Item>
          <Menu.Item>
            {/* New */}
            <Link to='/new'>New</Link>
          </Menu.Item>
        </Menu.Menu>
      </Menu>
    );
  }

  componentDidMount() {
    this.setState({ someKey: 'otherValue' });
  }
}

export default Nav;
