import React from 'react'

import ControlPanel from "./ControlPanel";
import VideoPlayer from "./VideoPlayer";


export const VideoContainer = ({videoPlayerProps, controlPanelProps}) => (
  <section id="video-container">
    <VideoPlayer {...videoPlayerProps}/>
    <ControlPanel {...controlPanelProps} />
  </section>
)