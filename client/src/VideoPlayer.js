import React from 'react';
import { Placeholder } from 'semantic-ui-react';
import YouTube from 'react-youtube';

class VideoPlayer extends React.Component {
  constructor() {
    super();
    this.state = { someKey: 'someValue' };
  }

  render() {
    const opts = {
      height: '648',
      width: '1152',
    };
    return (
      <section id="video-player">
        <YouTube
          opts={opts}
          videoId="dQw4w9WgXcQ"
        />
      </section>
    );
  }

  componentDidMount() {
    this.setState({ someKey: 'otherValue' });
  }
}

export default VideoPlayer;
