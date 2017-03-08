import React, { Component } from 'react';
import './App.css';
import Departures from './Departures.js';

class App extends Component {
   
   constructor(props) {
       super(props);
       
      this.state = {
         selectedStation: "south",
         curr_day: "",
         curr_date: "",
         curr_time: ""
      };

      this.handleStationChange = this.handleStationChange.bind(this);
   }

   componentDidMount() {
      this.tick(); // call tick once now
      this.timerID = setInterval(
         () => this.tick(),
         10000 // set for every ten seconds
      );
   }

   componentWillUnmount() {
    clearInterval(this.timerID);
   }

   handleStationChange(event) {
      this.setState({ selectedStation: event.target.value });
   }

   tick() {
      var date = new Date();
      const days = ['Sunday','Monday','Tuesday','Wednesday','Thursday','Friday','Saturday'];
      var hour = date.getHours();
      hour = hour > 12 ? hour - 12 : hour;
      hour = hour === 0 ? 12 : hour;
      var minute = date.getMinutes();
      minute = minute < 10 ? "0" + minute : minute;
      var half = date.getHours() > 11 ? " PM" : " AM";
      var curr_time = hour + ":" + minute + half;
      this.setState({
         curr_day: days[date.getDay()],
         curr_date: date.getMonth() + "-" + date.getDate() + "-" + (1900 + date.getYear()),
         curr_time: curr_time
      });
   }


  render() {
    return (
      <div className="App">
         <div className="board">
               <div className="header">
                  <span className="board_detail current_date">
                        {this.state.curr_day}<br />{this.state.curr_date}
                  </span>
                  <span className="board_title">
                     <div className="departures_title">Departures</div>
                     <div className="station_select">
                        <select className="station_select" defaultValue={this.state.selectedStation} 
                                    onChange={this.handleStationChange}>
                              <option value="north">North Station</option>
                              <option value="south">South Station</option>
                        </select>
                     </div>
                  </span>
                  <span className="board_detail current_time">
                        CURRENT TIME<br />{this.state.curr_time}
                  </span>
               </div>
               <div className="board_info">
                  <Departures station={this.state.selectedStation}/>
               </div>
         </div>
      </div>
    );
  }
}

export default App;

