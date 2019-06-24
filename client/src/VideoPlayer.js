import React from 'react';
import { Placeholder } from 'semantic-ui-react';
import YouTube from 'react-youtube';
import reframe from 'reframe.js';

class VideoPlayer extends React.Component {
  constructor() {
    super();
    this.state = { someKey: 'someValue' };
  }

  render() {
    return (
      <section id="video-container">
        <iframe
          id="video-player"
          width="560" height="315"
          src="https://www.youtube.com/embed/dQw4w9WgXcQ"
          frameBorder="0"
          allowFullScreen
          title="youtube-video"
        >
        </iframe>
      </section>
    );
  }

  componentDidMount() {
    console.log('reframing')
    reframe('iframe');
  }
}

export default VideoPlayer;
