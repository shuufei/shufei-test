import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';

// ReactDOM.render(<App />, document.getElementById('root'));

// function formatName(user) {
//   return `${user.firstName} ${user.lastName}`;
// }

// const user = {
//   firstName: 'Harper',
//   lastName: 'Perez'
// };

// const element = <h1>Hello, {formatName(user)}</h1>

// ReactDOM.render(
//   element,
//   document.getElementById('root')
// );

// function Welcome(props) {
//   return <h1>Hello, {props.name}</h1>
// }

ReactDOM.render(
  <App />,
  document.getElementById('root')
);

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
