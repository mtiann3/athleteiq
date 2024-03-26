//
//  Exercise.swift
//  AthleteIQ
//
//  Created by Mike Iannotti on 3/25/24.
//

import Foundation
import SwiftData

@Model
class Exercise {
    var name: String
    var category: String
    var date: Date
    var weight: Int
    var repetitions: Int
    var sets: Int
    
    init(name: String, category: String, date: Date, weight: Int, repetitions: Int, sets: Int) {
        self.name = name
        self.category = category
        self.date = date
        self.weight = weight
        self.repetitions = repetitions
        self.sets = sets
    }
    
}
