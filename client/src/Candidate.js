import React from 'react';
import { Image, Icon } from 'semantic-ui-react';
import Axios from 'axios';

import { GOOGLE_API_KEY } from './constants'


class Candidate extends React.Component {
  constructor(props) {
    super(props);
    this.state = { thumbnail: null, title: null };
  }

  render() {
    const {points,} = this.props
    return (
      <article className="video-candidate">
        <Image
          className="thumbnail"
          size="small"
          src="https://i.ytimg.com/vi/dQw4w9WgXcQ/hqdefault.jpg?sqp=-oaymwEZCPYBEIoBSFXyq4qpAwsIARUAAIhCGAFwAQ==&amp;rs=AOn4CLD0LAGwiQ3ms-wTXdtIeZvnXLoQmg"
        />
        <h3 className="video-candidate__name">Rick the God</h3>
        <span className="video-candidate__icon-container">
          <Icon size="large" name="up arrow" />
          {points}
        </span>
      </article>
    )
  }
 };

export default Candidate;