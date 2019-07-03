import React from 'react';
import { Statistic, Button } from 'semantic-ui-react';


const timeFromString = (str) => (new Date(str).getTime());

const getSecondsTillNextVideo = (next_video_time) => (
    Math.round((new Date().getTime() - timeFromString(next_video_time)) / 1000)
)


const Stats = ({num_of_users, seconds_till_next_video}) => (
  <Statistic.Group size="mini" className="stats">
    <Statistic>
      <Statistic.Value>
        {num_of_users}
      </Statistic.Value>
      <Statistic.Label>
        Viewers
      </Statistic.Label>
    </Statistic>
    <Statistic>
      <Statistic.Value>
        {seconds_till_next_video || 0}<small>s</small>
      </Statistic.Value>
      <Statistic.Label>
        Next Video
      </Statistic.Label>
    </Statistic>
  </Statistic.Group>
)


class ControlPanel extends React.Component {

  render () {
    const {next_video_time, num_of_users} = this.props;
    const stats = {
      num_of_users,
      seconds_till_next_video: getSecondsTillNextVideo(next_video_time),
    }

    return (
      <section
        id='control-panel'
      >
        <Stats {...stats} />
        <Button>Live</Button>
      </section>
    )
  }
}

export default ControlPanel