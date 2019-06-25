import React from 'react';
import { Menu, Header } from 'semantic-ui-react';

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
          WatchPoll
        </Menu.Item>
        <Menu.Menu
          position="right"
        >
          <Menu.Item>
            About
          </Menu.Item>
          <Menu.Item>
            New
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
