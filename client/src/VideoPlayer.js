import React from 'react';
import { Placeholder } from 'semantic-ui-react';
import YouTube from 'react-youtube';


const timeFromString = (str) => (new Date(str).getTime());

class VideoPlayer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      player: null,
    }
  }

  initPlayerOpts = () => {
    const { start_time, runtime, video_uid} = this.props;
    const current_time = new Date().getTime()
    const current_video_time = current_time - timeFromString(start_time);

    this.setState({
      player_opts: {
        playerVars: {
          autoplay: 0,
          controls: 0,
          start: 0,
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
    return (
      <React.Fragment>
        <YouTube
          className="video-player"
          videoId={this.props.video_uid}
          opts={player_opts}
        />
      </React.Fragment>

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