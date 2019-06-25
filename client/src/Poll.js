import React from 'react';

import _ from 'lodash';
import { Card, Image, Icon, Grid, Item, Button, Label } from 'semantic-ui-react';

const Candidate = () => {
  return (
    <Item>
      <Item.Image size='small' src='https://i.ytimg.com/vi/dQw4w9WgXcQ/hqdefault.jpg?sqp=-oaymwEZCPYBEIoBSFXyq4qpAwsIARUAAIhCGAFwAQ==&amp;rs=AOn4CLD0LAGwiQ3ms-wTXdtIeZvnXLoQmg' />

      <Item.Content>
        <Item.Header as='a'>This is the Youtube Title</Item.Header>
        <Item.Meta>Aliqua dolore labore sit ullamco occaecat. </Item.Meta>
        <Item.Description>
        </Item.Description>
        <Item.Extra>
        </Item.Extra>
        <span className="points"><Icon size="large" name="up arrow"/>23</span>
      </Item.Content>
    </Item>
  );
}

const NewCandidatePresenter = () => (
  <article className="video-candidate">
    <Image
      className="thumbnail"
      size="small"
      src="https://i.ytimg.com/vi/dQw4w9WgXcQ/hqdefault.jpg?sqp=-oaymwEZCPYBEIoBSFXyq4qpAwsIARUAAIhCGAFwAQ==&amp;rs=AOn4CLD0LAGwiQ3ms-wTXdtIeZvnXLoQmg"
    />
    <h3 className="video-candidate__name">Rick the God</h3>
    <span className="video-candidate__icon-container">
      <Icon size="large" name="up arrow" />
      100
    </span>
  </article>
);
class Poll extends React.Component {
  render() {
    return (
      <section id="poll">
        {_.times(15, NewCandidatePresenter)}
      </section>
    );
  }

  componentDidMount() {
    this.setState({ someKey: 'otherValue' });
  }
}

export default Poll;

{/* <img id="img" class="style-scope yt-img-shadow" alt="" width="246" src="https://i.ytimg.com/vi/dQw4w9WgXcQ/hqdefault.jpg?sqp=-oaymwEZCPYBEIoBSFXyq4qpAwsIARUAAIhCGAFwAQ==&amp;rs=AOn4CLD0LAGwiQ3ms-wTXdtIeZvnXLoQmg"></img> */}