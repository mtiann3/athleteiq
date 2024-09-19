//
//  Weight.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 9/19/24.
//

import Foundation
import SwiftData

@Model
class Weight {
    var date: Date
    var weight: Double
   
    init(date: Date, weight: Double) {
        self.date = date
        self.weight = weight

    }
    
}
