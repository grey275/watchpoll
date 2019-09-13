import React from 'react';
import { Image, Icon, Placeholder } from 'semantic-ui-react';

const Candidate = ({channelTitle, title, points, thumbnails}) => {
  return (
    <article className="video-candidate">
      {thumbnails
        ? <Image
            className="thumbnail"
            size="small"
            src={thumbnails.medium.url}
          />
        : <Placeholder />
      }
      <h3 className="video-candidate__name">{title}</h3>
      <span className="video-candidate__icon-container">
        <Icon size="large" name="up arrow" />
        {points}
      </span>
    </article>
  )
}

export default Candidate;