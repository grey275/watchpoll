import React from 'react';
import _ from 'lodash';
import {SortableContainer, SortableElement } from 'react-sortable-hoc';

import Candidate from './Candidate';


const SortableItem = SortableElement(({value}) => <li>{value}</li>);

const SortableList = SortableContainer(({items}) => {
  return (
    <ul>
      {items.map((value, index) => (
        <SortableItem key={`item-${index}`} index={index} value={value} />
      ))}
    </ul>
  );
});

const SortableCandidate = ({ video_data, index }) => {
  const value = <Candidate {...video_data} />
  return (
    <SortableItem value={value}
      key={video_data.video_id}
      index={index}
      sortIndex={index}
      value={value}
    />
  );
}

class Poll extends React.Component {
  render () {
    const {standings_with_details} = this.props;

    let items = standings_with_details.map((video_data, index) => (
      <SortableCandidate video_data={video_data} index={index} />
    ));

    return (
      <SortableList
        items={items}
      />
    );
  }
}

export default Poll;

{/* <img id="img" class="style-scope yt-img-shadow" alt="" width="246" src="https://i.ytimg.com/vi/dQw4w9WgXcQ/hqdefault.jpg?sqp=-oaymwEZCPYBEIoBSFXyq4qpAwsIARUAAIhCGAFwAQ==&amp;rs=AOn4CLD0LAGwiQ3ms-wTXdtIeZvnXLoQmg"></img> */}