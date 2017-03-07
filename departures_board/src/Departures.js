import React, { Component } from 'react';
import './Departures.css';

// This is the table element for the departures information.
class Departures extends Component {

   constructor(props) {
      super(props);

      this.state = {
         json_obj: {},
         rows: []
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
            this.setState({ rows: this.state.json_obj.departures });
            return;
         } else {
            console.warn('error');
         }
      };
      request.open('GET', 'http://138.197.120.108:4000/api/v1/board');
      request.send();
   }

   render() {
      return (
         <table className="departures_table">
            <thead>
               <tr>
                  <th>CARRIER</th>
                  <th className="th_time">TIME</th>
                  <th className="th_destination">DESTINATION</th>
                  <th className="th_train">TRAIN#</th>
                  <th className="th_track">TRACK#</th>
                  <th className="th_status">STATUS</th>
               </tr>
            </thead>
            <tbody> 
            { 
               this.state.rows.map((row) => 
                     <tr>
                        <td className="td_carrier">MBTA</td>
                        <td className="td_time">{row[6]}</td>
                        <td className="td_destination">{row[2]}</td>
                        <td className="td_train">{row[1]}</td>
                        <td className="td_track">{row[3] ? row[3] : 'TBD'}</td>
                        <td className="td_status">{row[5]}</td>
                     </tr>)
            }
            </tbody>
         </table>
      );
   }
}

export default Departures;

