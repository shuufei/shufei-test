import React from 'react';

export class Clock extends React.Component {
  constructor(props) {
    super(props);
    this.state = { date: new Date() };
  }

  componentDidMount() {
    console.log('--- did mount');
    this.timerID = setInterval(() => this.tick(), 1000);
  }

  componentWillUnmount() {
    console.log('--- will unmount');
    clearInterval(this.timerID);
  }

  tick() {
    this.setState({date: new Date('2020-02-02T00:00:00Z')});
    // this.state.date = new Date(); // not work
  }

  render() {
    return (
      <div>
        <h1>Hello, world!</h1>
        <h2>It is {this.state.date.toLocaleTimeString()}</h2>
      </div>
    );
  }
}