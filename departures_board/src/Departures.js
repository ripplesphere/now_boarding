import React, { Component } from 'react';
import './Departures.css';

// This is the table element for the departures information.
class Departures extends Component {

   constructor(props) {
      super(props);

      this.state = {
         rows: []
      };

      this.rows_complete = [];
      this.selectedStation = ""; 
      this.clickedDestination= this.clickedDestination.bind(this);

   }

   loadFromServer() {
      this.selectedStation = this.props.station;
      this.rows_complete = []; // clear this variable
      var request = new XMLHttpRequest();
      request.onreadystatechange = (e) => {
         if (request.readyState !== 4) {
            return;
         }

         if (request.status === 200) {
            // console.log('success', request.responseText);
            this.setState({ rows: JSON.parse(request.responseText).departures });
            return;
         } else {
            console.warn('error');
         }
      };
      request.open('GET', 'http://138.197.120.108:4000/api/v1/board?station=' + 
                             this.props.station);
      request.send();
   }

   // User selected destination; if all rows showen show only rows of selected desination,
   //  else display all the rows (logic is other way around)
   clickedDestination(event) {
      var destination = event.target.outerText;
      if (this.rows_complete.length > 0) {
         let tmp_c_rows = []; // save complete dataset 
         this.rows_complete.map((row) =>
                  tmp_c_rows.push(row)
               );
         this.setState({ rows: tmp_c_rows });
         this.rows_complete = [];
      } else {
         let tmp_c_rows = []; // save complete dataset 
         this.state.rows.map((row) =>
                  tmp_c_rows.push(row)
               );
         this.rows_complete = tmp_c_rows;
         let tmp_f_rows = []; // create a filtered dataset
         this.state.rows.map((row) => row[1] === destination ? tmp_f_rows.push(row) : true);
         this.setState({ rows: tmp_f_rows })
      }
   }

   componentDidMount() {
      this.loadFromServer();
   }

   render() {
      if ( this.selectedStation && this.selectedStation !== this.props.station) {
         this.loadFromServer();
      }
      var i = 0;
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
                     <tr key={i++}>
                        <td className="td_carrier" key={i++}>MBTA</td>
                        <td  className="td_time" key={i++}>{row[5]}</td>
                        <td  className="td_destination" key={i++} 
                              onClick={this.clickedDestination}>{row[1]}</td>
                        <td  className="td_train" key={i++}>{row[0]}</td>
                        <td  className="td_track" key={i++}>{row[3] ? row[3] : 'TBD'}</td>
                        <td  className="td_status" key={i++}>{row[4]}</td>
                     </tr>)
            }
            </tbody>
         </table>
      );
   }
}

export default Departures;

