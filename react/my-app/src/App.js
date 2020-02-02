import React, { Profiler } from 'react';
// import logo from './logo.svg';
import './App.css';
import { Clock } from './components/Clock';
import { Toggle } from './components/Toggle';
import { Greeting } from './components/Greeting';
import { LoginControl } from './components/LoginControl';
import { NameForm } from './components/NameForm';
import { Calculator } from './components/Calculator';
import { Example } from './components/StateHookTest';

function NumberList(props) {
  const numbers = props.numbers;
  const listItems = numbers.map(v => <li key={v.toString()}>{v}</li>);
  return (
    <ul>{listItems}</ul>
  )
}

function App() {
  return (
    <>
      <Clock />
      <Clock />
      <Clock />
      <Toggle />
      <Greeting isLoggedIn={true} />
      <LoginControl isLoggedIn={true} />
      <NumberList numbers={[1, 2, 3, 4, 5]} />
      <NameForm />
      <Profiler id="Calculator01" onRender={(id, phase, ad, bd, s, c, i) => console.log('--- profiler : ', id, phase, ad, bd, s, c, i)}>
        <Calculator />
      </Profiler>
      <Example></Example>
    </>
  );
}

export default App;
