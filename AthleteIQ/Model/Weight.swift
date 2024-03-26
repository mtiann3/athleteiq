//
//  Weight.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/25/24.
//

import Foundation
import SwiftData

@Model
class Weight {
    var date: Date
    var value: Double
    
    init(date: Date, value: Double) {
        self.date = date
        self.value = value
    }
}
