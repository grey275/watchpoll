import React from 'react';
import { Placeholder } from 'semantic-ui-react';
import YouTube from 'react-youtube';
const YT = global.YT;


const timeFromString = (str) => (new Date(str).getTime());

class NewVideoPlayser extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      player: null,
    }
  }

  componentDidMount() {
    const player = new YT.player()
  }
}

class VideoPlayer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      player_opts: null,
    }
  }

  initPlayerOpts = () => {
    const { start_time, runtime, video_uid} = this.props;
    const current_time = new Date().getTime()
    const current_video_time = (current_time - timeFromString(start_time)) / 1000;
    console.log('current time: ', current_video_time);

    this.setState({
      player_opts: {
        playerVars: {
          autoplay: 1,
          controls: 1,
          start: current_video_time,
        }
      }
    });
  }

  componentDidMount() {
    this.initPlayerOpts()
  }

  componentDidUpdate(prevProps){
    const { video_uid } = this.props;
    if (video_uid !== prevProps.video_uid) {
      this.initPlayerOpts();
    }
  }

  render() {
    const { player_opts } = this.state;
    const { onPlay, video_uid } = this.props
    return (
      player_opts
      ? <YouTube
          className="video-player"
          videoId={video_uid}
          opts={player_opts}
          onPlay={onPlay}
        />
      : <Placeholder className="video-player" fluid>
          <Placeholder.Image />
        </Placeholder>

    )
  }
}

// const VideoPlayer = ({start_time, runtime, video_uid}) =>  {
//   const start_time_milliseconds = timeFromString(start_time);
//   console.log('start', start_time_milliseconds)
//   console.log('now', current_time)
//   console.log('current', current_video_time)
//   console.log('time', current_video_time / 1000);
//   const synchronizePlayer = (player) => {
//     player.seekTo(current_video_time)
//   }
// }

const VideoContainer = (props) => (
  <section id="video-container">
    <VideoPlayer {...props}/>
  </section>
)


export default VideoContainer;