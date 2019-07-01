import React from 'react';
import { Placeholder } from 'semantic-ui-react';
import YouTube from 'react-youtube';

const timeFromString = (str) => (new Date(str).getTime());


const VideoPlayer = ({start_time, runtime, video_uid}) =>  {
  const start_time_milliseconds = timeFromString(start_time);
  const current_time = new Date().getTime()
  const current_video_time = current_time - start_time_milliseconds;
  console.log('start', start_time_milliseconds)
  console.log('now', current_time)
  console.log('current', current_video_time)
  console.log('time', current_video_time / 1000);
  const synchronizePlayer = (player) => {
    player.seekTo(current_video_time)
  }

  const opts = {
    playerVars: {
      autoplay: 1,
      start: current_video_time / 1000,
    }
  }

  return (
      <YouTube
        className="video-player"
        videoId={video_uid}
        start={3}
        opts={opts}
        onStateChange
      />
  );
}

const VideoContainer = (props) => (
  <section id="video-container">
    <VideoPlayer {...props}/>
  </section>
)


export default VideoContainer;