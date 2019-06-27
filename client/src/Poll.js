import React from 'react';
import _ from 'lodash';
import { Card, Image, Icon, Grid, Item, Button, Label } from 'semantic-ui-react';

import Candidate from './Candidate';
import axios from 'axios';

class Poll extends React.Component {
  constructor(props) {
    super(props);
    this.state = {}
  }
  render() {
    const candidates = this.props.standings.map(data => <Candidate {...data} key={data.video_id} />)
    return (
      <section id="poll">
        {candidates}
      </section>
    );
  }

  componentDidMount() {
    const { standings } = this.props;
    const video_uids = standings.map(standing => standing.video_uid);
    this.getVideosInfo(video_uids);
  }
}

export default Poll;

{/* <img id="img" class="style-scope yt-img-shadow" alt="" width="246" src="https://i.ytimg.com/vi/dQw4w9WgXcQ/hqdefault.jpg?sqp=-oaymwEZCPYBEIoBSFXyq4qpAwsIARUAAIhCGAFwAQ==&amp;rs=AOn4CLD0LAGwiQ3ms-wTXdtIeZvnXLoQmg"></img> */}