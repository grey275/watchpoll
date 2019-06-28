import React from 'react';
import { Placeholder } from 'semantic-ui-react';
import YouTube from 'react-youtube';

class VideoPlayer extends React.Component {
  render() {
    return (
        <YouTube
          className="video-player"
          videoId="dQw4w9WgXcQ"
          opts={{}}
        />
    );
  }
}

const VideoContainer = (props) => (
  <section id="video-container">
    <VideoPlayer {...props}/>
  </section>
)


export default VideoContainer;