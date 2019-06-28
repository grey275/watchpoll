import React from 'react';
import { Image, Icon } from 'semantic-ui-react';
import { sortableElement, SortableElement } from 'react-sortable-hoc';

const Candidate = ({channelTitle, title, points, thumbnails}) => {
  const displayed_thumbnail_url = thumbnails.medium.url
  return (
    <article className="video-candidate">
      <Image
        className="thumbnail"
        size="small"
        src={displayed_thumbnail_url}
      />
      <h3 className="video-candidate__name">{title}</h3>
      <span className="video-candidate__icon-container">
        <Icon size="large" name="up arrow" />
        {points}
      </span>
    </article>
  )
}

export default Candidate;