import React from 'react';
import _ from 'lodash';
import {SortableContainer, SortableElement } from 'react-sortable-hoc';
import arrayMove from 'array-move';

import Candidate from './Candidate';
import Axios from 'axios';
import { DOMAIN_NAME, API_ROUTE } from './constants';


const SortableItem = SortableElement(({value}) => value);

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
      key={`index-${index}`}
      index={index}
      sortIndex={index}
      value={value}
    />
  );
}

class Poll extends React.Component {

  constructor(props) {
    super(props);
    this.state = {
      preference_order: null,
    }
  }

  initPreferenceOrder = length => (
    _.shuffle( _.range(length))
      .map(index => ({origin_index: index}))
  )

  submitPreferenceOrder = () => {
    const { preference_order } = this.state;
    const { standings, poll_id, session_id, room_id } = this.props;
    const order =  preference_order.map(({origin_index}) => (
      standings[origin_index].candidate_video_id
    ));
    console.log('order: ', order)
    Axios.post(
      `http://${DOMAIN_NAME}/${API_ROUTE}/rooms/${room_id}/video_polls/${poll_id}/preference_orders`,
      {
        session_id,
        poll_id,
        preference_order: order,
      }
    )
  }

  getOrderedCandidateVideos() {
    const { candidate_videos_with_points } = this.props;
    const { preference_order } = this.state
    if (preference_order && candidate_videos_with_points ) {
      return preference_order.map(preference => candidate_videos_with_points[preference.origin_index])
    }
    return []
  }

  componentDidUpdate(_, {preference_order}) {
    const { candidate_videos_with_points } = this.props;
    if (preference_order === null && (candidate_videos_with_points.length > 0)) {
      const length = candidate_videos_with_points.length;
      this.setState({preference_order: this.initPreferenceOrder(length)})
      return
    }
  }

  onSortEnd = ({oldIndex, newIndex}) => {
    this.setState(({preference_order}) => {
      const new_preference_order = arrayMove(preference_order, oldIndex, newIndex);
      new_preference_order[newIndex].moved = true;
      return {preference_order: new_preference_order};
    });
    this.submitPreferenceOrder()
  };

  render () {
    const {candidate_videos_with_points } = this.props;
let items;
    if (candidate_videos_with_points) {
      const ordered = this.getOrderedCandidateVideos()
      items = ordered.map((video_data, index) => (
        <SortableCandidate video_data={video_data} index={index} />
      ));
    } else {
      items = [];
    }

    return (
      <SortableList
        items={items}
        onSortEnd={this.onSortEnd}
      />
    );
  }
}

export default Poll;

{/* <img id="img" class="style-scope yt-img-shadow" alt="" width="246" src="https://i.ytimg.com/vi/dQw4w9WgXcQ/hqdefault.jpg?sqp=-oaymwEZCPYBEIoBSFXyq4qpAwsIARUAAIhCGAFwAQ==&amp;rs=AOn4CLD0LAGwiQ3ms-wTXdtIeZvnXLoQmg"></img> */}