## Title

watchpoll (working title)

## Description

What if youtube's autoplay feature was democratized?

Instead of some etherial youtube algorithm deciding the next video, it should be people you can talk to and interact with.

An interactive site to allow multiple users to view videos together and to vote what videos they want to see next. The video that has the most votes is then played

## User Stories(as a user)

- I want to vote on videos that I want to watch

  - to watch that video with others
  - to talk about the video with others

- I want to watch videos that others have voted on
  - to watch that video with others
  - to talk about the video with others

## Scenarios

### MVP

- the room is initialized

  - the 'heats' for candidate videos

  videos = [vid1, vid2, vid3, vid4 .....]

  get
  nextHeat(videopool, played) => next heat [vid2, vid9, ...]

- the user joins room

  - they can watch the currently playing video, and the rest of the ui
  - once they input their username, they can see messages in the chatroom and send their own
  - they join the chatroom
  - a timer counts down to 0, when the poll closes
  - the next video then plays

- a user clicks on one of the video candidates' vote button

  - the vote count for that video increments
  - changes the final outcome for the selection

- a user clicks on one of the video candidate's video link

  - a new tab opens up with that video's youtube page

- a user sends a message to the chatroom

  - shows up in the chat, visible to all users
  - chat room is for chat purposes and name changes

- a user clicks on the about page

  - a popup window displays project/team information
  - the route changes to /<appname>/about

- the next video timer reaches 0
  - the candidate with the greatest number of votes is selected
  - that video is played
  - the timer resets
  - the next

- a user clicks the change name button

  - a form which allows him to edit his name pops up
  - when submitted, their name is changed and the chatroom is notified

- Create Button - will be used to create a new room

- Create a pop up page that allow user to select a theme and seed the video list themselves.

- fork room

## Wireframes

## Routes

/ - homepage

- ## /api
- ## /socket

## ERD
