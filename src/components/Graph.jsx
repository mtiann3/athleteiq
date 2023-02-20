import React from 'react'
import { Chart } from "react-google-charts";
import '../App.css';
const Graph = () => {
     const data = [
        ["Date", "Weight", { role: "style" }],
        ["1/2", 200, "#1a161a"], // RGB value
        ["1/12", 205, "#1a161a"], // English color name
        ["1/30", 215, "#1a161a"],
        ["2/13", 225, "#1a161a"], // CSS-style declaration
      ];
  return (
    <div className='chartOne'>
    <Chart className='' chartType="ColumnChart" width="100%" height="400px" data={data} />

    </div>
  )
}

export default Graph