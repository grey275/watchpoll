import React from 'react';
import ReactDOM from 'react-dom';

import './styles/index.scss';
import 'semantic-ui-css/semantic.min.css';

import * as serviceWorker from './serviceWorker'

import App from './App';
import { GOOGLE_API_KEY } from './constants'

const { gapi } = global;

const start = () => {
  gapi.client.init({
    apiKey: GOOGLE_API_KEY,
  })

  ReactDOM.render(<App gapi={gapi} />, document.getElementById('root'))

  // If you want your app to work offline and load faster, you can change
  // unregister() to register() below. Note this comes with some pitfalls.
  // Learn more about service workers: https://bit.ly/CRA-PWA
  serviceWorker.unregister();
}

gapi.load('client', start)