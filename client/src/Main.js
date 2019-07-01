import React from 'react'
import { Switch, Route } from 'react-router-dom'

import Room from './Room'
import About from './About'
import New from './New'
import RoomIndex from'./RoomIndex'

//import New from './New'

const Main = ({gapi}) => (
    <main>
      <Switch>
        <Route exact path='/' render={() => <Room gapi={gapi} />} />
        <Route path='/about' component={About}/>
        <Route path='/new' component={New}/>
        <Route path='/rooms' component={RoomIndex}/>
      </Switch>
    </main>
  )

  export default Main