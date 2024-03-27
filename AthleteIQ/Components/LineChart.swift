//
//  LineChart.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/26/24.
//

import SwiftUI
import SwiftUICharts

struct LineChart: View {
    let data: [Double]
    let title: String

    var body: some View {
        VStack{
//            LineChartView(data: data, title: "Bench Press Progress",form: ChartForm.extraLarge, rateValue: Int(calculateRateChange()), dropShadow: true)
            LineChartView(data: data, title: "",legend: "Change In Estimated 1RM Since Last Entry" ,form: ChartForm.extraLarge ,rateValue: Int(calculateRateChange() ?? 0),dropShadow: true)
        }
    }
    
    // Function to calculate rate change from the second to last data point
    func calculateRateChange() -> Double? {
        guard data.count >= 2 else {
            return 0
        }
        let secondToLast = data[data.count - 2]
        let last = data[data.count - 1]
        
        // Assuming rate change is a simple percentage increase
        return ((last - secondToLast) / secondToLast) * 100
    }
}


