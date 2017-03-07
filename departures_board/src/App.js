import React, { Component } from 'react';
import './App.css';
import Departures from './Departures.js';

class App extends Component {
   
   constructor(props) {
    super(props);
    
    this.state = {
      intro_text: "To get started, edit <code>src/App.js</code> and save to reload!",
      json_obj: {}
    };
   }


  render() {
    return (
      <div className="App">
         <div className="board">
               <div className="header">
                  <span className="board_detail current_date">current_date</span>
                  <span className="board_title">Departures</span>
                  <span className="board_detail current_time">current_time</span>
               </div>
               <div className="board_info">
                  <Departures />
               </div>
         </div>
      </div>
    );
  }
}

export default App;

