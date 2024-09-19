//
//  Sleep.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 9/19/24.
//

import Foundation
import SwiftData

@Model
class Sleep {
    var date: Date
    var time: Double
   
    init(date: Date, time: Double) {
        self.date = date
        self.time = time

    }
    
}
