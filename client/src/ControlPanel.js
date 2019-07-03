import React from 'react';
import CountDown from 'react-countdown-now';
import { Statistic, Button } from 'semantic-ui-react';


const timeFromString = (str) => (new Date(str).getTime());

const getSecondsTillNextVideo = (next_video_time) => (
    Math.round((timeFromString(next_video_time) - new Date().getTime()) / 1000)
)


const CountdownRenderer = ({ hours, minutes, seconds, completed }) => {
  const minutes_display = minutes
    ? <React.Fragment>{minutes}<small>m</small></React.Fragment>
    : ''

  const seconds_display = <React.Fragment>{seconds}<small>s</small></React.Fragment>
  if (completed) {
    // Render a completed state
    return 'switching...'

  } else {
    // Render a countdown
    return (
      <Statistic>
        <Statistic.Value>{minutes_display}{seconds_display}</Statistic.Value>;
        <Statistic.Label> Next Video </Statistic.Label>
      </Statistic>
    )
  }
};

const Stats = ({num_of_users, next_video_time}) => (
  <Statistic.Group size="mini" className="stats">
    <Statistic>
      <Statistic.Value>
        {num_of_users}
      </Statistic.Value>
      <Statistic.Label>
        Viewers
      </Statistic.Label>
    </Statistic>
  </Statistic.Group>
)


class ControlPanel extends React.Component {
  onNextVideo = () => {
    this.forceUpdate()
  }

  render () {
    const {next_video_time, num_of_users, onSyncClick} = this.props;
    console.log('seconds', )
    console.log(timeFromString(next_video_time))
    return (
      <section
        id='control-panel'
      >
        <Stats
          next_video_time={next_video_time}
          num_of_users={num_of_users}
        />
        <Button onClick={onSyncClick} >Sync</Button>
      </section>
    )
  }
}

export default ControlPanel