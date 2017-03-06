import React, { Component } from 'react';
import './App.css';

class App extends Component {
   
   constructor(props) {
    super(props);
    
    this.state = {
      intro_text: "To get started, edit <code>src/App.js</code> and save to reload!",
      json_obj: {}
    };
   }

    componentDidMount() {
      var request = new XMLHttpRequest();
      request.onreadystatechange = (e) => {
         if (request.readyState !== 4) {
            return;
         }

         if (request.status === 200) {
            console.log('success', request.responseText);
            this.setState({ json_obj: JSON.parse(request.responseText) });
            this.setState({ intro_text: this.state.json_obj.timestamp });
         } else {
            console.warn('error');
         }
      };
      request.open('GET', 'http://138.197.120.108:4000/api/v1/board');
      request.send();
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
                  <table>
                     <tbody>
                        <tr>
                           <th>TIME</th>
                           <th>DESTINATION</th>
                           <th>TRAIN#</th>
                           <th>TRACK#</th>
                           <th>STATUS</th>
                        </tr>
                        <tr><td></td><td></td><td></td><td></td><td></td></tr>
                     </tbody>
                  </table>
               </div>
         </div>
      </div>
    );
  }
}

export default App;

