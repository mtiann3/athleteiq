//
//  Cardio.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 9/19/24.
//

import Foundation
import SwiftData

@Model
class Cardio {
    var date: Date
    var time: Double
    var caloriesBurned: Int
   
    init(date: Date, time: Double, caloriesBurned: Int) {
        self.date = date
        self.time = time
        self.caloriesBurned = caloriesBurned
    }
    
}
