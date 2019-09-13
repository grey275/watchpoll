import React from 'react';
import { Placeholder } from 'semantic-ui-react';
import YouTube from 'react-youtube';
const YT = global.YT;


const timeFromString = (str) => (new Date(str).getTime());

export default class VideoPlayer extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      player_opts: null,
    }
  }

  initPlayerOpts = () => {
    const { start_time, runtime, video_uid} = this.props;
    const current_time = new Date().getTime()
    const current_video_seconds = (current_time - timeFromString(start_time)) / 1000;
    console.log('current time: ', current_video_seconds);

    this.setState({
      player_opts: {
        playerVars: {
          autoplay: 1,
          controls: 1,
          start: current_video_seconds,
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
    const { onPlay, video_uid } = this.props;
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