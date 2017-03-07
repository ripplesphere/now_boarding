import React, { Component } from 'react';

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
                  <th>TIME</th>
                  <th>DESTINATION</th>
                  <th>TRAIN#</th>
                  <th>TRACK#</th>
                  <th>STATUS</th>
               </tr>
            </thead>
            <tbody> 
            { 
               this.state.rows.map((row) => 
                     <tr><td>{row[0]}</td></tr>)
            }
            </tbody>
         </table>
      );
   }
}

export default Departures;

