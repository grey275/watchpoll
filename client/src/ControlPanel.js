import React from 'react';
import { Statistic } from 'semantic-ui-react';

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
    <Statistic>
      <Statistic.Value>
        {next_video_time}<small>s</small>
      </Statistic.Value>
      <Statistic.Label>
        Next Video
      </Statistic.Label>
    </Statistic>
  </Statistic.Group>
)

const ControlPanel = ({next_video_time, num_of_users}) => {
  const stats = {
    num_of_users,
    next_video_time,
  }
  return (
    <section
      id='control-panel'
    >
      {
        <Stats {...stats} />
      }
    </section>
  )
}

export default ControlPanel